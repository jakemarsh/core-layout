//
//  Layout+LayoutComputable.swift
//  Steward
//
//  Created by Jake Marsh on 10/2/16.
//  Copyright © 2016 Magnus. All rights reserved.
//

import Foundation

public protocol LayoutComputable { func compute(with containerSize: CGSize) -> ComputedLayout }

extension Layout : LayoutComputable {
  public func compute(with containerSize: CGSize) -> ComputedLayout {
    func box(layout: Layout) -> LayoutBox {
      let boxed = LayoutBox(layout: layout)

      boxed.children = layout.children.map { box(layout: $0) }

      return boxed
    }

    let boxed = box(layout: self)

    YGNodeCalculateLayout(
      boxed.node,
      Float(containerSize.width),
      Float(containerSize.height),
      YGNodeStyleGetDirection(boxed.node)
    )

    func collect(box: LayoutBox) -> ComputedLayout {
      return ComputedLayout(
        identifier: box.identifier,
        frame: box.frame,
        children: box.children.map { collect(box: $0) }
      )
    }

    return collect(box: boxed)
  }
}

public typealias MeasureMode = YGMeasureMode

public struct MeasureOptions {
  public var width: Float; public var widthMode: MeasureMode
  public var height: Float; public var heightMode: MeasureMode

  public var containerSize: CGSize {
    var containerWidth = CGFloat.nan
    var containerHeight = CGFloat.nan

    switch widthMode {
    case .exactly, .atMost: containerWidth = width.isNaN ? CGFloat.greatestFiniteMagnitude : CGFloat(width)
    default: break
    }

    switch widthMode {
    case .exactly, .atMost: containerHeight = height.isNaN ? CGFloat.greatestFiniteMagnitude : CGFloat(height)
    default: break
    }

    return CGSize(width: containerWidth, height: containerHeight)
  }
}

fileprivate protocol YGNodeRefApplyable { func apply(to node: YGNodeRef!) }

extension SizeBehavior : YGNodeRefApplyable {
  func apply(to node: YGNodeRef!) {
    switch mode {
    case .flexibleShrinksButDoesntGrow: YGNodeStyleSetFlex(node, -1); break
    
    case .flexible(let units): YGNodeStyleSetFlex(node, Float(units)); break

    case .absolute(let w, let h):
      YGNodeStyleSetFlex(node, 0)

      if let width = w { YGNodeStyleSetWidth(node, width) }
      if let height = h { YGNodeStyleSetHeight(node, height) }
      
      break

    case .relative:
      YGNodeStyleSetFlex(node, 0)
      
      YGNodeSetMeasureFunc(node) {
        let context = YGNodeGetContext($0)
        let pointer: UnsafeMutableRawPointer = unsafeBitCast(context, to: UnsafeMutableRawPointer.self)
        let node = unsafeBitCast(pointer, to: LayoutBox.self)

        if let measure = node.measure {
          let measured = measure(
            MeasureOptions(width: $1, widthMode: $2, height: $3, heightMode: $4)
          )

          return YGSize(width: ceilf(Float(measured.width)), height: ceilf(Float(measured.height)))
        } else {
          return YGSize(width: .nan, height: .nan)
        }
      }

      break
    }
  }
}

extension ContainerBehavior : YGNodeRefApplyable {
  func apply(to node: YGNodeRef!) {
    switch primaryAxis {
    case .horizontal:
      YGNodeStyleSetFlexDirection(node, .row)
    case .vertical:
      YGNodeStyleSetFlexDirection(node, .column)
    }

    // TODO: Support RTL

    switch primaryAxisDistribution {
    case .leading: YGNodeStyleSetJustifyContent(node, .flexStart); break
    case .center: YGNodeStyleSetJustifyContent(node, .center); break
    case .trailing: YGNodeStyleSetJustifyContent(node, .flexEnd); break
    case .spaceAround: YGNodeStyleSetJustifyContent(node, .spaceAround); break
    case .spaceBetween: YGNodeStyleSetJustifyContent(node, .spaceBetween); break
    }
    
    switch secondaryAxisDistribution {
    case .leading: YGNodeStyleSetAlignItems(node, .flexStart); break
    case .center: YGNodeStyleSetAlignItems(node, .center); break
    case .trailing: YGNodeStyleSetAlignItems(node, .flexEnd); break
    case .stretch: YGNodeStyleSetAlignItems(node, .stretch); break
    }

    switch secondaryAxisDistributionWhenWrapping {
    case .leading: YGNodeStyleSetAlignContent(node, .flexStart); break
    case .center: YGNodeStyleSetAlignContent(node, .center); break
    case .trailing: YGNodeStyleSetAlignContent(node, .flexEnd); break
    case .stretch: YGNodeStyleSetAlignContent(node, .stretch); break
    case .spaceAround: YGNodeStyleSetAlignContent(node, .spaceAround); break
    case .spaceBetween: YGNodeStyleSetAlignContent(node, .spaceBetween); break
    }

    YGNodeStyleSetFlexWrap(node, shouldWrap ? .wrap : .noWrap)
    YGNodeStyleSetOverflow(node, overflow)
  }
}

