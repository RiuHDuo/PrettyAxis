//
//  MarkLabelStyel.swift
//  PrettyAxis
//
//  Created by RiuHDuo on 2022/4/27.
//

import SwiftUI


public struct MarkLabelStyle{
    public var font: Font
    public var color: Color
    public var formatter: ValueFormatter
    
    
    public init(font: Font, color: Color, formatter: ValueFormatter){
        self.font = font
        self.color = color
        self.formatter = formatter
    }
}


public extension MarkLabelStyle{
    static var `default`: Self {
        .init(font: Font.footnote, color: .gray, formatter: .int)
    }
}
