//
//  CoreLayoutTests.swift
//  CoreLayoutTests
//
//  Created by Jake Marsh on 10/2/16.
//  Copyright © 2016 Jake Marsh. All rights reserved.
//

import XCTest
@testable import CoreLayout

open class CoreLayoutTestCase : XCTestCase {
  open func containerSize() -> CGSize {
    return CGSize(width: 160, height: 284)
  }

  func saveImageForComputedLayout(computed: ComputedLayout, name: String) {
    let image = computed.debugQuickLookObject()

    if let data = UIImagePNGRepresentation(image) {
      let filename = Bundle(for: type(of: self)).resourceURL!
        .deletingLastPathComponent()
        .appendingPathComponent("../../../../../CoreLayoutTests/media/\(name).png")
      
      try? data.write(to: filename)
    }
  }
}
