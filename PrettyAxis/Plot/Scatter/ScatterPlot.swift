//
//  ScatterPlot.swift
//  PrettyAxis
//
//  Created by RiuHDuo on 2021/11/26.
//

import SwiftUI


struct ScatterPlot: Plot{
    var range: (min: Double, max: Double) = (min: .infinity, max: 0)
    var renderData: [String: [ScatterData]] = [:]
    init<Input, X>(data: [Input], x: KeyPath<Input, X>, y: KeyPath<Input, Double>, groupBy value: KeyPath<Input, String>?) {
        
    }
    
    init(){
        
    }
    
    var xRange: (min: Double, max: Double) = (min: .infinity, max: 0)
    var zRange: (min: Double, max: Double) = (min: .infinity, max: 0)
    var xAxisLabels: [String] = []
    
    
}
