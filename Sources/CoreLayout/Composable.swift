//
//  Composable.swift
//  CoreLayout
//
//  Created by Jake Marsh on 7/3/17.
//  Copyright © 2017 Jake Marsh. All rights reserved.
//

public final class Rectangle {
  public var layout: Layout
  public var children: [Rectangle] { didSet { layout.children = children.map { $0.layout } } }

  public init() {
    self.layout = Layout()
    self.children = []
  }
}

public protocol ClosureInitable {
  init(_ closure: ((Self) -> Void)?)
}

extension Rectangle : ClosureInitable {
  public convenience init(_ closure: ((Rectangle) -> Void)? = nil) {
    self.init()

    closure?(self)
  }
}

// Addable

public protocol Addable {
  associatedtype AddableType
  static func <<<(lhs: Self, rhs: AddableType?)
  func add(_ el: AddableType?)
}

public extension Addable {
  static func <<<(lhs: Self, rhs: Self.AddableType?) {
    lhs.add(rhs)
  }
}

// CollectionAddable

public protocol CollectionAddable : Addable {
  static func <<<(lhs: Self, rhs: [AddableType?])
  func add(_ el: [AddableType?])
}

public extension CollectionAddable {
  static func <<<(lhs: Self, rhs: [Self.AddableType?]) {
    lhs.add(rhs)
  }
}

// Add Operator

infix operator <<<

extension Rectangle : CollectionAddable {
  public typealias AddableType = Rectangle

  public func add(_ el: Rectangle?) {
    guard let el = el else { return }

    children.append(el)
  }
  
  public func add(_ els: [Rectangle?]) {
    for el in els.compactMap({ $0 }) {
      add(el)
    }
  }
}
