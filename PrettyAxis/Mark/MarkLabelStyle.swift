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
    public var disableValueLabel: Bool
    
    public init(font: Font = .footnote, color: Color = .gray, formatter: ValueFormatter = .int, disableValueLabel: Bool = false){
        self.font = font
        self.color = color
        self.formatter = formatter
        self.disableValueLabel = false
    }
}


public extension MarkLabelStyle{
    static var `default`: Self {
        .init()
    }
}
