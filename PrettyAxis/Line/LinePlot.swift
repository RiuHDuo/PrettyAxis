//
//  LinePlot.swift
//  PrettyAxis
//
//  Created by RiuHDuo on 2022/4/24.
//

import SwiftUI

/// Line Plot
///
public struct LinePlot: AxisPlot{
    public var hideReferenceLine: Bool = false
    
    public var axisStyle: AxisStyle{
        get{
            self.style
        }
        set{
            self.style = newValue.copy(to: self.style)
        }
    }
    
    /// Data of line
    let lineData: [(x: String, y: Double)]
    
    /// The Y value range
    let range:(min: Double, max: Double)
    
    /// Type Of line
    let type: LineType
    
    /// Style of Line
    var style: LineStyle = LineStyle()
    
    @State var animatable: CGFloat = 0
    
    init<T>(provider: [T], type: LineType) where T: LineDataProvider {
        var range:(min: Double, max: Double) = (min: provider.first?.y ?? 0, max: provider.first?.y ?? 0)
        var lineData = [(x: String, y: Double)]()
        provider.forEach { provider in
            if provider.y < range.min {
                range.min = provider.y
            }
            
            if provider.y > range.max{
                range.max = provider.y
            }
            lineData.append((x: provider.x, y: provider.y))
        }
        
        self.lineData = lineData
        self.range = range
        self.type = type
    }
    
    public var body: some View{
        lineView
            .modifier(ReferenceLineModifier(isHidden: self.hideReferenceLine, labels: self.lineData.map({$0.x}), spacing: self.style.spacing, range: self.lineRange, style: self.style.referenceLineStyle))
            .modifier(LegendModifier(isHidden: false))
            .onAppear(){
                guard let animation = self.style.animation else{
                    return
                }
                withAnimation(animation) {
                    self.animatable = 1
                }
            }
    }
    
    @ViewBuilder
    var lineView: some View{
        ZStack{
            if let fill = self.style.fill{
                Line(points: self.lineData, range: self.lineRange, lineType: self.type, isFilled: true, spacing: self.style.spacing,  animatableData: 1)
                    .fill(fill)
                    .clipShape(Rectangle().scale(x: self.animatable, y: 1, anchor: UnitPoint.leading))
            }
            
            Line(points: self.lineData, range: self.lineRange, lineType: self.type, isFilled: false, spacing: self.style.spacing, animatableData: self.animatable)
                .stroke(self.style.stroke, style: StrokeStyle(lineWidth: self.style.lineWidth, lineCap: .round, lineJoin: .round))
        }
    }
    
    var lineRange: (min: Double, max: Double){
        get{
            if self.range.min > 0 && self.style.isFromZero {
                return (min: 0.0, max: self.range.max * 1.2)
            }
            
            let v = max(abs(range.min),abs(range.max))
            
            return (min: -v, max: v)
        }
    }
}






public extension AxisPlot where Self == LinePlot {
    static func line<D: LineDataProvider>(provider: [D], type: LineType = .smooth(curviness: 0.5)) -> Self{
        return .init(provider: provider, type: type)
    }
}



public extension AxisView where Plot == LinePlot{
    func isFromZeroValue(_ isFromZero: Bool) -> Self{
        var copy = self
        var plot = copy.plot
        plot.style.isFromZero = isFromZero
        copy.plot = plot
        return copy
    }
    
    func spacing(_ spacing: CGFloat) -> Self{
        var copy = self
        var plot = copy.plot
        plot.style.spacing = spacing
        copy.plot = plot
        return copy
    }
    
    func stroke<S: ShapeStyle>(_ stroke: S) -> Self{
        var copy = self
        var plot = copy.plot
        plot.style.stroke = AnyShapeStyle(stroke)
        copy.plot = plot
        return copy
    }
    
    func fill<S: ShapeStyle>(_ fill: S) -> Self{
        var copy = self
        var plot = copy.plot
        plot.style.fill = AnyShapeStyle(fill)
        copy.plot = plot
        return copy
    }
    
    func appearAnimation(_ animation: Animation) -> Self{
        var copy = self
        var plot = copy.plot
        plot.style.animation = animation
        copy.plot = plot
        return copy
    }
}
