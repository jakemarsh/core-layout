//
//  Layoutable.swift
//  CoreLayout
//
//  Created by Jake Marsh on 10/2/16.
//  Copyright © 2016 Magnus. All rights reserved.
//

import Foundation

protocol Layoutable {
  func apply(layout: ComputedLayout, offset: CGPoint)
}
