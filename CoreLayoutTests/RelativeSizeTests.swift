//
//  RelativeSizeTests.swift
//  CoreLayout
//
//  Created by Jake Marsh on 7/9/17.
//  Copyright © 2017 Jake Marsh. All rights reserved.
//

import Foundation
@testable import CoreLayout
import XCTest

class RelativeSizeTests: CoreLayoutTestCase {
  override func containerSize() -> CGSize { return CGSize(width: 164, height: 164) }
  
  func relativeSizeLayout() -> ComputedLayout {
    let l = Layout(
      container: ContainerBehavior(
        primaryAxis: .vertical,
        secondaryAxisDistribution: .leading
      ),
      children: [
        Layout(
          identifier: "Core Layout",
          size: .relative { (options) -> CGSize in
            let string = NSAttributedString(string: "Core Layout", attributes: [
              NSFontAttributeName : ComputedLayout.debugIdentifierFont
            ])

            return string.boundingRect(
              with: options.containerSize,
              options: [.usesLineFragmentOrigin, .usesFontLeading],
              context: nil
            ).size
          },
          
          margin: Edges(leading: 8)
        )
      ]
    )
    
    return l.compute(with: containerSize())
  }
  
  func testRelativeSizeLayout() {
    let computed = relativeSizeLayout()
    
    let computedTest = ComputedLayout(
      frame: CGRect(x: 0.0, y: 0.0, width: 164.0, height: 164.0),
      children: [
        ComputedLayout(frame: CGRect(x: 8.0, y: 0.0, width: 82.0, height: 17.0))
      ]
    )
    
    self.saveImageForComputedLayout(computed: computed, name: "size-relative")
    
    XCTAssert(computedTest == computed, "Relative Size layout test failed.")
  }
  
  func testRelativeSizeLayoutPerformance1() {
    self.measure { _ = self.testRelativeSizeLayout() }
  }
}
