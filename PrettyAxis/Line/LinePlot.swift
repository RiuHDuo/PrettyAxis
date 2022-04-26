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
    
    @State var markPos: CGPoint? = nil
    
    var tapCallback: ((String, Double) -> Void)? = nil
    var markView: AnyView?
    
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
        let yWidth = self.hideReferenceLine ? 0: self.style.referenceLineStyle.yAxisWidth
        lineView
            .modifier(ReferenceLineModifier(isHidden: self.hideReferenceLine, labels: self.lineData.map({$0.x}), spacing: self.style.spacing, range: self.lineRange, style: self.style.referenceLineStyle))
            .modifier(LegendModifier(isHidden: false))
            .frame(width: self.style.spacing == nil ? nil : self.style.spacing! * CGFloat(self.lineData.count - 1) + yWidth)
            .modifier(ScrollableModifier())
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
        GeometryReader { r in
            let spacing = self.style.spacing ?? (r.size.width / CGFloat(self.lineData.count - 1))
            ZStack{
                if let fill = self.style.fill{
                    Line(points: self.lineData, range: self.lineRange, lineType: self.type, isFilled: true, spacing: spacing,  animatableData: 1)
                        .fill(fill)
                        .clipShape(Rectangle().scale(x: self.animatable, y: 1, anchor: UnitPoint.leading))
                }
                
                Line(points: self.lineData, range: self.lineRange, lineType: self.type, isFilled: false, spacing: spacing, animatableData: self.animatable)
                    .stroke(self.style.stroke, style: StrokeStyle(lineWidth: self.style.lineWidth, lineCap: .round, lineJoin: .round))
                
                if let pos = self.markPos, let markView = self.markView {
                    markView
                        .position(x: pos.x, y: pos.y)
                    
                }
            }
            .gesture(DragGesture()
                .onChanged({ value in
                    guard let _ = self.markView else{
                        return
                    }
                    let p =  round(value.location.x / spacing)
                    if p >= 0 && Int(p) < self.lineData.count {
                        let unit = (r.size.height) / (lineRange.max - lineRange.min)
                        let axisData = self.lineData[Int(p)]
                        let p = CGPoint(x: p * spacing, y: r.size.height - (axisData.y -  CGFloat(lineRange.min)) * unit)
                        self.markPos = p
                        self.tapCallback?(axisData.x, axisData.y)
                    }
                })
            )
        }
    }
    
    var lineRange: (min: Double, max: Double){
        get{
            let scaleFactor = 1.05
            if self.range.min > 0 && self.style.isFromZero {
                return (min: 0.0, max: self.range.max * scaleFactor)
            }
            
            if self.range.min > 0 {
                return (min: self.range.min, max: self.range.max * scaleFactor)
            }
            
            if self.range.max < 0 && self.style.isFromZero{
                return (min: self.range.min * scaleFactor, max: 0)
            }
            
            if self.range.max < 0 {
                return (min: self.range.min * scaleFactor, max: self.range.max)
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
    /// Set Chart from zero value
    ///
    /// This method only works when all value is positive or negative.
    ///
    /// - Returns: A AxisView which will render a line view start from zero value.
    func fromZeroValue() -> Self{
        var copy = self
        var plot = copy.plot
        plot.style.isFromZero = true
        copy.plot = plot
        return copy
    }
    
    /// Set the distance between adjacent point.
    ///
    /// If not set the space, AxisView will calculate the distance base on view's width.
    ///
    /// - Parameters:
    ///     - spacing: the distance between adjacent point.
    ///
    ///- Returns: An AxisView drawing point with specified distance.
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
    
    func onTap<V: View>(with mark: V, callback: @escaping (String, Double) -> Void) -> Self{
        var copy = self
        var plot = copy.plot
        plot.markView = AnyView(mark)
        plot.tapCallback = callback
        copy.plot = plot
        return copy
    }
}
