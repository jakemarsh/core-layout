//
//  ViewTests.swift
//  CoreLayout
//
//  Created by Jake Marsh on 10/6/16.
//  Copyright © 2016 Jake Marsh. All rights reserved.
//

import XCTest
@testable import CoreLayout

#if canImport(UIKit)
import UIKit

class ViewTests: TrifectaTests {
    func testViewLayout() {
        let computedTest = trifectaLayout()

        let root = UIView(frame: .zero)

        let a = UIView(frame: .zero)

        root.addSubview(a)

        let b = UIView(frame: .zero)
        let c = UIView(frame: .zero)

        a.addSubview(b)
        a.addSubview(c)

        let d = UIView(frame: .zero)
        let e = UIView(frame: .zero)

        b.addSubview(d)
        b.addSubview(e)

        root.apply(layout: computedTest)

        XCTAssert(root.frame == CGRect(x: 0, y: 0, width: 160, height: 284), "View Layout Failed.")
        XCTAssert(a.frame == CGRect(x: 8, y: 8, width: 144, height: 46), "View Layout Failed.")
        XCTAssert(b.frame == CGRect(x: 8, y: 8, width: 101, height: 30), "View Layout Failed.")
        XCTAssert(c.frame == CGRect(x: 128, y: 19, width: 8, height: 8), "View Layout Failed.")
        XCTAssert(d.frame == CGRect(x: 0, y: 0, width: 30, height: 30), "View Layout Failed.")
        XCTAssert(e.frame == CGRect(x: 38, y: 8, width: 63, height: 14), "View Layout Failed.")
    }
}
#endif
