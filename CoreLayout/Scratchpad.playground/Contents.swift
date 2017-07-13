//: Playground - noun: a place where people can play

import UIKit
import CoreLayout
import XCPlayground

let spacing = Float(8)

Rectangle {
  $0.layout.container = ContainerBehavior(
    primaryAxis: .horizontal,
    primaryAxisDistribution: .center,
//    secondaryAxisDistribution: .trailing,
    secondaryAxisDistributionWhenWrapping: .center,
    shouldWrap: true
  )

  $0.layout.size = .flexible()
  $0.layout.overriddenSecondaryAxisDistribution = .stretch
  
  $0 <<< Rectangle {
    $0.layout.overriddenPosition = Edges(top: spacing, leading: spacing)
    $0.layout.overriddenSecondaryAxisDistribution = .stretch
    $0.layout.margin = Edges(bottom: spacing, trailing: spacing)
  }

  $0 <<< Rectangle { $0.layout.size = .absolute(width: 44, height: 44) }
  $0 <<< Rectangle { $0.layout.size = .absolute(width: 44, height: 44) }
  $0 <<< Rectangle { $0.layout.size = .absolute(width: 44, height: 44) }
  $0 <<< Rectangle { $0.layout.size = .absolute(width: 44, height: 44) }
  $0 <<< Rectangle { $0.layout.size = .absolute(width: 44, height: 44) }
}.layout.compute(with: CGSize(width: 160, height: 284))

func renderTrifecta(text: String = "Core Layout") -> Rectangle {
  return Rectangle {
    $0.layout.container = ContainerBehavior(
      primaryAxis: .vertical,
      secondaryAxisDistribution: .stretch
    )
    
    $0.layout.padding = Edges(all: spacing)

    $0 <<< Rectangle {
      $0.layout.container = ContainerBehavior(
        primaryAxis: .horizontal,
        //      primaryAxisDistribution: .center,
        secondaryAxisDistribution: .center
      )
      
      $0.layout.padding = Edges(all: spacing)
      
      $0 <<< Rectangle {
        $0.layout.identifier = "1"
        $0.layout.size = .absolute(width: spacing * 4, height: spacing * 4)
        $0.layout.margin = Edges(trailing: spacing)
      }
      
      $0 <<< Rectangle {
        $0.layout.size = .flexible()
        $0.layout.container = ContainerBehavior(primaryAxis: .vertical)
        $0.layout.padding = Edges(all: spacing)
        $0.layout.margin = Edges(trailing: spacing)
        
        $0 <<< Rectangle {
          let style = NSMutableParagraphStyle()
          style.alignment = .center
          
          $0.layout.identifier = text
          $0.layout.size = .relative { (options) -> CGSize in
            let style = NSMutableParagraphStyle()
            style.alignment = .center
            
            let measuredSize = NSAttributedString(string: text, attributes: [
              NSParagraphStyleAttributeName : style,
              NSFontAttributeName : ComputedLayout.debugIdentifierFont,
              ]).boundingRect(
                with: CGSize(width: CGFloat(options.width), height: CGFloat(options.height)),
                options: [.usesLineFragmentOrigin, .usesFontLeading],
                context: nil
              ).size
            
            return CGSize(
              width: CGFloat(ceilf(Float(measuredSize.width))),
              height: CGFloat(ceilf(Float(measuredSize.height)))
            )
          }
        }
        
        $0 <<< Rectangle {
          let style = NSMutableParagraphStyle()
          style.alignment = .center
          
          $0.layout.identifier = "is pretty fantastic! is pretty fantastic!"
          $0.layout.size = .relative { (options) -> CGSize in
            let style = NSMutableParagraphStyle()
            style.alignment = .center
            
            let measuredSize = NSAttributedString(string: "is pretty fantastic! is pretty fantastic! ", attributes: [
              NSParagraphStyleAttributeName : style,
              NSFontAttributeName : ComputedLayout.debugIdentifierFont,
              ]).boundingRect(
                with: CGSize(width: CGFloat(options.width), height: CGFloat(options.height)),
                options: [.usesLineFragmentOrigin, .usesFontLeading],
                context: nil
              ).size
            
            return CGSize(
              width: CGFloat(ceilf(Float(measuredSize.width))),
              height: CGFloat(ceilf(Float(measuredSize.height)))
            )
          }
        }
      }
      
      $0 <<< Rectangle {
        $0.layout.identifier = "3"
        $0.layout.size = .absolute(width: spacing * 2, height: spacing * 2)
//        $0.layout.overriddenSecondaryAxisDistribution = .trailing
      }
    }
    
    //  $0 <<< "😀😄😁😆😅😂🤣".characters.map { emoji in
    //    return Rectangle {
    //      $0.layout.identifier = String(emoji)
    //      $0.layout.margin = Edges(bottom: spacing)
    //      $0.layout.size = AbsoluteSizeBehavior(width: 44, height: 44)
    //    }
    //  }
  }
}

renderTrifecta().layout.compute(with: CGSize(width: 320, height: 568))
