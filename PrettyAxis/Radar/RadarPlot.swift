//
//  RadarPlot.swift
//  PrettyAxis
//
//  Created by RiuHDuo on 2022/5/17.
//

import SwiftUI

public typealias RadarDataProvider = LineDataProvider

public struct RadarPlot: AxisPlot{
    public var hideReferenceLine: Bool = false
     
    public var hideLegend: Bool = false
    
    public var axisStyle: AxisStyle = LineStyle()
    
    var radarData: [(name: String, values: [Double], style: AxisPaintStyle)]
    var xAxisLabels: [String]
    var range: (Double, Double)
    
    init<D: RadarDataProvider>(entities: [AxisEntity<D>], xAxisLabels: [String] = []){
        var data = [(name: String, values: [Double], style: AxisPaintStyle)]()
        var min = data.first?.values.first ?? 0
        var max = min
        entities.forEach { entity in
            var radarData = [Double]()
            entity.dataProvider.forEach { provider in
                radarData.append(provider.y)
                if max < provider.y{
                    max = provider.y
                }
                if min > provider.y{
                    min = provider.y
                }
            }
            data.append((entity.name, radarData, entity.paintStyle))
        }
        self.radarData = data
        self.range = (min, max)
        self.xAxisLabels = xAxisLabels
    }
    
    
    
    public var body: some View{
        ZStack {
            RadarReferenceLine(labels: self.xAxisLabels, rounded: false, style: ReferenceLineStyle(xAxisLabelFont: Font.system(size: 14), xAxisLabelColor: .red, yAxisLabelColor: .purple, axesColor: .color(.blue)), range: range)
            RadarView(radarData: radarData, range: range)
        }
    }
    
    
}



public extension AxisPlot where Self == RadarPlot {
    static func radar<D: RadarDataProvider>(entities: [AxisEntity<D>], xAxisLabels: [String] = []) -> Self{
        return .init(entities: entities, xAxisLabels: xAxisLabels)
    }
}

