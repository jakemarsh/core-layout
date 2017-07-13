//
//  BasicTests.swift
//  CoreLayout
//
//  Created by Jake Marsh on 10/2/16.
//  Copyright © 2016 Jake Marsh. All rights reserved.
//

import XCTest
@testable import CoreLayout

class BasicTests: CoreLayoutTestCase {
  func basicLayout() -> ComputedLayout {
    let l = Layout(
      container: ContainerBehavior(primaryAxis: .vertical),
      padding: Edges(all: 8),
      children: (0..<3).map { _ in
        Layout(
          size: SizeBehavior(minHeight: 44),
          margin: Edges(bottom: 8)
        )
      }
    )

    return l.compute(with: containerSize())
  }

  func testBasicLayout() {
    let computedTest = basicLayout()

    let computed = ComputedLayout(
      frame: CGRect(x: 0, y: 0, width: containerSize().width, height: containerSize().height),
      children: [
        ComputedLayout(frame: CGRect(x: 8, y: 8, width: 144, height: 44), children: []),
        ComputedLayout(frame: CGRect(x: 8, y: 60, width: 144, height: 44), children: []),
        ComputedLayout(frame: CGRect(x: 8, y: 112, width: 144, height: 44), children: [])
      ]
    )

    XCTAssert(computedTest == computed, "Basic layout test failed.")
  }

  func testBasicLayoutPerformance1() {
    self.measure { _ = self.basicLayout() }
  }
}
