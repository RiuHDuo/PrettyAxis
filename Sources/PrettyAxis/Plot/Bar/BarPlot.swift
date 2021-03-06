//
//  BarPlot.swift
//  PrettyAxis
//
//  Created by RiuHDuo on 2021/11/17.
//

import SwiftUI



struct BarPlot: Plot{
    
    var range = (min: 0.0, max: 0.0)
    
    var renderData: [String: [(AxisData<String, Double, AnyHashable>, String)]]
    
    var xAxisLabels: [String]
    
    var groups = Set<String>()
    
    init<S>(data: [S]) where S: Axisable{
        assert(data.first?.x is String && data.first?.y is Double, "Bar X-Axis must be string and Y-Axis must be Double")
        var range = (min: Double.infinity, max: 0.0)
        let xAxisLabels = NSMutableOrderedSet()
        self.xAxisLabels = []
        self.renderData = [:]
        var renderData = [String: [String: AxisData<String, Double, AnyHashable>]]()
        data.forEach { item in
            let axisData = AxisData<String, Double, AnyHashable>(xValue: item.x as! String, yValue: item.y as! Double)
            var groupName = NoGroup
            if let g = item.group as? String {
                groupName = g
                xAxisLabels.add(axisData.xValue)
            }else{
                self.xAxisLabels.append(axisData.xValue)
            }
            if renderData[groupName] == nil {
                renderData[groupName] = [:]
            }
            self.groups.insert(groupName)
            renderData[groupName]?[axisData.xValue] = axisData
            
            if range.min > axisData.yValue {
                range.min = axisData.yValue
            }
            if range.max < axisData.yValue{
                range.max = axisData.yValue
            }
        }
        self.range = (min: range.min, max: range.max * RANGE_FACTOR)
        
        xAxisLabels.forEach({ x in
            let x = x as! String
            self.xAxisLabels.append(x)
        })
        
        self.xAxisLabels.forEach { x in
            var data = [(AxisData<String, Double, AnyHashable>, String)]()
            renderData.keys.forEach { key in
                data.append((renderData[key]?[x] ?? AxisData(xValue: x, yValue: 0), key ))
            }
            self.renderData[x] = data
        }
        
    }
    
}
