//
//  ScatterView.swift
//  PrettyAxis
//
//  Created by RiuHDuo on 2021/11/26.
//

import SwiftUI

struct ScatterView: View{
    var plot: ScatterPlot
    var style: ScatterStyle
    
    @State var animated: Bool = false
    
    
    var body: some View{
        if (plot.renderData[NoGroup]?.count ?? 0) < 1 && style.disableLegend == false{
            contentView.modifier(LegendModifier(list: self.plot.renderData.keys.map({($0,  style.color[$0] ?? style.fill[$0] ?? DEFAULT_COLOR)}), style: style.legendStyle))
                .onAppear(){
                    withAnimation {
                        animated = true
                    }
                }
        }else{
            contentView
                .onAppear(){
                    withAnimation {
                        animated = true
                    }
                }
        }

    }
    
    @ViewBuilder
    var contentView: some View {
        let range = ((style.fromZero ? 0:  plot.range.min), plot.range.max)
        let width = self.plot.xRange.max - self.plot.xRange.min
        ScrollView(.horizontal, showsIndicators: false) {
            VStack {
                ZStack{
                    if style.showReferenceLine{
                        ReferenceLineView(range: range, style: self.style.referenceLineStyle)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                    content( animated: animated)
                        .padding(.leading, 20)
                }
                
                HStack(spacing: 0){
                    ForEach(plot.xAxisLabels, id: \.self){ data in
                        Text(data)
                            .font(self.style.labelStyle.labelFont)
                            .foregroundColor(self.style.labelStyle.labelColor)
                            .frame(height: self.style.labelStyle.labelHeight)
                        
                        if data != plot.xAxisLabels.last{
                            Spacer()
                        }
                    }
                }
                .padding(.leading, 20)
                .frame(width: style.spacing * width, alignment: .leading)
            }
        }
    }
    
    func content(animated: Bool) -> some View{
        let keys = Array(plot.renderData.keys)
        let minY = (style.fromZero ? 0:  plot.range.min)
        let xunit = style.spacing
        let zunit = style.radius / (plot.zRange.max - plot.zRange.min)
        return GeometryReader { reader in
            let size = reader.size
            let yunit = size.height / (plot.range.max - minY)
            ZStack{
                ForEach(keys.indices){ i in
                    let key = keys[i]
                    if let fill = style.fill[key]{
                        ScatterShape(renderData: plot.renderData[key]!, yunit: yunit, xunit: xunit, zunit: zunit, radius: style.radius, xOffset: plot.xRange.min, yOffset: minY)
                            .fill(fill)
                    }else{
                        ScatterShape(renderData: plot.renderData[key]!, yunit: yunit, xunit: xunit, zunit: zunit, radius: style.radius, xOffset: plot.xRange.min, yOffset: minY)
                            .stroke(style.color[key] ?? DEFAULT_COLOR)
                    }
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .frame(height: reader.size.height)
        }
    }
    
}
