//
//  PositioningTests.swift
//  CoreLayout
//
//  Created by Jake Marsh on 10/2/16.
//  Copyright © 2016 Jake Marsh. All rights reserved.
//

import XCTest
@testable import CoreLayout

class PositioningTests: CoreLayoutTestCase {
  func absoluteLayout() -> ComputedLayout {
    let layout = Layout(
      identifier: "1",
      container: ContainerBehavior(primaryAxis: .vertical),
      padding: Edges(leading: 50),
      children: [
        Layout(
          identifier: "2",
          container: ContainerBehavior(primaryAxis: .horizontal),
          size: .absolute(width: 100, height: 60),
          children: [
            Layout(
              identifier: "3",
              overriddenPosition: Edges(top: 8, leading: 8),
              size: .absolute(width: 44, height: 44)
            )
          ]
        )
      ]
    )

    return layout.compute(with: containerSize())
  }
  
  func testAbsoluteLayout() {
    let computedTest = absoluteLayout()
    
    let computed = ComputedLayout(
      frame: CGRect(x: 0.0, y: 0.0, width: 160.0, height: 284.0),
      children: [
        ComputedLayout(
          frame: CGRect(x: 50.0, y: 0.0, width: 100.0, height: 60.0),
          children: [
            ComputedLayout(frame: CGRect(x: 8.0, y: 8.0, width: 44.0, height: 44.0))
          ]
        )
      ]
    )

    self.saveImageForComputedLayout(computed: computedTest, name: "overriddenPosition")

    XCTAssert(computedTest == computed, "Absolute Position layout test failed.")
  }
  
  func testAbsoluteLayoutPerformance1() {
    self.measure { _ = self.absoluteLayout() }
  }
}

