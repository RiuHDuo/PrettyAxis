//
//  Plot.swift
//  PrettyAxis
//
//  Created by RiuHDuo on 2021/11/17.
//

import SwiftUI



public protocol Plot{
    init<Input>(data: [Input], x: KeyPath<Input, String>, y: KeyPath<Input, Double>, groupBy value: KeyPath<Input, String>?) where Input:Any
    
    var range: (min: Double, max: Double) {get}
    
    var xAxisLabels: [String] {get}
}


extension Plot{
    static func arrayToGroupDictionary<Input:Any, X>(data: [Input], x: KeyPath<Input, X>, y: KeyPath<Input, Double>, groupBy value: KeyPath<Input, String>?)
    -> ([String: [AxisData]],(min: Double, max: Double), [String]){
        var range = (min: Double.infinity, max: 0.0)
        var renderData:[String: [AxisData]] = [:]
        var axisLabels = [String]()
        let xAxisLabelsSet = NSMutableOrderedSet()
        if value == nil {
            renderData[NoGroup] = []
        }
        data.forEach { item in
            let axisData = AxisData(xValue: "\(item[keyPath: x])", yValue: item[keyPath: y])
            if let v = value {
                let g = item[keyPath: v]
                if renderData[g] == nil {
                    renderData[g]  = []
                }
                renderData[g]?.append(axisData)
                xAxisLabelsSet.add(axisData.xValue)
            }else{
                renderData[NoGroup]?.append(axisData)
                axisLabels.append(axisData.xValue)
            }
            if range.min > axisData.yValue {
                range.min = axisData.yValue
            }
            if range.max < axisData.yValue{
                range.max = axisData.yValue
            }
        }
        range = (min: range.min, max: range.max)
        xAxisLabelsSet.forEach({ x in
            let x = x as! String
            axisLabels.append(x)
        })
        return (renderData, range, axisLabels)
    }
}
