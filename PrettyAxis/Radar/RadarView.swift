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
    var range: (Double, Double)
    @State var animation: Double = 0
    
    
    var body: some View{
        VStack{
            Text(" ").font(.system(size: 14))
            ZStack{
                ForEach(self.radarData.indices, id: \.self){ index in
                    let data = self.radarData[index]
                    let r = RadarShape(values: data.values, range: (CGFloat(self.range.0), CGFloat(self.range.1)), animatableData: self.animation)
                    r.stroke(data.style.stroke)
                    if let fill = data.style.fill{
                        r.fill(fill)
                    }
     
                }
            }
            Text(" ").font(.system(size: 14))
        }
        .onAppear(){
            withAnimation(.easeInOut(duration: 2)) {
                self.animation = 1
            }
        }
    }
}
