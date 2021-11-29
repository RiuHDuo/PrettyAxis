//
//  Plot.swift
//  PrettyAxis
//
//  Created by RiuHDuo on 2021/11/17.
//

import SwiftUI



public protocol Plot{
    init<Input>(data: [Input]) where Input: Axisable
    
    var range: (min: Double, max: Double) {get}
    
    var xAxisLabels: [String] {get}
}


extension Plot{
    static func arrayToGroupDictionary<S>(data: [S]) -> ([String: [AxisData<String, Double, AnyHashable>]],(min: Double, max: Double), [String]) where S: Axisable{
        var range = (min: Double.infinity, max: 0.0)
        var renderData:[String: [AxisData<String, Double, AnyHashable>]] = [:]
        var axisLabels = [String]()
        let xAxisLabelsSet = NSMutableOrderedSet()
        renderData[NoGroup] = []
        
        data.forEach { item in
            let axisData = AxisData<String, Double, AnyHashable>(xValue: item.x as! String, yValue: item.y as! Double)
            if let g = item.groupd as? String {
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
