//
//  LegendStyle.swift
//  PrettyAxis
//
//  Created by RiuHDuo on 2021/11/30.
//

import SwiftUI


public struct LegendStyle{
    public var iconSize: CGFloat
    public var font: Font
    public var labelColor: Color
    
    
    public init(iconSize: CGFloat = 8, font: Font = Font.system(size: 8), labelColor: Color = Color.black){
        self.iconSize = iconSize
        self.font = font
        self.labelColor = labelColor
    }
}
