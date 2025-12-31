//
//  ComputedLayout+CustomStringConvertible.swift
//  Steward
//
//  Created by Jake Marsh on 10/2/16.
//  Copyright © 2016 Magnus. All rights reserved.
//

import Foundation

extension ComputedLayout: CustomStringConvertible {
  public var description: String {
    return description(forDepth: 0)
  }

  public var debugDescription: String {
    return description(forDepth: 0)
  }
  
  private func description(forDepth depth: Int) -> String {
    let tab = "  " // "\t"
    
    let indentation = depth == 0 ? "" : (0...depth).reduce("") { accum, _ in accum + tab }
    
    var d = ""
    
    d += indentation + "ComputedLayout("
    
    if children.count > 0 {
      d += "\n" + indentation
      d += tab
    }
    
    d += "frame: CGRect(x: \(frame.origin.x), y: \(frame.origin.y), width: \(frame.size.width), height: \(frame.size.height))"
    
    if children.count > 0 {
      d += ",\n\(indentation + tab)children: ["
      
      d += "\n" + (indentation) + (children.map { $0.description(forDepth: depth + 1) }).joined(separator: ",\n" + indentation)
      
      d += "\n\(indentation + tab)]"
      d += "\n\(indentation))"
    } else {
      d += ")"
    }
    
    return d
  }

//  private func description(forDepth depth: Int) -> String {
//    let selfDescription = "{origin={\(frame.origin.x), \(frame.origin.y)}, size={\(frame.size.width), \(frame.size.height)}}"
//
//    if children.count > 0 {
//      let indentation = (0...depth).reduce("\n") { accum, _ in accum + "\t" }
//      let childrenDescription = (children.map { $0.description(forDepth: depth + 1) }).joined(separator: indentation)
//      return "\(selfDescription)\(indentation)\(childrenDescription)"
//    } else {
//      return selfDescription
//    }
//  }
}
