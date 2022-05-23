//
//  RadarView.swift
//  PrettyAxis
//
//  Created by RiuHDuo on 2022/5/18.
//

import SwiftUI

struct RadarView: View{
    let radarData: [(name: String, values: [Double], style: AxisPaintStyle)]
    
    var animatableData: CGFloat = 1
    var range: (CGFloat, CGFloat)
    @State var animation: Double = 0
    
    init(radarData: [(name: String, values: [Double], style: AxisPaintStyle)]){
        self.radarData = radarData
        var max: Double = radarData.first?.values.first ?? 0
        var min: Double = radarData.first?.values.first ?? 0
        radarData.forEach { v in
            v.values.forEach { value in
                if value > max {
                    max = value
                }
                if value < min{
                    min = value
                }
            }
        }
        
        self.range = (CGFloat(min), CGFloat(max))
    }
    
    var body: some View{
        VStack{
            Text(" ").font(.system(size: 14))
            ZStack{
                ForEach(self.radarData.indices, id: \.self){ index in
                    let data = self.radarData[index]
                    let r = RadarShape(values: data.values, range: self.range, animatableData: self.animation)
                    r.stroke(data.style.stroke)
                    if let fill = data.style.fill{
                        r.fill(fill)
                    }
     
                }
            }
            Text(" ").font(.system(size: 14))
        }
        .onAppear(){
            withAnimation(.linear(duration: 1)) {
                self.animation = 1
            }
        }
    }
}
