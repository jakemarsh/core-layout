//
//  FlexibleSizeTests.swift
//  CoreLayout
//
//  Created by Jake Marsh on 7/9/17.
//  Copyright © 2017 Jake Marsh. All rights reserved.
//

import Foundation
@testable import CoreLayout
import XCTest

class FlexibleSizeTests: CoreLayoutTestCase {
  override func containerSize() -> CGSize { return CGSize(width: 164, height: 164) }
  
  func flexibleLayout(useMultiples: Bool) -> ComputedLayout {
    let l = Layout(
      container: ContainerBehavior(
        primaryAxis: .vertical,
        secondaryAxisDistribution: .stretch
      ),
      padding: Edges(top: 8, leading: 8, trailing: 8),
      children: (1..<4).map { i in
        Layout(
          identifier: String(useMultiples ? i : 1),
          size: .flexible(units: useMultiples ? i : 1),
          margin: Edges(bottom: 8)
        )
      }
    )

    return l.compute(with: containerSize())
  }

  func testFlexibleLayout() {
    let computed = flexibleLayout(useMultiples: false)

    let computedTest = ComputedLayout(
      frame: CGRect(x: 0.0, y: 0.0, width: 164.0, height: 164.0),
      children: [
        ComputedLayout(frame: CGRect(x: 8.0, y: 8.0, width: 148.0, height: 44.0)),
        ComputedLayout(frame: CGRect(x: 8.0, y: 60.0, width: 148.0, height: 44.0)),
        ComputedLayout(frame: CGRect(x: 8.0, y: 112.0, width: 148.0, height: 44.0))
      ]
    )

    self.saveImageForComputedLayout(computed: computed, name: "size-flexible")
    
    XCTAssert(computedTest == computed, "Flexible layout test failed.")
  }
  
  func testFlexibleMultiplesLayout() {
    let computed = flexibleLayout(useMultiples: true)

    let computedTest = ComputedLayout(
      frame: CGRect(x: 0.0, y: 0.0, width: 164.0, height: 164.0),
      children: [
        ComputedLayout(frame: CGRect(x: 8.0, y: 8.0, width: 148.0, height: 22.0)),
        ComputedLayout(frame: CGRect(x: 8.0, y: 38.0, width: 148.0, height: 44.0)),
        ComputedLayout(frame: CGRect(x: 8.0, y: 90.0, width: 148.0, height: 66.0))
      ]
    )
    
    self.saveImageForComputedLayout(computed: computed, name: "size-flexible-multiples")
    
    XCTAssert(computedTest == computed, "Flexible Multiples layout test failed.")
  }
  
  func testFlexibleLayoutPerformance1() {
    self.measure { _ = self.testFlexibleLayout() }
  }
}
