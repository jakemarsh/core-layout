//
//  UIView+Layoutable.swift
//  CoreLayout
//
//  Created by Jake Marsh on 10/3/16.
//  Copyright © 2016 Jake Marsh. All rights reserved.
//

import Foundation

#if canImport(UIKit)
import UIKit
public typealias CoreLayoutViewType = UIView
#elseif canImport(AppKit)
import AppKit
public typealias CoreLayoutViewType = NSView
#endif

#if canImport(UIKit) || canImport(AppKit)
extension CoreLayoutViewType: Layoutable {
  public func apply(layout: ComputedLayout, offset: CGPoint = .zero) {
    let layoutFrame = layout.frame.offsetBy(dx: offset.x, dy: offset.y)

    let childOffset = CGPoint.zero
    frame = layoutFrame.integral

    for (subview, layout) in zip(subviews, layout.children) {
      subview.apply(layout: layout, offset: childOffset)
    }
  }
}
#endif
