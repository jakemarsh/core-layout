//
//  SecondaryAxisDistributionWhenWrappingTests.swift
//  CoreLayout
//
//  Created by Jake Marsh on 10/16/16.
//  Copyright © 2016 Jake Marsh. All rights reserved.
//

import Foundation
@testable import CoreLayout
import XCTest

class SecondaryAxisDistributionWhenWrappingTests: CoreLayoutTestCase {
  override func containerSize() -> CGSize {
    return CGSize(width: 164, height: 164)
  }

  func secondaryAxisDistributionWhenWrappingLayout(secondaryAxisDistributionWhenWrapping: SecondaryAxisDistributionWhenWrapping) -> ComputedLayout {
    let layout = Layout(
      container: ContainerBehavior(
        primaryAxis: .horizontal,
        secondaryAxisDistributionWhenWrapping: secondaryAxisDistributionWhenWrapping,
        shouldWrap: true
      ),
      padding: Edges(top: 8, leading: 8),
      children: (1..<6).map { i in
        Layout(
          identifier: String(i),
          size: .absolute(width: 40, height: 40),
          margin: (i == 5 ? .zero : Edges(bottom: 8, trailing: 8))
        )
      }
    )

    return layout.compute(with: containerSize())
  }
  
  func testSecondaryAxisDistributionWhenWrappingLeading() {
    let computedTest = secondaryAxisDistributionWhenWrappingLayout(secondaryAxisDistributionWhenWrapping: .leading)

    let computed = ComputedLayout(
      frame: CGRect(x: 0.0, y: 0.0, width: 164.0, height: 164.0),
      children: [
        ComputedLayout(frame: CGRect(x: 8.0, y: 8.0, width: 40.0, height: 40.0)),
        ComputedLayout(frame: CGRect(x: 56.0, y: 8.0, width: 40.0, height: 40.0)),
        ComputedLayout(frame: CGRect(x: 104.0, y: 8.0, width: 40.0, height: 40.0)),
        ComputedLayout(frame: CGRect(x: 8.0, y: 56.0, width: 40.0, height: 40.0)),
        ComputedLayout(frame: CGRect(x: 56.0, y: 56.0, width: 40.0, height: 40.0))
      ]
    )
    
    saveScreenshot(value: .leading, computed: computedTest)

    XCTAssert(computedTest == computed, "SecondaryAxisDistributionWhenWrapping layout test failed.")
  }
  
  func testSecondaryAxisDistributionWhenWrappingCenter() {
    let computedTest = secondaryAxisDistributionWhenWrappingLayout(secondaryAxisDistributionWhenWrapping: .center)

    let computed = ComputedLayout(
      frame: CGRect(x: 0.0, y: 0.0, width: 164.0, height: 164.0),
      children: [
        ComputedLayout(frame: CGRect(x: 8.0, y: 38.0, width: 40.0, height: 40.0)),
        ComputedLayout(frame: CGRect(x: 56.0, y: 38.0, width: 40.0, height: 40.0)),
        ComputedLayout(frame: CGRect(x: 104.0, y: 38.0, width: 40.0, height: 40.0)),
        ComputedLayout(frame: CGRect(x: 8.0, y: 86.0, width: 40.0, height: 40.0)),
        ComputedLayout(frame: CGRect(x: 56.0, y: 86.0, width: 40.0, height: 40.0))
      ]
    )
    
    saveScreenshot(value: .center, computed: computedTest)

    XCTAssert(computedTest == computed, "SecondaryAxisDistributionWhenWrapping layout test failed.")
  }
  
  func testSecondaryAxisDistributionWhenWrappingTrailing() {
    let computedTest = secondaryAxisDistributionWhenWrappingLayout(secondaryAxisDistributionWhenWrapping: .trailing)

    let computed = ComputedLayout(
      frame: CGRect(x: 0.0, y: 0.0, width: 164.0, height: 164.0),
      children: [
        ComputedLayout(frame: CGRect(x: 8.0, y: 68.0, width: 40.0, height: 40.0)),
        ComputedLayout(frame: CGRect(x: 56.0, y: 68.0, width: 40.0, height: 40.0)),
        ComputedLayout(frame: CGRect(x: 104.0, y: 68.0, width: 40.0, height: 40.0)),
        ComputedLayout(frame: CGRect(x: 8.0, y: 116.0, width: 40.0, height: 40.0)),
        ComputedLayout(frame: CGRect(x: 56.0, y: 116.0, width: 40.0, height: 40.0))
      ]
    )
    
    saveScreenshot(value: .trailing, computed: computedTest)
    
    XCTAssert(computedTest == computed, "SecondaryAxisDistributionWhenWrapping layout test failed.")
  }
  
