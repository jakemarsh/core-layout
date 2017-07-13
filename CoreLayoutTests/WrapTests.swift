 //
//  WrapTests.swift
//  CoreLayout
//
//  Created by Jake Marsh on 10/6/16.
//  Copyright © 2016 Jake Marsh. All rights reserved.
//

import XCTest
@testable import CoreLayout

class WrapTests: CoreLayoutTestCase {
  override func containerSize() -> CGSize {
    return CGSize(width: 164, height: 164)
  }

  func wrapLayout(shouldWrap: Bool) -> ComputedLayout {
    let layout = Layout(
      container: ContainerBehavior(primaryAxis: .horizontal, shouldWrap: shouldWrap),
      padding: Edges(top: 8, leading: 8),
      children: (1..<6).map { i in
        Layout(
          identifier: String(i),
          size: .absolute(width: 40, height: 40),
          margin: Edges(bottom: 8, trailing: 8)
        )
      }
    )

    return layout.compute(with: containerSize())
  }

  func testWrapLayout() {
    let values: [Bool : ComputedLayout] = [
      true : ComputedLayout(
        frame: CGRect(x: 0.0, y: 0.0, width: 164.0, height: 164.0),
        children: [
          ComputedLayout(frame: CGRect(x: 8.0, y: 8.0, width: 40.0, height: 40.0)),
          ComputedLayout(frame: CGRect(x: 56.0, y: 8.0, width: 40.0, height: 40.0)),
          ComputedLayout(frame: CGRect(x: 104.0, y: 8.0, width: 40.0, height: 40.0)),
          ComputedLayout(frame: CGRect(x: 8.0, y: 86.0, width: 40.0, height: 40.0)),
          ComputedLayout(frame: CGRect(x: 56.0, y: 86.0, width: 40.0, height: 40.0))
        ]
      ),

      false : ComputedLayout(
        frame: CGRect(x: 0.0, y: 0.0, width: 164.0, height: 164.0),
        children: [
          ComputedLayout(frame: CGRect(x: 8.0, y: 8.0, width: 40.0, height: 40.0)),
          ComputedLayout(frame: CGRect(x: 56.0, y: 8.0, width: 40.0, height: 40.0)),
          ComputedLayout(frame: CGRect(x: 104.0, y: 8.0, width: 40.0, height: 40.0)),
          ComputedLayout(frame: CGRect(x: 152.0, y: 8.0, width: 40.0, height: 40.0)),
          ComputedLayout(frame: CGRect(x: 200.0, y: 8.0, width: 40.0, height: 40.0))
        ]
      )
    ]

    for (value, computed) in values {
      let computedTest = wrapLayout(shouldWrap: value)

      self.saveImageForComputedLayout(computed: computedTest, name: "shouldWrap-\(value)")

      XCTAssert(computedTest == computed, "Wrap layout test failed.")
    }
  }
  
  func testWrapLayoutPerformance1() {
    self.measure { _ = self.testWrapLayout() }
  }
}
