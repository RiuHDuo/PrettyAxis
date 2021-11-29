//
//  ScatterStyle.swift
//  PrettyAxis
//
//  Created by RiuHDuo on 2021/11/26.
//

import SwiftUI


public struct ScatterStyle: ChartStyle{
    public func createPlot<Input>(data: [Input]) -> (ScatterStyle, Plot) where Input : Axisable {
        var plot = ScatterPlot(data: data)
        var renderData:[String: [ScatterData]] = [:]
        var xRange = (min: Double.infinity, max: 0.0)
        var range = (min: Double.infinity, max: 0.0)
        data.forEach { item in
            let axisData = ScatterData(xValue: item.x as! Double, yValue: item.y as! Double, zValue: item.z as? Double)
            if let g = item.groupd as? String {
                if renderData[g] == nil {
                    renderData[g]  = []
                }
                renderData[g]?.append(axisData)
            }else{
                if renderData[NoGroup] == nil {
                    renderData[NoGroup] = []
                }
                renderData[NoGroup]?.append(axisData)
            }
            if range.min > axisData.yValue {
                range.min = axisData.yValue
            }
            if range.max < axisData.yValue{
                range.max = axisData.yValue
            }
            
            if xRange.min > axisData.xValue {
                xRange.min = axisData.xValue
            }
            if xRange.max < axisData.xValue{
                xRange.max = axisData.xValue
            }
        }
        
        plot.range = (min: range.min / RANGE_FACTOR, max: range.max * RANGE_FACTOR)
        plot.renderData = renderData
        plot.xRange =  (min: xRange.min / RANGE_FACTOR, max: xRange.max * RANGE_FACTOR)
        let xr = plot.xRange.max - plot.xRange.min
        plot.zRange =  (min: 0, max: 1)
        let min = Int(floor(plot.xRange.min))
        plot.xAxisLabels = ["\(min)", "\(min + Int(xr / 3))", "\(min + Int(xr / 2))", "\(min + Int(2 * xr / 3))", "\(Int(ceil(plot.xRange.max)))"]
        return (self,plot)
    }
    
    var color = [NoGroup: AnyShapeStyle(Color.blue)]
    
    var type: LineType = .smooth(curviness: 0.35)
    
    var fill:[String: AnyShapeStyle] = [:]
    
    
    public var labelWidth: CGFloat {
        return self.spacing 
    }
    
    public var spacing: CGFloat = 5
    
    public var showReferenceLine = false
        
    public var labelStyle: LabelStyle  = AxisLabelStyle()
    
    public var referenceLineStyle = ReferenceLineStyle.default
    
    public var fromZero: Bool = true

    public func contentView(plot: Plot) -> some View{
       return  ScatterView(plot: plot as! ScatterPlot, style: self)
    }
}


public extension ChartStyle where Self == ScatterStyle{
    static var scatter: Self { .init() }
}
