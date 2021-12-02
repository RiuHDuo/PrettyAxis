//
//  ScatterPlot.swift
//  PrettyAxis
//
//  Created by RiuHDuo on 2021/11/26.
//

import SwiftUI


struct ScatterPlot: Plot{
    init<Input>(data: [Input]) where Input : Axisable {
        
    }
    
    var range: (min: Double, max: Double) = (min: .infinity, max: 0)
    var renderData: [String: [ScatterData]] = [:]
    
    var xRange: (min: Double, max: Double) = (min: .infinity, max: 0)
    var zRange: (min: Double, max: Double) = (min: .infinity, max: 0)
    var xAxisLabels: [String] = []
    
    
}
