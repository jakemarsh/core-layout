//
//  Layout+Equatable.swift
//  CoreLayout
//
//  Created by Jake Marsh on 7/13/17.
//  Copyright © 2017 Jake Marsh. All rights reserved.
//

extension Layout : Equatable {
  public static func ==(lhs: Layout, rhs: Layout) -> Bool {
    return  lhs.identifier == rhs.identifier &&
            lhs.container == rhs.container &&
            lhs.overriddenPosition == rhs.overriddenPosition &&
            lhs.size == rhs.size &&
            lhs.margin == rhs.margin &&
            lhs.padding == rhs.padding &&
            lhs.border == rhs.border &&
            lhs.isIncludedInLayout == rhs.isIncludedInLayout &&
            lhs.children == rhs.children
  }
}

extension ContainerBehavior : Equatable {
  public static func ==(lhs: ContainerBehavior, rhs: ContainerBehavior) -> Bool {
    return  lhs.primaryAxis == rhs.primaryAxis &&
            lhs.primaryAxis == rhs.primaryAxis &&
            lhs.primaryAxisDistribution == rhs.primaryAxisDistribution &&
            lhs.secondaryAxisDistribution == rhs.secondaryAxisDistribution &&
            lhs.secondaryAxisDistributionWhenWrapping == rhs.secondaryAxisDistributionWhenWrapping &&
            lhs.shouldWrap == rhs.shouldWrap &&
            lhs.overflow == rhs.overflow
  }

}

extension WidthAndOrHeight : Equatable {
  public static func ==(lhs: WidthAndOrHeight, rhs: WidthAndOrHeight) -> Bool {
    return lhs.width == rhs.width && lhs.height == rhs.height
  }
}

extension SizeBehavior : Equatable {
  public static func ==(lhs: SizeBehavior, rhs: SizeBehavior) -> Bool {
    func modeIsEqual() -> Bool {
      switch (lhs.mode, rhs.mode) {
      case (.flexibleShrinksButDoesntGrow, .flexible),
           (.flexibleShrinksButDoesntGrow, .absolute),
           (.flexibleShrinksButDoesntGrow, .relative),
           (.flexible, .flexibleShrinksButDoesntGrow),
           (.flexible, .absolute),
           (.flexible, .relative),
           (.absolute, .flexibleShrinksButDoesntGrow),
           (.absolute, .flexible),
           (.absolute, .relative),
           (.relative, .flexibleShrinksButDoesntGrow),
           (.relative, .flexible),
           (.relative, .absolute):
        return false

      case (.flexibleShrinksButDoesntGrow, .flexibleShrinksButDoesntGrow),
           (.relative, .relative):
        return true
        
      case (.absolute(let width, let height), .absolute(let width2, let height2)):
        return width == width2 && height == height2

      case (.flexible(let units), .flexible(let units2)):
        return units == units2
      }
    }

    return  modeIsEqual() &&
            lhs.minimum == rhs.minimum &&
            lhs.maximum == rhs.maximum
  }
}

extension Edges : Equatable {
  public static func ==(lhs: Edges, rhs: Edges) -> Bool {
    return  lhs.top == rhs.top &&
            lhs.leading == rhs.leading &&
            lhs.trailing == rhs.trailing &&
            lhs.bottom == rhs.bottom
  }
}
