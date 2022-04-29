//
//  Bar.swift
//  PrettyAxis
//
//  Created by RiuHDuo on 2022/4/29.
//

import SwiftUI


struct Bar: View {
    
    var index: Double
    var value: CGFloat
    var unit: CGFloat
    var barWidth: CGFloat
    var xAxisStart: CGFloat
    var xAxisPos: CGFloat
    var offset: CGFloat
    var paintStyle: AxisPaintStyle
    var style: BarStyle
    
    @State var animatableData: CGFloat = 0

    var body: some View{
        let h = unit * (CGFloat(value - xAxisStart)) * animatableData
        var y = xAxisPos
        if h > 0{
            y = xAxisPos - h
        }
        let txt = Text(self.style.valueFormatter.format(value: value))
            .font(self.style.valueLabelFont)
            .foregroundColor(self.style.valueLabelColor)
            .frame(width: barWidth)
        return RoundedRectangle(cornerRadius: self.style.barRadius)
            .fill(paintStyle.fill ?? paintStyle.stroke)
            .frame(width: barWidth, height: max(abs(h), 1))
            .overlay(alignment: value > xAxisStart ? .bottom : .top, content: {
                VStack(spacing: 0){
                    if value > xAxisStart {
                        txt
                    }
                    Spacer()
                        .frame(height: abs(h))
                    if value <= xAxisStart {
                        txt
                    }
                }
            })
            .offset(x: offset, y: y)
            .onAppear(){
                guard let animation = self.style.animation else {
                    return
                }
                withAnimation(animation.delay(Double(index) * 0.04)){
                    self.animatableData = 1
                }
            }
    }
}
