//
//  BarStyle.swift
//  PrettyAxis
//
//  Created by RiuHDuo on 2022/4/28.
//

import SwiftUI

struct BarStyle: AxisStyle{
    var referenceLineStyle: ReferenceLineStyle = .default
    
    var markLabelStyle: MarkLabelStyle = .default
    
    var legendStyle: LegendStyle = .default
    
    
    var barWidth: CGFloat? = nil
    
    var barRadius: CGFloat = 1
    
    var spacing: CGFloat = 0
    
    var hideValueLabel: Bool = false
    
    var valueLabelFont: Font = .body
    
    var valueLabelColor: Color = .gray
    
    var valueFormatter: ValueFormatter = .int
    
    /// The value x axis start.
    var xAxisAtValue: Double?
    
    
    var animation: Animation? = .linear
}

