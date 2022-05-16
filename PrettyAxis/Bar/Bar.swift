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
    @State var isHover = false
    @GestureState private var isTap = false
    
    var body: some View{
        let h = unit * (CGFloat(value - xAxisStart)) * animatableData
        let w = barWidth
        let hh =  max(abs(h), 1)
        var y = xAxisPos
        if h > 0{
            y = xAxisPos - hh
        }
        let txt = Text(self.style.valueFormatter.format(value: value))
            .font(self.style.valueLabelFont)
            .foregroundColor(self.style.valueLabelColor)
            .frame(width: barWidth)
        return RoundedRectangle(cornerRadius: self.style.barRadius)
            .fill(paintStyle.fill ?? paintStyle.stroke)
            .frame(width: w, height: hh)
            .gesture(DragGesture(minimumDistance: 0)
                .onChanged({ _ in
                    self.isHover = true
                })
                .onEnded({ _ in
                    self.isHover = false
                })
            )
            .scaleEffect(isHover ? 1.1: 1.0, anchor: h < 0 ? UnitPoint.top: UnitPoint.bottom)
            .overlay(alignment: value > xAxisStart ? .bottom : .top, content: {
                VStack(spacing: 0){
                    if value > xAxisStart {
                        txt
                    }
                    Spacer()
                        .frame(height: abs(hh) * (isHover ? 1.1: 1.0))
                    if value <= xAxisStart {
                        txt
                    }
                }
            })
            .offset(x: offset, y: y)
            .onAppear(){
                guard var animation = self.style.animation else {
                    return
                }
                
                if let delay = self.style.diff {
                    animation = animation.delay(Double(index) * delay)
                }
                
                withAnimation(animation){
                    self.animatableData = 1
                }
            }
    }
}
