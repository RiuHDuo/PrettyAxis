//
//  PiePlot.swift
//  PrettyAxis
//
//  Created by RiuHDuo on 2021/11/24.
//

import Foundation


struct PiePlot: Plot{
    var renderData: [AxisData<String, Double, AnyHashable>]
    init<Input>(data: [Input]) where Input : Axisable {
        var total: Double = 0
        data.forEach { item in
            total += item.y as! Double
        }
        
        self.renderData = []
        self.xAxisLabels = []
        data.forEach { item in
            let axisData = AxisData<String, Double,AnyHashable>(xValue: item.x as! String, yValue: (item.y as! Double) / total, zValue: nil)
            self.renderData.append(axisData)
            self.xAxisLabels.append(axisData.xValue)
        }
        
    }
    
    var range: (min: Double, max: Double) = (0.0, 0.0)
    
    var xAxisLabels: [String]
    
    
}
