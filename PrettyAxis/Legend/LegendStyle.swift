//
//  LegnedStyle.swift
//  PrettyAxis
//
//  Created by RiuHDuo on 2022/4/28.
//

import SwiftUI

struct AnyLegendShape: Shape{
    var shape: Any
    var p: (CGRect) -> Path
    init<S:Shape>(shape: S){
        self.shape = shape
        p = shape.path
    }
    
    func path(in rect: CGRect) -> Path {
        return self.p(rect)
    }
}

/// The style of chart legend.
///
public struct LegendStyle{
    /// Label color of legend.
    ///
    public var labelColor: Color
    
    /// Label font of legend.
    ///
    public var labelFont: Font
    
    /// Shape of legend.
    ///
    var legendShape: AnyLegendShape
    
    /// LegendShape Size
    ///
    var legendShapeSize: CGSize
    
    /// Position of legend in the chart.
    ///
    public var position: LegendPosition
    
    /// Constructor of LegendStyle
    ///
    /// - Parameters:
    ///     - position: the position of legend.
    ///     - labelFont: the Font of legend's label
    ///     - labelColor: the color of legend's label
    ///     - legendShape: the shape of ever group.
    ///
    public init<S: Shape>(position: LegendPosition = .bottom, labelFont: Font = .title, labelColor: Color = .gray, legendShape: S, legendShapeSize: CGSize = CGSize(width: 24, height: 24)){
        self.legendShape = AnyLegendShape(shape: legendShape)
        self.labelFont = labelFont
        self.labelColor = labelColor
        self.position = position
        self.legendShapeSize = legendShapeSize
    }
}


public extension LegendStyle{
    static var `default`: Self{
        .init(legendShape: Circle())
    }
}
