//
//  ComputedLayout+QuickLook.swift
//  CoreLayout
//
//  Created by Jake Marsh on 10/2/16.
//  Copyright © 2016 Jake Marsh. All rights reserved.
//

import Foundation

#if canImport(UIKit)
import UIKit
public typealias DebugImageType = UIImage
#elseif canImport(AppKit)
import AppKit
public typealias DebugImageType = NSImage
#endif

#if canImport(UIKit)
extension ComputedLayout {
    public func debugQuickLookObject() -> UIImage {
        return generateQuickLookImage()!
    }

    public static let debugIdentifierFont = UIFont.monospacedDigitSystemFont(ofSize: 14.0, weight: .semibold)

    public func generateQuickLookImage() -> DebugImageType? {
        let drawRect = frame.insetBy(dx: -8, dy: -8)

        UIGraphicsBeginImageContextWithOptions(drawRect.size, true, 2.0)
        defer { UIGraphicsEndImageContext() }

        let strokeColor = UIColor(red: 0.10, green: 0.41, blue: 1.0, alpha: 1.0)
        let fillColor = strokeColor.withAlphaComponent(0.15)

        UIColor.white.setFill()
        UIRectFill(CGRect(x: 0, y: 0, width: drawRect.size.width, height: drawRect.size.height))

        func draw(layout: ComputedLayout, offset: CGPoint) {
            let layoutFrame = layout.frame.integral.offsetBy(dx: offset.x, dy: offset.y)
            let childOffset = layoutFrame.origin

            fillColor.setFill()
            UIBezierPath(roundedRect: layoutFrame, cornerRadius: 2).fill()

            strokeColor.setStroke()
            UIBezierPath(roundedRect: layoutFrame, cornerRadius: 2).stroke()

            if let identifier = layout.identifier {
                let font = ComputedLayout.debugIdentifierFont

                var textRect = layoutFrame
                textRect.origin.y = textRect.origin.y + ((textRect.size.height - font.pointSize) / 2)

                let style = NSMutableParagraphStyle()
                style.alignment = .center

                (identifier as NSString).draw(in: textRect, withAttributes: [
                    .paragraphStyle: style,
                    .font: font,
                    .foregroundColor: strokeColor
                ])
            }

            for child in layout.children {
                draw(layout: child, offset: childOffset)
            }
        }

        draw(layout: self, offset: CGPoint(x: 8, y: 8))

        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
#endif

#if canImport(UIKit)
extension ComputedLayout: CustomPlaygroundDisplayConvertible {
    public var playgroundDescription: Any {
        return generateQuickLookImage() as Any
    }
}
#endif
