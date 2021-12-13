//
//  LabelStyle.swift
//  PrettyAxis
//
//  Created by RiuHDuo on 2021/11/19.
//

import SwiftUI


public protocol LabelStyle{
    var labelHeight: CGFloat {get}
    
    var labelFont: Font {get set}
    
    var labelColor: Color {get set}
    
    var formatter: NumberFormatter {get set}
}


struct AxisLabelStyle: LabelStyle{
    public var labelHeight: CGFloat = 20
    
    public var labelFont = Font.system(size: 8)
    
    public var labelColor = Color.black
    
    public var formatter:NumberFormatter = IntFormatter.int
}