  func testSecondaryAxisDistributionWhenWrappingStretch() {
    let computedTest = secondaryAxisDistributionWhenWrappingLayout(secondaryAxisDistributionWhenWrapping: .stretch)

    let computed = ComputedLayout(
      frame: CGRect(x: 0.0, y: 0.0, width: 164.0, height: 164.0),
      children: [
        ComputedLayout(frame: CGRect(x: 8.0, y: 8.0, width: 40.0, height: 40.0)),
        ComputedLayout(frame: CGRect(x: 56.0, y: 8.0, width: 40.0, height: 40.0)),
        ComputedLayout(frame: CGRect(x: 104.0, y: 8.0, width: 40.0, height: 40.0)),
        ComputedLayout(frame: CGRect(x: 8.0, y: 86.0, width: 40.0, height: 40.0)),
        ComputedLayout(frame: CGRect(x: 56.0, y: 86.0, width: 40.0, height: 40.0))
      ]
    )
    
    saveScreenshot(value: .stretch, computed: computedTest)
    
    XCTAssert(computedTest == computed, "SecondaryAxisDistributionWhenWrapping layout test failed.")
  }
  
  func testSecondaryAxisDistributionWhenWrappingSpaceAround() {
    let computedTest = secondaryAxisDistributionWhenWrappingLayout(secondaryAxisDistributionWhenWrapping: .spaceAround)

    let computed = ComputedLayout(
      frame: CGRect(x: 0.0, y: 0.0, width: 164.0, height: 164.0),
      children: [
        ComputedLayout(frame: CGRect(x: 8.0, y: 23.0, width: 40.0, height: 40.0)),
        ComputedLayout(frame: CGRect(x: 56.0, y: 23.0, width: 40.0, height: 40.0)),
        ComputedLayout(frame: CGRect(x: 104.0, y: 23.0, width: 40.0, height: 40.0)),
        ComputedLayout(frame: CGRect(x: 8.0, y: 101.0, width: 40.0, height: 40.0)),
        ComputedLayout(frame: CGRect(x: 56.0, y: 101.0, width: 40.0, height: 40.0))
      ]
    )
    
    saveScreenshot(value: .spaceAround, computed: computedTest)
    
    XCTAssert(computedTest == computed, "SecondaryAxisDistributionWhenWrapping layout test failed.")
  }
  
  func testSecondaryAxisDistributionWhenWrappingSpaceBetween() {
    let computedTest = secondaryAxisDistributionWhenWrappingLayout(secondaryAxisDistributionWhenWrapping: .spaceBetween)
    
    let computed = ComputedLayout(
      frame: CGRect(x: 0.0, y: 0.0, width: 164.0, height: 164.0),
      children: [
        ComputedLayout(frame: CGRect(x: 8.0, y: 8.0, width: 40.0, height: 40.0)),
        ComputedLayout(frame: CGRect(x: 56.0, y: 8.0, width: 40.0, height: 40.0)),
        ComputedLayout(frame: CGRect(x: 104.0, y: 8.0, width: 40.0, height: 40.0)),
        ComputedLayout(frame: CGRect(x: 8.0, y: 116.0, width: 40.0, height: 40.0)),
        ComputedLayout(frame: CGRect(x: 56.0, y: 116.0, width: 40.0, height: 40.0))
      ]
    )
    
    saveScreenshot(value: .spaceBetween, computed: computedTest)
    
    XCTAssert(computedTest == computed, "SecondaryAxisDistributionWhenWrapping layout test failed.")
  }
  
  func saveScreenshot(value: SecondaryAxisDistributionWhenWrapping, computed: ComputedLayout) {
    let computedTest = secondaryAxisDistributionWhenWrappingLayout(secondaryAxisDistributionWhenWrapping: value)

    self.saveImageForComputedLayout(computed: computedTest, name: "secondaryAxisDistributionWhenWrapping-\(value)")
  }
}
