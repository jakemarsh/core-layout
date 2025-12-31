//
//  EdgesTests.swift
//  CoreLayout
//
//  Created by Jake Marsh on 7/9/17.
//  Copyright © 2017 Jake Marsh. All rights reserved.
//

import Foundation
@testable import CoreLayout
import XCTest

class EdgesTests: CoreLayoutTestCase {
  override func containerSize() -> CGSize { return CGSize(width: 164, height: 164) }
  
  func marginLayout() -> ComputedLayout {
    let l = Layout(
      container: ContainerBehavior(primaryAxis: .vertical),
      children: [
        Layout(identifier: "1", size: .absolute(width: 30, height: 30), margin: Edges(bottom: 10)),
        Layout(identifier: "2", size: .absolute(width: 30, height: 30), margin: Edges(bottom: 20)),
        Layout(identifier: "3", size: .absolute(width: 30, height: 30), margin: Edges(leading: 20))
      ]
    )
    
    return l.compute(with: containerSize())
  }

  func paddingLayout() -> ComputedLayout {
    let l = Layout(
      container: ContainerBehavior(primaryAxis: .vertical),
      padding: Edges(all: 20),
      children: [
        Layout(identifier: "1", size: .absolute(width: 30, height: 30)),
        Layout(identifier: "2", size: .absolute(width: 30, height: 30)),
        Layout(identifier: "3", size: .absolute(width: 30, height: 30))
      ]
    )

    return l.compute(with: containerSize())
  }
  
  func borderLayout() -> ComputedLayout {
    let l = Layout(
      container: ContainerBehavior(primaryAxis: .horizontal),
      children: [
        Layout(identifier: "1", size: .absolute(width: 30, height: 30), border: Edges(all: 20)),
        Layout(identifier: "2", size: .absolute(width: 30, height: 30), border: Edges(all: 20)),
        Layout(identifier: "3", size: .absolute(width: 30, height: 30), border: Edges(all: 20))
      ]
    )

    return l.compute(with: containerSize())
  }

  func testMarginLayout() {
    let computed = marginLayout()
    
    let computedTest = ComputedLayout(
      frame: CGRect(x: 0.0, y: 0.0, width: 164.0, height: 164.0),
      children: [
        ComputedLayout(frame: CGRect(x: 0.0, y: 0.0, width: 30.0, height: 30.0)),
        ComputedLayout(frame: CGRect(x: 0.0, y: 40.0, width: 30.0, height: 30.0)),
        ComputedLayout(frame: CGRect(x: 20.0, y: 90.0, width: 30.0, height: 30.0))
      ]
    )

    self.saveImageForComputedLayout(computed: computed, name: "edges-margin")
    
    XCTAssert(computedTest == computed, "Margins layout test failed.")
  }

  func testPaddingLayout() {
    let computed = paddingLayout()
    
    let computedTest = ComputedLayout(
      frame: CGRect(x: 0.0, y: 0.0, width: 164.0, height: 164.0),
      children: [
        ComputedLayout(frame: CGRect(x: 20.0, y: 20.0, width: 30.0, height: 30.0)),
        ComputedLayout(frame: CGRect(x: 20.0, y: 50.0, width: 30.0, height: 30.0)),
        ComputedLayout(frame: CGRect(x: 20.0, y: 80.0, width: 30.0, height: 30.0))
      ]
    )

    self.saveImageForComputedLayout(computed: computed, name: "edges-padding")
    
    XCTAssert(computedTest == computed, "Padding layout test failed.")
  }
  
  func testBorderLayout() {
    let computed = borderLayout()
    
    let computedTest = ComputedLayout(
      frame: CGRect(x: 0.0, y: 0.0, width: 164.0, height: 164.0),
      children: [
        ComputedLayout(frame: CGRect(x: 0.0, y: 0.0, width: 40.0, height: 40.0)),
        ComputedLayout(frame: CGRect(x: 40.0, y: 0.0, width: 40.0, height: 40.0)),
        ComputedLayout(frame: CGRect(x: 80.0, y: 0.0, width: 40.0, height: 40.0))
      ]
    )
    
    self.saveImageForComputedLayout(computed: computed, name: "edges-border")
    
    XCTAssert(computedTest == computed, "Border layout test failed.")
  }

  func testMarginLayoutPerformance1() {
    self.measure { _ = self.testMarginLayout() }
  }
}
