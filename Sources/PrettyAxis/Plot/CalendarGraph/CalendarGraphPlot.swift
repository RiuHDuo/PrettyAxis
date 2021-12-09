//
//  CalendarGraphPlot.swift
//  PrettyAxis
//
//  Created by RiuHDuo on 2021/12/9.
//

import SwiftUI


struct CalendarGraphPlot: Plot{
    var renderData = [String: [String: AxisData<String, String, Double>]]()
    
    var range: (min: Double, max: Double) = (0.0, 0.0)
    
    var xAxisLabels: [String] = []
    
    var yAxisLabels: [String] = []
    
    init<Input>(data: [Input]) where Input : Axisable {
        assert(data.first?.x is String && data.first?.y is String && data.first?.z is Double, "X value should be String Y value should be String and Z value Should be Double")
        
        var range = (min: Double.infinity, max: 0.0)
        var renderData = [String: [String: AxisData<String, String, Double>]]()
        let xSet = NSMutableOrderedSet()
        let ySet = NSMutableOrderedSet()
        data.forEach { data in
            let axisData = AxisData(xValue: data.x as! String, yValue: data.y as! String, zValue: data.z as? Double)
            if renderData[axisData.xValue] == nil{
                renderData[axisData.xValue] = [:]
                xSet.add(axisData.xValue)
            }
            ySet.add(axisData.yValue)
            renderData[axisData.xValue]?[axisData.yValue] = axisData
            
            if axisData.zValue! < range.min {
                range.min = axisData.zValue!
            }
            
            if axisData.zValue! > range.max {
                range.max = axisData.zValue!
            }
            
        }
        
        xAxisLabels = xSet.map({$0 as! String})
        yAxisLabels = ySet.map({$0 as! String})
        self.renderData = renderData
        self.range = range
        
    }
}
