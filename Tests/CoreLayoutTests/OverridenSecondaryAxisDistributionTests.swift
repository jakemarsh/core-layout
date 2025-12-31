//
//  OverridenSecondaryAxisDistributionTests.swift
//  CoreLayout
//
//  Created by Jake Marsh on 10/16/16.
//  Copyright © 2016 Jake Marsh. All rights reserved.
//

import XCTest
@testable import CoreLayout

class OverridenSecondaryAxisDistributionTests: CoreLayoutTestCase {
  override func containerSize() -> CGSize {
    return CGSize(width: 164, height: 164)
  }

  func overridenSecondaryAxisDistributionTestsLayout(distribution: SecondaryAxisDistribution?) -> ComputedLayout {
    let minSize = WidthAndOrHeight(width: 44, height: 44)

    let l = Layout(
      container: ContainerBehavior(primaryAxis: .horizontal, secondaryAxisDistribution: .leading),
      padding: Edges(all: 8),
      children: [
        Layout(
          identifier: "1",
          size: SizeBehavior(minimum: minSize), margin: Edges(trailing: 8)
        ),

        Layout(
          identifier: "2",
          size: SizeBehavior(minimum: minSize), margin: Edges(trailing: 8)
        ),

        Layout(
          identifier: "3",
          overriddenSecondaryAxisDistribution: distribution,
          size: SizeBehavior(minimum: minSize)
        ),
      ]
    )

    return l.compute(with: containerSize())
  }
  
  func testDefaultBehavior() {
    let computed = ComputedLayout(
      frame: CGRect(x: 0.0, y: 0.0, width: 164.0, height: 164.0),
      children: [
        ComputedLayout(frame: CGRect(x: 8.0, y: 8.0, width: 44.0, height: 44.0)),
        ComputedLayout(frame: CGRect(x: 60.0, y: 8.0, width: 44.0, height: 44.0)),
        ComputedLayout(frame: CGRect(x: 112.0, y: 8.0, width: 44.0, height: 44.0))
      ]
    )

    let computedTest = overridenSecondaryAxisDistributionTestsLayout(distribution: nil)

    self.saveImageForComputedLayout(computed: computedTest, name: "overriddenSecondaryAxisDistribution-nil")

    XCTAssert(computedTest == computed, "OverridenSecondaryAxisDistributionTests layout test failed.")

  }
  
  func testOverridenSecondaryAxisDistributionLayout() {
    let values: [SecondaryAxisDistribution : ComputedLayout] = [

      .leading : ComputedLayout(
        frame: CGRect(x: 0.0, y: 0.0, width: 164.0, height: 164.0),
        children: [
          ComputedLayout(frame: CGRect(x: 8.0, y: 8.0, width: 44.0, height: 44.0)),
          ComputedLayout(frame: CGRect(x: 60.0, y: 8.0, width: 44.0, height: 44.0)),
          ComputedLayout(frame: CGRect(x: 112.0, y: 8.0, width: 44.0, height: 44.0))
        ]
      ),
      
      .center : ComputedLayout(
        frame: CGRect(x: 0.0, y: 0.0, width: 164.0, height: 164.0),
        children: [
          ComputedLayout(frame: CGRect(x: 8.0, y: 8.0, width: 44.0, height: 44.0)),
          ComputedLayout(frame: CGRect(x: 60.0, y: 8.0, width: 44.0, height: 44.0)),
          ComputedLayout(frame: CGRect(x: 112.0, y: 60.0, width: 44.0, height: 44.0))
        ]
      ),
      
      .trailing : ComputedLayout(
        frame: CGRect(x: 0.0, y: 0.0, width: 164.0, height: 164.0),
        children: [
          ComputedLayout(frame: CGRect(x: 8.0, y: 8.0, width: 44.0, height: 44.0)),
          ComputedLayout(frame: CGRect(x: 60.0, y: 8.0, width: 44.0, height: 44.0)),
          ComputedLayout(frame: CGRect(x: 112.0, y: 112.0, width: 44.0, height: 44.0))
        ]
      ),
      
      .stretch : ComputedLayout(
        frame: CGRect(x: 0.0, y: 0.0, width: 164.0, height: 164.0),
        children: [
          ComputedLayout(frame: CGRect(x: 8.0, y: 8.0, width: 44.0, height: 44.0)),
          ComputedLayout(frame: CGRect(x: 60.0, y: 8.0, width: 44.0, height: 44.0)),
          ComputedLayout(frame: CGRect(x: 112.0, y: 8.0, width: 44.0, height: 148.0))
        ]
      )      
    ]

    for (value, computed) in values {
      let computedTest = overridenSecondaryAxisDistributionTestsLayout(distribution: value)
      
      self.saveImageForComputedLayout(computed: computedTest, name: "overriddenSecondaryAxisDistribution-\(value)")

      XCTAssert(computedTest == computed, "OverridenSecondaryAxisDistributionTests layout test failed.")
    }
  }
  
  func testOverridenSecondaryAxisDistributionLayoutPerformance1() {
    self.measure { _ = self.testOverridenSecondaryAxisDistributionLayout() }
  }
}