private class LayoutBox {
  var identifier: String? = nil

  var node: YGNodeRef!

  var parent: LayoutBox!

  var children: [LayoutBox]! {
    didSet {
      while (YGNodeGetChildCount(node) > 0) { YGNodeRemoveChild(node, YGNodeGetChild(node, YGNodeGetChildCount(node) - 1)) }

      for (i, child) in children.enumerated() { YGNodeInsertChild(node, child.node, UInt32(i)) }
    }
  }

  var measure: ((MeasureOptions) -> CGSize)?

  init(layout: Layout) {
    self.node = YGNodeNew()

    YGNodeSetContext(node, unsafeBitCast(self, to: UnsafeMutableRawPointer.self))

    identifier = layout.identifier
    children = []

    layout.container?.apply(to: node)

    layout.size.apply(to: node)

    switch layout.size.mode {
    case .relative(let closure): self.measure = closure; break
    default: break
    }

    if let minWidth = layout.size.minimum?.width { YGNodeStyleSetMinWidth(node, Float(minWidth)) }
    if let minHeight = layout.size.minimum?.height { YGNodeStyleSetMinHeight(node, Float(minHeight)) }

    if let maxWidth = layout.size.maximum?.width { YGNodeStyleSetMaxWidth(node, Float(maxWidth)) }
    if let maxHeight = layout.size.maximum?.height { YGNodeStyleSetMaxHeight(node, Float(maxHeight)) }

    if let edges = layout.overriddenPosition {
      YGNodeStyleSetPositionType(node, .absolute)

      if let top = edges.top { YGNodeStyleSetPosition(node, .top, top) }
      if let start = edges.leading { YGNodeStyleSetPosition(node, .start, start) }
      if let bottom = edges.bottom { YGNodeStyleSetPosition(node, .bottom, bottom) }
      if let end = edges.trailing { YGNodeStyleSetPosition(node, .end, end) }
    } else {
      YGNodeStyleSetPositionType(node, .relative)
    }

    YGNodeStyleSetDisplay(node, layout.isIncludedInLayout ? .flex : .none)

    if let top = layout.margin?.top { YGNodeStyleSetMargin(node, .top, top) }
    if let start = layout.margin?.leading { YGNodeStyleSetMargin(node, .start, start) }
    if let bottom = layout.margin?.bottom { YGNodeStyleSetMargin(node, .bottom, bottom) }
    if let end = layout.margin?.trailing { YGNodeStyleSetMargin(node, .end, end) }

    if let top = layout.padding?.top { YGNodeStyleSetPadding(node, .top, top) }
    if let start = layout.padding?.leading { YGNodeStyleSetPadding(node, .start, start) }
    if let bottom = layout.padding?.bottom { YGNodeStyleSetPadding(node, .bottom, bottom) }
    if let end = layout.padding?.trailing { YGNodeStyleSetPadding(node, .end, end) }

    if let top = layout.border?.top { YGNodeStyleSetBorder(node, .top, top) }
    if let start = layout.border?.leading { YGNodeStyleSetBorder(node, .start, start) }
    if let bottom = layout.border?.bottom { YGNodeStyleSetBorder(node, .bottom, bottom) }
    if let end = layout.border?.trailing { YGNodeStyleSetBorder(node, .end, end) }

    if let overriddenSecondaryAxisDistribution = layout.overriddenSecondaryAxisDistribution {
      switch overriddenSecondaryAxisDistribution {
      case .leading: YGNodeStyleSetAlignSelf(node, .flexStart); break
      case .center: YGNodeStyleSetAlignSelf(node, .center); break
      case .trailing: YGNodeStyleSetAlignSelf(node, .flexEnd); break
      case .stretch: YGNodeStyleSetAlignSelf(node, .stretch); break
      }
    } else {
      YGNodeStyleSetAlignSelf(node, .auto)
    }
  }

  var frame: CGRect {
    return CGRect(
      x: CGFloat(round(YGNodeLayoutGetLeft(node))),
      y: CGFloat(round(YGNodeLayoutGetTop(node))),
      width: CGFloat(round(YGNodeLayoutGetWidth(node))),
      height: CGFloat(round(YGNodeLayoutGetHeight(node)))
    )
  }
}
