//
//  AxisTests.swift
//  CoreLayout
//
//  Created by Jake Marsh on 10/15/16.
//  Copyright © 2016 Jake Marsh. All rights reserved.
//

import Foundation
@testable import CoreLayout
import XCTest

class AxisTests: CoreLayoutTestCase {
  override func containerSize() -> CGSize {
    return CGSize(width: 164, height: 164)
  }

  func axisLayout(primaryAxis: Axis) -> ComputedLayout {
    let l = Layout(
      container: ContainerBehavior(primaryAxis: primaryAxis),
      padding: Edges(all: 8),
      children: (1..<4).map { i in
        Layout(
          identifier: String(i),
          size: .absolute(width: 44, height: 44),
          margin: (primaryAxis == .vertical ? Edges(bottom: 8) : Edges(trailing: 8))
        )
      }
    )

    return l.compute(with: containerSize())
  }

  func testAxisLayout() {
    let values: [Axis : ComputedLayout] = [
      .vertical : ComputedLayout(
        frame: CGRect(x: 0.0, y: 0.0, width: 164.0, height: 164.0),
        children: [
          ComputedLayout(frame: CGRect(x: 8.0, y: 8.0, width: 44.0, height: 44.0)),
          ComputedLayout(frame: CGRect(x: 8.0, y: 60.0, width: 44.0, height: 44.0)),
          ComputedLayout(frame: CGRect(x: 8.0, y: 112.0, width: 44.0, height: 44.0))
        ]
      ),

      .horizontal : ComputedLayout(
        frame: CGRect(x: 0.0, y: 0.0, width: 164.0, height: 164.0),
        children: [
          ComputedLayout(frame: CGRect(x: 8.0, y: 8.0, width: 44.0, height: 44.0)),
          ComputedLayout(frame: CGRect(x: 60.0, y: 8.0, width: 44.0, height: 44.0)),
          ComputedLayout(frame: CGRect(x: 112.0, y: 8.0, width: 44.0, height: 44.0))
        ]
      )
    ]
    
    for (value, computed) in values {
      let computedTest = axisLayout(primaryAxis: value)

      self.saveImageForComputedLayout(computed: computedTest, name: "primaryAxis-\(value)")

      XCTAssert(computedTest == computed, "Axis layout test failed.")
    }
  }

  func testAxisLayoutPerformance1() {
    self.measure { _ = self.testAxisLayout() }
  }
}
