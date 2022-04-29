//
//  BarPlot.swift
//  PrettyAxis
//
//  Created by RiuHDuo on 2022/4/28.
//

import SwiftUI

public typealias BarDataProvider = LineDataProvider

public struct BarPlot: AxisPlot{
    public var hideReferenceLine: Bool = false
     
    public var hideLegend: Bool = false
    
    public var axisStyle: AxisStyle{
        get{
            self.style
        }
        set{
            self.style = newValue.copy(to: self.style)
        }
    }
    
    var style: BarStyle = BarStyle()
    
    var maxCount = 0
    
    /// Data of line
    let barData: [(name: String, values: [Double], style: AxisPaintStyle)]
    
    /// The Y value range
    let range:(min: Double, max: Double)
    
    
    let xAxisLabels: [String]
    
    var barRange: (min: Double, max: Double) = (0, 0)
    
    public var body: some View{
        let yWidth = self.hideReferenceLine ? 0: self.style.referenceLineStyle.leadingPadding
        GeometryReader { r in
            let barWidth = self.style.barWidth ??  ((r.size.width - yWidth - 8) / CGFloat(maxCount) / CGFloat(barData.count))
            let spacing:CGFloat = self.style.spacing + barWidth * CGFloat(barData.count)
            barView(barWidth: barWidth)
                .frame(width: spacing * CGFloat(maxCount))
                .modifier(ReferenceLineModifier(isHidden: self.hideReferenceLine, labels: [], spacing: 0, range: self.barRange, style: self.style.referenceLineStyle, xAxisStartValue: self.style.xAxisAtValue ?? 0))
                .frame(width: spacing * CGFloat(maxCount) + yWidth, alignment: .leading)
                .modifier(ScrollableModifier())
                .modifier(LegendModifier(data: self.barData.map({($0.name, $0.style)}), style: self.style.legendStyle, isHidden: self.hideLegend))
        }
    }
    
    @ViewBuilder
    func barView(barWidth: CGFloat) -> some View {
        BarView(range: self.barRange, data: self.barData, barWidth: barWidth, style: self.style)
    }
    
    
    init<T>(entities: [AxisEntity<T>], xAxisLabels: [String]) where T: BarDataProvider {
        var data = [(name: String, values: [Double], style: AxisPaintStyle)]()
        var rr:(min: Double, max: Double)? = nil
        var maxCount = 0
        entities.forEach { entity in
            var range:(min: Double, max: Double) = (min: entity.dataProvider.first?.y ?? 0, max: entity.dataProvider.first?.y ?? 0)
            var lineData = [Double]()
            entity.dataProvider.forEach { provider in
                if provider.y < range.min {
                    range.min = provider.y
                }
                
                if provider.y > range.max{
                    range.max = provider.y
                }
                lineData.append(provider.y)
            }
            if let r = rr {
                rr?.min = min(r.min, range.min)
                rr?.max = max(r.max, range.max)
            }else{
                rr = range
            }
            data.append((entity.name, lineData, entity.paintStyle))
            maxCount = max(maxCount, lineData.count)
        }
        
        self.barData = data
        self.range = rr!
        self.maxCount = maxCount
        self.xAxisLabels = xAxisLabels
        self.barRange = self.calcRange(range: self.range, xAxisValue: 0, scaleFactor: 1.2)
    }
}


public extension AxisPlot where Self == BarPlot {
    static func bar<D: BarDataProvider>(entities: [AxisEntity<D>], xAxisLabels: [String] = []) -> Self{
        return .init(entities: entities, xAxisLabels: xAxisLabels)
    }
}



public extension AxisView where Plot == BarPlot{
    /// Set Chart from zero value
    ///
    /// This method only works when all value is positive or negative.
    ///
    /// - Returns: A AxisView which will render a line view start from zero value.
    func xAxisStart(at value: Double) -> Self{
        var copy = self
        var plot = copy.plot
        plot.style.xAxisAtValue = value
        plot.barRange = plot.calcRange(range: plot.range, xAxisValue: plot.style.xAxisAtValue, scaleFactor: 1.2)
        copy.plot = plot
        return copy
    }
    
    /// Hide the value label above bar
    ///
    /// - Returns: A AxisView which display without value label.
    func hideValueLabel() -> Self{
        var copy = self
        copy.plot.style.hideValueLabel = true
        return copy
    }
    
    /// Modify the value label style
    ///
    /// - Returns: A AxisView which display without specified value label style.
    func valueLabel(color: Color = .gray, font: Font = .body, formatter: ValueFormatter = .int) -> Self{
        var copy = self
        copy.plot.style.valueLabelColor = color
        copy.plot.style.valueLabelFont = font
        copy.plot.style.valueFormatter = formatter
        return copy
    }
    
    func spacing(_ spacing: CGFloat) -> Self{
        var copy = self
        copy.plot.style.spacing = spacing
        return copy
    }

    func barWidth(_ barWidth: CGFloat) -> Self{
        var copy = self
        copy.plot.style.barWidth = barWidth
        return copy
    }
    
    func barRadius(_ barRadius: CGFloat) -> Self{
        var copy = self
        copy.plot.style.barRadius = barRadius
        return copy
    }
    
    /// Set the animation of line chart when appearing.
    ///
    ///- Parameters:
    ///     - animation: the animation when line appearing.
    ///
    ///- Returns: An AxisView drawing line with specified appearing animation.
    func appearingAnimation(_ animation: Animation) -> Self{
        var copy = self
        var plot = copy.plot
        plot.style.animation = animation
        copy.plot = plot
        return copy
    }
}
