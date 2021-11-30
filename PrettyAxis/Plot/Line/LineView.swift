//
//  LineView.swift
//  PrettyAxis
//
//  Created by RiuHDuo on 2021/11/18.
//

import SwiftUI


struct LineView: View{
    var plot: LinePlot
    var style: LineStyle
    
    @State var animated: Bool = false
    
    var body: some View{
        if (plot.renderData[NoGroup]?.count ?? 0) < 1 && self.style.disableLegend == false{
            content(animated: animated)
                .modifier(ScrollableModifier(plot: self.plot, style: self.style))
                .modifier(LegendModifier(list: self.plot.renderData.keys.map({($0,  style.color[$0] ?? style.fill[$0] ?? DEFAULT_COLOR)}), style: style.legendStyle))
                .onAppear(){
                    withAnimation {
                        animated = true
                    }
                }
        }else{
            content(animated: animated)
                .modifier(ScrollableModifier(plot: self.plot, style: self.style))
                .onAppear(){
                    withAnimation {
                        animated = true
                    }
                }
        }
    }
    
    func content(animated: Bool) -> some View{
        let range = ((style.fromZero ? 0 : plot.range.min), plot.range.max)
        let keys = plot.renderData.keys.map({$0})
        let animatableData: CGFloat =  animated ? 1: 0
        return  GeometryReader { reader in
            let size = reader.size
            VStack(alignment: .leading) {
                ZStack {
                    ForEach(keys.indices) { i in
                        let key = keys[i]
                        let data = plot.renderData[key]!
                        let stroke = style.color[key] ?? AnyShapeStyle(Color.red)
                        
                        if let fill = style.fill[key] {
                            Line(points: data, range: range, spacing: style.spacing, animatableData: animatableData,lineType: style.type, isFilled: true)
                                .fill(fill)
                                .frame(width: size.width)
                                .frame(maxHeight: .infinity,alignment: .bottomLeading)
                        }
                        
                        Line(points: data, range: range, spacing: style.spacing, animatableData: animatableData,lineType: style.type)
                            .stroke(stroke, style: StrokeStyle(lineWidth: style.lineWidth,lineCap: .round, lineJoin: .round))
                            .frame(width: size.width)
                            .frame(maxHeight: .infinity,alignment: .bottomLeading)
                        
                        if let mark = style.marks[key]{
                            LineMark(points: data, range: range, spacing: style.spacing, animatableData: animatableData, lineType: style.type, mark: mark.path)
                                .fill( style.markFill[key]!)
                        }
                        
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
                }
            }
            .frame(height: reader.size.height)
        }
    }
}

