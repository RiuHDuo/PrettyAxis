//
//  RadarPlot.swift
//  PrettyAxis
//
//  Created by RiuHDuo on 2021/11/25.
//

import SwiftUI

struct RadarPlot: Plot{
    var renderData: [String: [AxisData]]
    init<Input, X>(data: [Input], x: KeyPath<Input, X>, y: KeyPath<Input, Double>, groupBy value: KeyPath<Input, String>?) {
        let ret = RadarPlot.arrayToGroupDictionary(data: data, x: x, y: y, groupBy: value)
        range = ret.1
        renderData = ret.0
        xAxisLabels = ret.2
    }
    
    var range: (min: Double, max: Double)
    
    var xAxisLabels: [String]
    
    
}
