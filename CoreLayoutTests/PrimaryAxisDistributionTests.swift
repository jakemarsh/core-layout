//
//  PrimaryAxisDistributionTests.swift
//  CoreLayout
//
//  Created by Jake Marsh on 10/15/16.
//  Copyright © 2016 Jake Marsh. All rights reserved.
//

import Foundation
@testable import CoreLayout
import XCTest

class PrimaryAxisDistributionTests: CoreLayoutTestCase {
  override func containerSize() -> CGSize {
    return CGSize(width: 328, height: 60)
  }
  
  func primaryAxisDistributionLayout(primaryAxisDistribution: PrimaryAxisDistribution) -> ComputedLayout {
    let l = Layout(
      container: ContainerBehavior(primaryAxis: .horizontal, primaryAxisDistribution: primaryAxisDistribution),
      padding: Edges(all: 8),
      children: (1..<4).map { i in
        Layout(
          identifier: String(i),
          size: .absolute(width: 44, height: 44),
          margin: (i == 3 ? .zero : Edges(trailing: 8))
        )
      }
    )

    return l.compute(with: containerSize())
  }

  func testPrimaryAxisDistributionLayout() {
    let values: [PrimaryAxisDistribution : ComputedLayout] = [
      .leading : ComputedLayout(
        frame: CGRect(x: 0.0, y: 0.0, width: 328.0, height: 60.0),
        children: [
          ComputedLayout(frame: CGRect(x: 8.0, y: 8.0, width: 44.0, height: 44.0)),
          ComputedLayout(frame: CGRect(x: 60.0, y: 8.0, width: 44.0, height: 44.0)),
          ComputedLayout(frame: CGRect(x: 112.0, y: 8.0, width: 44.0, height: 44.0))
        ]
      ),

      .center : ComputedLayout(
        frame: CGRect(x: 0.0, y: 0.0, width: 328.0, height: 60.0),
        children: [
          ComputedLayout(frame: CGRect(x: 90.0, y: 8.0, width: 44.0, height: 44.0)),
          ComputedLayout(frame: CGRect(x: 142.0, y: 8.0, width: 44.0, height: 44.0)),
          ComputedLayout(frame: CGRect(x: 194.0, y: 8.0, width: 44.0, height: 44.0))
        ]
      ),

      .trailing : ComputedLayout(
        frame: CGRect(x: 0.0, y: 0.0, width: 328.0, height: 60.0),
        children: [
          ComputedLayout(frame: CGRect(x: 172.0, y: 8.0, width: 44.0, height: 44.0)),
          ComputedLayout(frame: CGRect(x: 224.0, y: 8.0, width: 44.0, height: 44.0)),
          ComputedLayout(frame: CGRect(x: 276.0, y: 8.0, width: 44.0, height: 44.0))
        ]
      ),

      .spaceBetween : ComputedLayout(
        frame: CGRect(x: 0.0, y: 0.0, width: 328.0, height: 60.0),
        children: [
          ComputedLayout(frame: CGRect(x: 8.0, y: 8.0, width: 44.0, height: 44.0)),
          ComputedLayout(frame: CGRect(x: 142.0, y: 8.0, width: 44.0, height: 44.0)),
          ComputedLayout(frame: CGRect(x: 276.0, y: 8.0, width: 44.0, height: 44.0))
        ]
      ),

      .spaceAround : ComputedLayout(
        frame: CGRect(x: 0.0, y: 0.0, width: 328.0, height: 60.0),
        children: [
          ComputedLayout(frame: CGRect(x: 35.0, y: 8.0, width: 44.0, height: 44.0)),
          ComputedLayout(frame: CGRect(x: 142.0, y: 8.0, width: 44.0, height: 44.0)),
          ComputedLayout(frame: CGRect(x: 249.0, y: 8.0, width: 44.0, height: 44.0))
        ]
      )
    ]

    for (value, computed) in values {
      let computedTest = primaryAxisDistributionLayout(primaryAxisDistribution: value)

      self.saveImageForComputedLayout(computed: computedTest, name: "primaryAxisDistribution-\(value)")

      XCTAssert(computedTest == computed, "PrimaryAxisDistribution layout test failed.")
    }
  }

  func testPrimaryAxisDistributionLayoutPerformance1() {
    self.measure { _ = self.testPrimaryAxisDistributionLayout() }
  }
}
