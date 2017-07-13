//
//  AlignChildrenTests.swift
//  CoreLayout
//
//  Created by Jake Marsh on 10/16/16.
//  Copyright © 2016 Jake Marsh. All rights reserved.
//

import Foundation
@testable import CoreLayout
import XCTest

class AlignChildrenTests: CoreLayoutTestCase {
  override func containerSize() -> CGSize {
    return CGSize(width: 164, height: 164)
  }

  func secondaryAxisDistributionLayout(secondaryAxisDistribution: SecondaryAxisDistribution) -> ComputedLayout {
    let l = Layout(
      container: ContainerBehavior(primaryAxis: .horizontal, secondaryAxisDistribution: secondaryAxisDistribution),
      padding: Edges(all: 8),
      children: (1..<4).map { i in
        Layout(
          identifier: String(i),
          size: SizeBehavior(minWidth: 44, minHeight: 44),
          margin: (i == 3 ? .zero : Edges(trailing: 8))
        )
      }
    )
    
    return l.compute(with: containerSize())
  }
  
  func testSecondaryAxisDistributionLayout() {
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
          ComputedLayout(frame: CGRect(x: 8.0, y: 60.0, width: 44.0, height: 44.0)),
          ComputedLayout(frame: CGRect(x: 60.0, y: 60.0, width: 44.0, height: 44.0)),
          ComputedLayout(frame: CGRect(x: 112.0, y: 60.0, width: 44.0, height: 44.0))
        ]
      ),
      
      .trailing : ComputedLayout(
        frame: CGRect(x: 0.0, y: 0.0, width: 164.0, height: 164.0),
        children: [
          ComputedLayout(frame: CGRect(x: 8.0, y: 112.0, width: 44.0, height: 44.0)),
          ComputedLayout(frame: CGRect(x: 60.0, y: 112.0, width: 44.0, height: 44.0)),
          ComputedLayout(frame: CGRect(x: 112.0, y: 112.0, width: 44.0, height: 44.0))
        ]
      ),

      .stretch : ComputedLayout(
        frame: CGRect(x: 0.0, y: 0.0, width: 164.0, height: 164.0),
        children: [
          ComputedLayout(frame: CGRect(x: 8.0, y: 8.0, width: 44.0, height: 148.0)),
          ComputedLayout(frame: CGRect(x: 60.0, y: 8.0, width: 44.0, height: 148.0)),
          ComputedLayout(frame: CGRect(x: 112.0, y: 8.0, width: 44.0, height: 148.0))
        ]
      )
    ]
    
    for (value, computed) in values {
      let computedTest = secondaryAxisDistributionLayout(secondaryAxisDistribution: value)

      self.saveImageForComputedLayout(computed: computedTest, name: "secondaryAxisDistribution-\(value)")
      
      XCTAssert(computedTest == computed, "secondaryAxisDistribution layout test failed.")
    }
  }
  
  func testSecondaryAxisDistributionLayoutPerformance1() {
    self.measure { _ = self.testSecondaryAxisDistributionLayout() }
  }
}
