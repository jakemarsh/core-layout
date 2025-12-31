//
//  AbsoluteSizeTests.swift
//  CoreLayout
//
//  Created by Jake Marsh on 7/9/17.
//  Copyright © 2017 Jake Marsh. All rights reserved.
//

import Foundation
@testable import CoreLayout
import XCTest

class AbsoluteSizeTests: CoreLayoutTestCase {
  override func containerSize() -> CGSize { return CGSize(width: 164, height: 164) }
  
  func absoluteSizeLayout() -> ComputedLayout {
    let l = Layout(
      container: ContainerBehavior(primaryAxis: .vertical),
      children: [
        Layout(
          identifier: "1",
          size: .absolute(width: 97, height: 58)
        )
      ]
    )
    
    return l.compute(with: containerSize())
  }
  
  func testAbsoluteSizeLayout() {
    let computed = absoluteSizeLayout()
    
    let computedTest = ComputedLayout(
      frame: CGRect(x: 0.0, y: 0.0, width: 164.0, height: 164.0),
      children: [
        ComputedLayout(frame: CGRect(x: 0.0, y: 0.0, width: 97.0, height: 58.0))
      ]
    )
    
    self.saveImageForComputedLayout(computed: computed, name: "size-absolute")
    
    XCTAssert(computedTest == computed, "Absolute Size layout test failed.")
  }
  
  func testAbsoluteSizeLayoutPerformance1() {
    self.measure { _ = self.testAbsoluteSizeLayout() }
  }
}
