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
    
    init<D: RadarDataProvider>(entities: [AxisEntity<D>], xAxisLabels: [String] = []){
        var data = [(name: String, values: [Double], style: AxisPaintStyle)]()
        entities.forEach { entity in
            var lineData = [Double]()
            entity.dataProvider.forEach { provider in
                lineData.append(provider.y)
            }
            data.append((entity.name, lineData, entity.paintStyle))
        }
        self.radarData = data
        self.xAxisLabels = xAxisLabels
    }
    
    
    
    public var body: some View{
        ZStack {
            RadarReferenceLine(labels: self.xAxisLabels, rounded: false, style: ReferenceLineStyle(xAxisLabelFont: Font.system(size: 14), xAxisLabelColor: .red, axesColor: .color(.blue)))
            RadarView(radarData: radarData)
        }
    }
    
    
}



public extension AxisPlot where Self == RadarPlot {
    static func radar<D: RadarDataProvider>(entities: [AxisEntity<D>], xAxisLabels: [String] = []) -> Self{
        return .init(entities: entities, xAxisLabels: xAxisLabels)
    }
}

