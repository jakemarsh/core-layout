//
//  Layout.swift
//  CoreLayout
//
//  Created by Jake Marsh on 10/1/16.
//  Copyright © 2016 Magnus. All rights reserved.
//

import Foundation
import YogaLayout

public struct Layout {
  public var identifier: String?

  public var container: ContainerBehavior?
  public var overriddenSecondaryAxisDistribution: SecondaryAxisDistribution?
  public var overriddenPosition: Edges?

  public var size: SizeBehavior

  public var margin: Edges?
  public var padding: Edges?
  public var border: Edges?

  public var isIncludedInLayout: Bool

  public var children: [Layout]

  public init(
    identifier: String? = nil,

    container: ContainerBehavior? = nil,
    overriddenSecondaryAxisDistribution: SecondaryAxisDistribution? = nil,
    overriddenPosition: Edges? = nil,

    size: SizeBehavior = SizeBehavior(mode: .flexibleShrinksButDoesntGrow, minimum: nil, maximum: nil),

    margin: Edges? = nil,
    padding: Edges? = nil,
    border: Edges? = nil,

    isIncludedInLayout: Bool = true,

    children: [Layout] = []
  ) {
    self.identifier = identifier

    self.container = container
    self.overriddenSecondaryAxisDistribution = overriddenSecondaryAxisDistribution
    self.overriddenPosition = overriddenPosition

    self.size = size

    self.margin = margin
    self.padding = padding
    self.border = border

    self.isIncludedInLayout = isIncludedInLayout

    self.children = children
  }
}

public enum Axis : String { case horizontal, vertical }

public enum PrimaryAxisDistribution : String { case leading, center, trailing, spaceAround, spaceBetween }

public enum SecondaryAxisDistribution : String { case leading, center, trailing, stretch } // TODO: baseline (yoga supports, needs a closure function)

public enum SecondaryAxisDistributionWhenWrapping : String { case leading, center, trailing, stretch, spaceAround, spaceBetween }

public typealias Overflow = YGOverflow

public struct ContainerBehavior {
  public var primaryAxis: Axis
  public var primaryAxisDistribution: PrimaryAxisDistribution
  public var secondaryAxisDistribution: SecondaryAxisDistribution
  public var secondaryAxisDistributionWhenWrapping: SecondaryAxisDistributionWhenWrapping
  public var shouldWrap: Bool
  public var overflow: Overflow

  public init(
    primaryAxis: Axis = .vertical,
    primaryAxisDistribution: PrimaryAxisDistribution = .leading,
    secondaryAxisDistribution: SecondaryAxisDistribution = .stretch,
    secondaryAxisDistributionWhenWrapping: SecondaryAxisDistributionWhenWrapping = .stretch,
    shouldWrap: Bool = false,
    overflow: Overflow = .visible
  ) {
    self.primaryAxis = primaryAxis
    self.primaryAxisDistribution = primaryAxisDistribution
    self.secondaryAxisDistribution = secondaryAxisDistribution
    self.secondaryAxisDistributionWhenWrapping = secondaryAxisDistributionWhenWrapping
    self.shouldWrap = shouldWrap
    self.overflow = overflow
  }
}

public struct WidthAndOrHeight {
  public var width: Float?, height: Float?
  
  public init(width: Float? = nil, height: Float? = nil) {
    self.width = width
    self.height = height
  }
  
  var size: CGSize { return CGSize(width: CGFloat(width ?? .nan), height: CGFloat(height ?? .nan)) }
}

public struct SizeBehavior {
  public typealias RelativeSizeClosure = ((_ options: MeasureOptions) -> CGSize)

  public enum Mode {
    case flexibleShrinksButDoesntGrow
    case flexible(units: UInt)
    case absolute(width: Float?, height: Float?)
    case relative(closure: RelativeSizeClosure)
  }

  public var mode: Mode
  public var minimum: WidthAndOrHeight?
  public var maximum: WidthAndOrHeight?

  public init(mode: Mode = .flexibleShrinksButDoesntGrow) {
    self.mode = mode
    self.minimum = nil
    self.maximum = nil
  }
  
  public init(mode: Mode = .flexibleShrinksButDoesntGrow, minimum: WidthAndOrHeight? = nil, maximum: WidthAndOrHeight? = nil) {
    self.mode = mode
    self.minimum = minimum
    self.maximum = maximum
  }

  public init(mode: Mode = .flexibleShrinksButDoesntGrow, minWidth: Float? = nil, maxWidth: Float? = nil, minHeight: Float? = nil, maxHeight: Float? = nil) {
    self.mode = mode
    self.minimum = WidthAndOrHeight(width: minWidth, height: minHeight)
    self.maximum = WidthAndOrHeight(width: maxWidth, height: maxHeight)
  }

  public static func absolute(width: Float? = nil, height: Float? = nil) -> SizeBehavior {
    return SizeBehavior(mode: .absolute(width: width, height: height))
  }
  
  public static func relative(closure: @escaping RelativeSizeClosure) -> SizeBehavior {
    return SizeBehavior(mode: .relative(closure: closure))
  }

  public static func flexible(units: UInt = 1) -> SizeBehavior {
    return SizeBehavior(mode: .flexible(units: units))
  }

  public static func flexible(units: UInt = 1, minimum: WidthAndOrHeight? = nil, maximum: WidthAndOrHeight? = nil) -> SizeBehavior {
    return SizeBehavior(mode: .flexible(units: units), minimum: minimum, maximum: maximum)
  }

  public static func flexible(units: UInt = 1, minWidth: Float? = nil, maxWidth: Float? = nil, minHeight: Float? = nil, maxHeight: Float? = nil) -> SizeBehavior {
    return SizeBehavior(mode: .flexible(units: units), minWidth: minWidth, maxWidth: maxWidth, minHeight: minHeight, maxHeight: maxHeight)
  }
}

public struct Edges {
  var top: Float?, leading: Float?, bottom: Float?, trailing: Float? = nil

  public init(all: Float) { top = all; leading = all; bottom = all; trailing = all }

  public static var zero: Edges { return Edges(all: 0) }

  public init(top: Float? = nil, leading: Float? = nil, bottom: Float? = nil, trailing: Float? = nil, topAndBottom: Float? = nil, sides: Float? = nil) {
    self.top = top ?? 0
    self.leading = leading ?? 0
    self.bottom = bottom ?? 0
    self.trailing = trailing ?? 0

    if let topAndBottom = topAndBottom { self.top = topAndBottom; self.bottom = topAndBottom }
    if let sides = sides { self.leading = sides; self.trailing = sides }
  }
}
