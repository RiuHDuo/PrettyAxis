//
//  RadarPlot.swift
//  PrettyAxis
//
//  Created by RiuHDuo on 2021/11/25.
//

import SwiftUI

struct RadarPlot: Plot{
    init<Input>(data: [Input]) where Input : Axisable {
        let ret = RadarPlot.arrayToGroupDictionary(data: data)
        range = ret.1
        renderData = ret.0
        xAxisLabels = ret.2
    }
    
    var renderData: [String: [AxisData<String, Double, AnyHashable>]]
    
    var range: (min: Double, max: Double)
    
    var xAxisLabels: [String]
    
    
}
