//
//  RadarView.swift
//  Example
//
//  Created by RiuHDuo on 2021/12/6.
//

import SwiftUI
import PrettyAxis

class DoubleFormat: PrettyAxis.NumberFormatter{
    func format(value: Double) -> String {
        return String(format: "%.1f", value)
    }
    
    
}

struct RadarView: View {
    @State var sorted = false
    var body: some View {
        let fill = ["Batman": g1, "Superman": g2, "The Flash": g3, "Wonder Women": g4, "Cyborg": g5, "Aquaman": g6]
        HStack {
            AxisView(style: .doughnut(innerRadiusPercent: 0.3), data: values5)
                .fill(fill)
                .stroke(colors5[2])
                .xAxisLabelColor(Color.yellow)
                .outerReferenceLine(style: ReferenceLineStyle(axisColor: Color.yellow, axisLabelColor: Color.yellow, xAxisLabelFont: .system(size: 15).bold(), formatter: PercentFormat()))
                .spacing(50)
                .enableLegend(true, style: LegendStyle(labelColor: Color.yellow))
                .fromZero(false)
                .padding()
        }
        .background(Color.black)
        
    }
    
    func sort1(v1: String, v2: String) -> Bool{
        return v1 > v2
    }
    
    func sort2(v1: String, v2: String) -> Bool{
        return v1 < v2
    }
}

struct RadarView_Previews: PreviewProvider {
    static var previews: some View {
        RadarView()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
