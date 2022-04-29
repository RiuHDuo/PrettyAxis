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
    public var hideLegend: Bool = false
    
    public var axisStyle: AxisStyle{
        get{
            self.style
        }
        set{
            self.style = newValue.copy(to: self.style)
        }
    }
    
    /// Data of line
    let lineData: [(name: String, values: [Double], style: AxisPaintStyle)]
    
    /// The Y value range
    let range:(min: Double, max: Double)
    
    /// Type Of line
    let type: LineType
    
    /// Style of Line
    var style: LineStyle = LineStyle()
    
    var maxCount: Int = 0
    
    let xAxisLabels: [String]
    
    @State var animatable: CGFloat = 0
    
    @State var markPos: [String: (CGPoint, Double)]? = nil
    
    var lineRange: (min: Double, max: Double) = (0, 0)
    var tapCallback: (([String: Double]) -> Void)? = nil
    var markView: AnyView?
    
    init<T>(entities: [AxisEntity<T>], xAxisLabels: [String], type: LineType) where T: LineDataProvider {
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
        
        self.lineData = data
        self.range = rr!
        self.type = type
        self.maxCount = maxCount
        self.xAxisLabels = xAxisLabels
        self.lineRange = self.calcRange(range: self.range, xAxisValue: self.style.xAxisAtValue)
    }
    
    public var body: some View{
        let yWidth = self.hideReferenceLine ? 0: self.style.referenceLineStyle.leadingPadding
        GeometryReader { r in
            let spacing = self.style.spacing ?? ((r.size.width - yWidth - 8) / CGFloat(maxCount - 1))
            lineView(spacing: spacing)
                .frame(width: spacing * CGFloat(maxCount - 1))
                .modifier(ReferenceLineModifier(isHidden: self.hideReferenceLine, labels: self.xAxisLabels, spacing: spacing, range: self.lineRange, style: self.style.referenceLineStyle, xAxisStartValue: self.style.xAxisAtValue))
                .frame(width: self.style.spacing == nil ? nil : self.style.spacing! * CGFloat(maxCount - 1) + yWidth, alignment: .leading)
                .modifier(ScrollableModifier())
                .modifier(LegendModifier(data: self.lineData.map({($0.name, $0.style)}), style: self.style.legendStyle, isHidden: self.hideLegend))
                .onAppear(){
                    guard let animation = self.style.animation else{
                        return
                    }
                    withAnimation(animation) {
                        self.animatable = 1
                    }
                }
        }
    }
    
    @ViewBuilder
    func lineView(spacing: CGFloat) -> some View{
        GeometryReader { r in
            ForEach(self.lineData.indices, id: \.self){ idx in
                let data = self.lineData[idx]
                self.lineView(key: data.name, lineData: data.values, spacing: spacing, paintStyle: data.style)
            }
            .gesture(DragGesture()
                .onChanged({ value in
                    guard let _ = self.markView else{
                        return
                    }
                    let p =  round(value.location.x / spacing)
                    if p >= 0 {
                        let unit = (r.size.height) / (lineRange.max - lineRange.min)
                        var marks = [String: (CGPoint, Double)]()
                        var values = [String: Double]()
                        self.lineData.forEach { data in
                            if Int(p) < data.values.count {
                                let axisData = data.values[Int(p)]
                                let p = CGPoint(x: p * spacing, y: r.size.height - (axisData -  CGFloat(lineRange.min)) * unit)
                                marks[data.name] = (p, axisData)
                                values[data.name] = axisData
                            }
                        }
                        self.markPos = marks
                        self.tapCallback?(values)
                    }
                })
            )
        }
    }
    
    func lineView(key: String, lineData:  [Double], spacing: CGFloat, paintStyle: AxisPaintStyle) -> some View {
        return ZStack{
            if let fill = paintStyle.fill{
                Line(points: lineData, range: self.lineRange, lineType: self.type, isFilled: true, spacing: spacing,  animatableData: 1)
                    .fill(fill)
                    .clipShape(Rectangle().scale(x: self.animatable, y: 1, anchor: UnitPoint.leading))
            }
            
            Line(points: lineData, range: self.lineRange, lineType: self.type, isFilled: false, spacing: spacing, animatableData: self.animatable)
                .stroke(paintStyle.stroke, style: StrokeStyle(lineWidth: self.style.lineWidth, lineCap: .round, lineJoin: .round))
            
            if let pos = self.markPos?[key], let markView = self.markView {
                if self.axisStyle.markLabelStyle.disableValueLabel {
                    markView
                        .position(x: pos.0.x, y: pos.0.y)
                }else{
                    VStack(spacing:0) {
                        Text(self.axisStyle.markLabelStyle.formatter.format(value: pos.1))
                            .font(self.axisStyle.markLabelStyle.font)
                            .foregroundColor(self.axisStyle.markLabelStyle.color)
                        markView
                        Text("")
                            .font(self.axisStyle.markLabelStyle.font)
                            .foregroundColor(self.axisStyle.markLabelStyle.color)
                    }
                    .position(x: pos.0.x, y: pos.0.y)
                }
            }
        }
    }
    
    
}






public extension AxisPlot where Self == LinePlot {
    static func line<D: LineDataProvider>(entities: [AxisEntity<D>], xAxisLabels: [String] = [], type: LineType = .smooth(curviness: 0.5)) -> Self{
        return .init(entities: entities, xAxisLabels: xAxisLabels, type: type)
    }
}



public extension AxisView where Plot == LinePlot{
    /// Set Chart from zero value
    ///
    /// This method only works when all value is positive or negative.
    ///
    ///- Parameters:
    ///     - value: the value which x-axis is.
    ///
    /// - Returns: A AxisView which will render a line view start from zero value.
    func xAxisStart(at value: Double) -> Self{
        var copy = self
        var plot = copy.plot
        plot.style.xAxisAtValue = value
        plot.lineRange = plot.calcRange(range: plot.range, xAxisValue: plot.style.xAxisAtValue)
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
    
    /// Disable animation of line chart when appearing.
    ///
    ///- Returns: An AxisView drawing line without any appearing animation.
    func disableAppearingAnimation() -> Self{
        var copy = self
        var plot = copy.plot
        plot.style.animation = nil
        copy.plot = plot
        return copy
    }
    
    /// Set the line tap event handler
    ///
    ///- Parameters:
    ///     - mark: The mark view when tap at value.
    ///     - markLabelStyle: the style of mark value label.
    ///     - callback: the event callback. [String: Double] is [EntityName: Tapped Value].
    func onTap<V: View>(with mark: V?, markLabelStyle: MarkLabelStyle = .default, callback:  (([String: Double]) -> Void)? = nil) -> Self{
        var copy = self
        var plot = copy.plot
        plot.markView = nil
        if let mark = mark{
            plot.markView = AnyView(mark)
        }
        plot.tapCallback = callback
        plot.axisStyle.markLabelStyle = markLabelStyle
        copy.plot = plot
        return copy
    }
}
