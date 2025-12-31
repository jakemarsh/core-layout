//
//  YogaExtensions.swift
//  CoreLayout
//
//  Swift-friendly extensions for Yoga C enums
//

import Foundation
import YogaLayout

// MARK: - YGOverflow

extension YGOverflow {
    public static var visible: YGOverflow { YGOverflowVisible }
    public static var hidden: YGOverflow { YGOverflowHidden }
    public static var scroll: YGOverflow { YGOverflowScroll }
}

// MARK: - YGAlign

extension YGAlign {
    public static var auto: YGAlign { YGAlignAuto }
    public static var flexStart: YGAlign { YGAlignFlexStart }
    public static var center: YGAlign { YGAlignCenter }
    public static var flexEnd: YGAlign { YGAlignFlexEnd }
    public static var stretch: YGAlign { YGAlignStretch }
    public static var baseline: YGAlign { YGAlignBaseline }
    public static var spaceBetween: YGAlign { YGAlignSpaceBetween }
    public static var spaceAround: YGAlign { YGAlignSpaceAround }
}

// MARK: - YGFlexDirection

extension YGFlexDirection {
    public static var column: YGFlexDirection { YGFlexDirectionColumn }
    public static var columnReverse: YGFlexDirection { YGFlexDirectionColumnReverse }
    public static var row: YGFlexDirection { YGFlexDirectionRow }
    public static var rowReverse: YGFlexDirection { YGFlexDirectionRowReverse }
}

// MARK: - YGJustify

extension YGJustify {
    public static var flexStart: YGJustify { YGJustifyFlexStart }
    public static var center: YGJustify { YGJustifyCenter }
    public static var flexEnd: YGJustify { YGJustifyFlexEnd }
    public static var spaceBetween: YGJustify { YGJustifySpaceBetween }
    public static var spaceAround: YGJustify { YGJustifySpaceAround }
}

// MARK: - YGWrap

extension YGWrap {
    public static var noWrap: YGWrap { YGWrapNoWrap }
    public static var wrap: YGWrap { YGWrapWrap }
    public static var wrapReverse: YGWrap { YGWrapWrapReverse }
}

// MARK: - YGDisplay

extension YGDisplay {
    public static var flex: YGDisplay { YGDisplayFlex }
    public static var none: YGDisplay { YGDisplayNone }
}

// MARK: - YGEdge

extension YGEdge {
    public static var left: YGEdge { YGEdgeLeft }
    public static var top: YGEdge { YGEdgeTop }
    public static var right: YGEdge { YGEdgeRight }
    public static var bottom: YGEdge { YGEdgeBottom }
    public static var start: YGEdge { YGEdgeStart }
    public static var end: YGEdge { YGEdgeEnd }
    public static var horizontal: YGEdge { YGEdgeHorizontal }
    public static var vertical: YGEdge { YGEdgeVertical }
    public static var all: YGEdge { YGEdgeAll }
}

// MARK: - YGMeasureMode

extension YGMeasureMode {
    public static var undefined: YGMeasureMode { YGMeasureModeUndefined }
    public static var exactly: YGMeasureMode { YGMeasureModeExactly }
    public static var atMost: YGMeasureMode { YGMeasureModeAtMost }
}
