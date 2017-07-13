//
//  ComputedLayout.swift
//  CoreLayout
//
//  Created by Jake Marsh on 8/8/16.
//  Copyright © 2016 Magnus. All rights reserved.
//

import Foundation

public struct ComputedLayout {
  public var identifier: String? = nil
  public var frame: CGRect
  public let children: [ComputedLayout]

  public init(identifier: String? = nil, frame: CGRect, children: [ComputedLayout] = []) {
    self.identifier = identifier
    self.frame = frame
    self.children = children
  }
}

extension ComputedLayout : Equatable {
  public static func ==(lhs: ComputedLayout, rhs: ComputedLayout) -> Bool {
    return lhs.frame == rhs.frame && lhs.children == rhs.children
  }
}
