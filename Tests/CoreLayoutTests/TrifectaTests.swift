//
//  TrifectaTests.swift
//  CoreLayout
//
//  Created by Jake Marsh on 10/2/16.
//  Copyright © 2016 Jake Marsh. All rights reserved.
//

import XCTest
@testable import CoreLayout

class TrifectaTests: CoreLayoutTestCase {
  func trifectaLayout() -> ComputedLayout {
    let layout = Layout(
      container: ContainerBehavior(
        primaryAxis: .vertical,
        secondaryAxisDistribution: .stretch
      ),
      padding: Edges(all: 8),
      children: [
        Layout(
          container: ContainerBehavior(
            primaryAxis: .horizontal,
            primaryAxisDistribution: .spaceBetween,
            secondaryAxisDistribution: .center
          ),
          padding: Edges(all: 8),
          children: [
            Layout(
              container: ContainerBehavior(
                primaryAxis: .horizontal,
                secondaryAxisDistribution: .center
              ),

              children: [
                Layout(size: .absolute(width: 30, height: 30)),

                Layout(
                  size: .relative { (options) -> CGSize in
                    let measuredSize = NSAttributedString(string: "CoreLayout").boundingRect(
                      with: CGSize(width: CGFloat(options.width), height: CGFloat(options.height)),
                      options: [.usesLineFragmentOrigin, .usesFontLeading],
                      context: nil
                    ).size

                    return CGSize(
                      width: CGFloat(ceilf(Float(measuredSize.width))),
                      height: CGFloat(ceilf(Float(measuredSize.height)))
                    )
                  },

                  margin: Edges(leading: 8)
                )
              ]
            ),

            Layout(size: .absolute(width: 8, height: 8))
          ]
        )
      ]
    )

    return layout.compute(with: containerSize())
  }

  func testTrifectaLayout() {
    let computedTest = trifectaLayout()

    let computed = ComputedLayout(
      frame: CGRect(x: 0.0, y: 0.0, width: 160.0, height: 284.0),
      children: [
        ComputedLayout(
          frame: CGRect(x: 8.0, y: 8.0, width: 144.0, height: 46.0),
          children: [
            ComputedLayout(
              frame: CGRect(x: 8.0, y: 8.0, width: 101.0, height: 30.0),
              children: [
                ComputedLayout(frame: CGRect(x: 0.0, y: 0.0, width: 30.0, height: 30.0)),
                ComputedLayout(frame: CGRect(x: 38.0, y: 8.0, width: 63.0, height: 14.0))
              ]
            ),
            ComputedLayout(frame: CGRect(x: 128.0, y: 19.0, width: 8.0, height: 8.0))
          ]
        )
      ]
    )

    self.saveImageForComputedLayout(computed: computedTest, name: "trifecta-example")

    XCTAssert(computedTest == computed, "Trifecta layout test failed.")
  }

  func testTrifectaLayoutPerformance1() {
    self.measure { _ = self.trifectaLayout() }
  }
}
