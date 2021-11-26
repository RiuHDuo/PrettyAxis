//
//  LinePlot.swift
//  PrettyAxis
//
//  Created by RiuHDuo on 2021/11/18.
//

import SwiftUI


struct LinePlot: Plot{
    var range = (min: 0.0, max: 0.0)
    var renderData: [String:[AxisData]]

    init<S, X>(data: [S], x: KeyPath<S, X>, y: KeyPath<S, Double>, groupBy value: KeyPath<S, String>? = nil) {
        let ret = RadarPlot.arrayToGroupDictionary(data: data, x: x, y: y, groupBy: value)
        range = (min: ret.1.min, max: ret.1.max * RANGE_FACTOR)
        renderData = ret.0
        xAxisLabels = ret.2
    }
    
    var xAxisLabels: [String]
    
}
