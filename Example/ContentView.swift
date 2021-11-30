//
//  ContentView.swift
//  Example
//
//  Created by RiuHDuo on 2021/11/15.
//

import SwiftUI
import PrettyAxis
let star = Path{ bezierPath in
    bezierPath.move(to: CGPoint(x: 21.89, y: 8.21))
    bezierPath.addLine(to: CGPoint(x: 21.89, y: 8.23))
    bezierPath.addCurve(to: CGPoint(x: 20.21, y: 6.79), control1: CGPoint(x: 21.65, y: 7.47), control2: CGPoint(x: 21, y: 6.91))
    bezierPath.addLine(to: CGPoint(x: 15.17, y: 6.01))
    bezierPath.addLine(to: CGPoint(x: 12.93, y: 1.23))
    bezierPath.addLine(to: CGPoint(x: 12.92, y: 1.22))
    bezierPath.addCurve(to: CGPoint(x: 11.01, y: 0), control1: CGPoint(x: 12.58, y: 0.48), control2: CGPoint(x: 11.83, y: 0))
    bezierPath.addLine(to: CGPoint(x: 11, y: 0))
    bezierPath.addCurve(to: CGPoint(x: 9.08, y: 1.22), control1: CGPoint(x: 10.17, y: 0), control2: CGPoint(x: 9.42, y: 0.48))
    bezierPath.addLine(to: CGPoint(x: 6.83, y: 6.01))
    bezierPath.addLine(to: CGPoint(x: 1.81, y: 6.78))
    bezierPath.addLine(to: CGPoint(x: 1.83, y: 6.78))
    bezierPath.addCurve(to: CGPoint(x: 0.12, y: 8.19), control1: CGPoint(x: 1.04, y: 6.89), control2: CGPoint(x: 0.38, y: 7.44))
    bezierPath.addLine(to: CGPoint(x: 0.12, y: 8.2))
    bezierPath.addCurve(to: CGPoint(x: 0.59, y: 10.36), control1: CGPoint(x: -0.14, y: 8.95), control2: CGPoint(x: 0.04, y: 9.79))
    bezierPath.addLine(to: CGPoint(x: 4.3, y: 14.17))
    bezierPath.addLine(to: CGPoint(x: 3.43, y: 19.52))
    bezierPath.addLine(to: CGPoint(x: 3.43, y: 19.53))
    bezierPath.addCurve(to: CGPoint(x: 5.2, y: 21.97), control1: CGPoint(x: 3.24, y: 20.69), control2: CGPoint(x: 4.04, y: 21.79))
    bezierPath.addCurve(to: CGPoint(x: 6.56, y: 21.73), control1: CGPoint(x: 5.67, y: 22.04), control2: CGPoint(x: 6.15, y: 21.96))
    bezierPath.addLine(to: CGPoint(x: 11, y: 19.27))
    bezierPath.addLine(to: CGPoint(x: 15.44, y: 21.73))
    bezierPath.addLine(to: CGPoint(x: 15.44, y: 21.73))
    bezierPath.addCurve(to: CGPoint(x: 18.33, y: 20.9), control1: CGPoint(x: 16.47, y: 22.3), control2: CGPoint(x: 17.76, y: 21.93))
    bezierPath.addCurve(to: CGPoint(x: 18.57, y: 19.53), control1: CGPoint(x: 18.56, y: 20.49), control2: CGPoint(x: 18.65, y: 20))
    bezierPath.addLine(to: CGPoint(x: 17.7, y: 14.17))
    bezierPath.addLine(to: CGPoint(x: 21.39, y: 10.38))
    bezierPath.addCurve(to: CGPoint(x: 21.89, y: 8.21), control1: CGPoint(x: 21.95, y: 9.8), control2: CGPoint(x: 22.14, y: 8.97))
    bezierPath.closeSubpath()
}

let values = PreviewData.load([TestChartData].self, fileName: "ChartData") ?? [TestChartData]()
let values2 = PreviewData.load([TestChartData2].self, fileName: "ChartData2") ?? [TestChartData2]()
let values3 = PreviewData.load([TestChartData3].self, fileName: "ChartData3") ?? [TestChartData3]()
let values4 = PreviewData.load([TestChartData4].self, fileName: "ChartData4") ?? [TestChartData4]()

let colors1 = [Color(hue: 14 / 360.0, saturation: 0.88, brightness: 0.99), Color(hue: 40 / 360.0, saturation: 0.79, brightness: 0.97)]

let colors2 = [Color(hue: 191 / 360.0, saturation: 0.91, brightness: 0.92), Color(hue: 280 / 360.0, saturation: 0.52, brightness: 0.93), Color(hue: 356 / 360.0, saturation: 0.68, brightness: 0.96)]

let colors3 = [Color(hue: 145 / 360.0, saturation: 0.22, brightness: 0.9),
               Color(hue: 41 / 360.0, saturation: 0.46, brightness: 0.98),
               Color(hue: 358 / 360.0, saturation: 0.51, brightness: 0.97)]

let colors4 = [Color(hue: 308 / 360.0, saturation: 0.23, brightness: 0.77),
               Color(hue: 51 / 360.0, saturation: 0.16, brightness: 0.85),
               Color(hue: 217 / 360.0, saturation: 0.37, brightness: 0.81)]

let g1 = LinearGradient(colors: colors1.map({$0.opacity(0.5)}), startPoint: UnitPoint(x: 0.5, y: 0), endPoint: UnitPoint(x: 0.5, y: 1))

let g2 = LinearGradient(colors:  colors2.map({$0.opacity(0.5)}), startPoint: UnitPoint(x: 0.5, y: 0), endPoint: UnitPoint(x: 0.5, y: 1))

let g3 = LinearGradient(colors:  colors3.map({$0.opacity(0.5)}), startPoint: UnitPoint(x: 0.5, y: 0), endPoint: UnitPoint(x: 0.5, y: 1))

let g4 = LinearGradient(colors:  colors4.map({$0.opacity(0.5)}), startPoint: UnitPoint(x: 0.5, y: 0), endPoint: UnitPoint(x: 0.5, y: 1))

let g5 = LinearGradient(colors: colors1, startPoint: UnitPoint(x: 0.5, y: 0), endPoint: UnitPoint(x: 0.5, y: 1))

let g6 = LinearGradient(colors:  colors2, startPoint: UnitPoint(x: 0.5, y: 0), endPoint: UnitPoint(x: 0.5, y: 1))

let g7 = LinearGradient(colors: colors3, startPoint: UnitPoint(x: 0.5, y: 0), endPoint: UnitPoint(x: 0.5, y: 1))

let g8 = LinearGradient(colors: colors4, startPoint: UnitPoint(x: 0, y: 0.5), endPoint: UnitPoint(x: 1, y: 0.5))

let g9 = AngularGradient(colors: colors4, center: UnitPoint(x: 0.5, y: 0.5))

struct ContentView: View {
    var body: some View {
        ScrollView {
            VStack {
                Text("Line").font(.title).bold().foregroundColor(Color.white).frame(maxWidth: .infinity, alignment: .leading).padding(.horizontal)
                line
                    .frame(height: 200)
                    .frame(maxWidth: .infinity)
                    .background(RoundedRectangle(cornerRadius: 15))
                    .padding(.horizontal)
                
                Text("Bar").font(.title).bold().foregroundColor(Color.white).frame(maxWidth: .infinity, alignment: .leading)           .padding(.horizontal)
                
                bar
                    .frame(height: 200)
                    .frame(maxWidth: .infinity)
                    .background(RoundedRectangle(cornerRadius: 15))
                    .padding(.horizontal)
                
                Text("Group").font(.title).bold().foregroundColor(Color.white).frame(maxWidth: .infinity, alignment: .leading)           .padding(.horizontal)
                
                groupedBar
                    .frame(height: 200)
                    .frame(maxWidth: .infinity)
                    .background(RoundedRectangle(cornerRadius: 15))
                    .padding(.horizontal)
                
                
                Text("Radar").font(.title).bold().foregroundColor(Color.white).frame(maxWidth: .infinity, alignment: .leading)           .padding(.horizontal)
                
                radar
                    .frame(height: 375)
                    .frame(maxWidth: .infinity)
                    .background(RoundedRectangle(cornerRadius: 15))
                    .padding()
                
                Text("Scatter").font(.title).bold().foregroundColor(Color.white).frame(maxWidth: .infinity, alignment: .leading)           .padding(.horizontal)
                
                scatter
                    .frame(height: 200)
                    .frame(maxWidth: .infinity)
                    .background(RoundedRectangle(cornerRadius: 15))
                    .padding(.horizontal)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .background(Color(hue: 232 / 360 , saturation: 0.1, brightness: 0.14))
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(Color(hue: 232 / 360 , saturation: 0.1, brightness: 0.14))
        
    }
    
    @ViewBuilder
    var line: some View {
        let stroke = ["London": g5, "Berlin": g6]
        let fill = ["London": g1, "Berlin": g2]
        
        ChartView(style: .line, data: values2)
            .stroke(stroke)
            .fill(fill)
            .labelColor(Color.yellow)
            .referenceLine(style: ReferenceLineStyle(axisColor: Color.yellow))
            .spacing(50)
            .enableLegend(true, style: LegendStyle(labelColor: Color.white))
            .fromZero(false)
            .padding()
    }
    
    @ViewBuilder
    var bar: some View {
        ChartView(style: .bar, data: values)
            .fill(g5)
            .fromZero(true)
            .labelColor(Color.yellow)
            .referenceLine(style: ReferenceLineStyle(axisColor: Color.yellow))
            .spacing(50)
            .enableLegend(true, style: LegendStyle(labelColor: Color.white))
            .padding()
    }
    
    @ViewBuilder
    var groupedBar: some View {
        let fill = ["London": g6, "Berlin": g7]
        ChartView(style: .bar, data: values2)
            .fill(fill)
            .barWidth(30)
            .spacing(10)
            .enableValueLabel(enable: true, font: .system(size: 14).bold(),color: Color.orange)
            .fromZero(true)
            .labelColor(Color.yellow)
            .referenceLine(style: ReferenceLineStyle(axisColor: Color.yellow))
            .spacing(10)
            .enableLegend(true, style: LegendStyle(labelColor: Color.white))
            .padding()
    }
    
    @ViewBuilder
    var radar: some View {
        let fill = ["用户 A": g6, "用户 B": g7]
        ChartView(style: .radar, data: values3)
            .fill(fill)
            .labelColor(Color.yellow)
            .setMaxValue(100)
            .roundedReferenceLine()
            .referenceLine(style: ReferenceLineStyle(axisColor: Color.yellow, axisLabelColor: Color.red, yAxisLabelFont: Font.system(size: 10).bold()))
            .enableLegend(true, style: LegendStyle(labelColor: Color.white))
        
    }
    
    @ViewBuilder
    var scatter: some View {
        let fill = ["male": Color.red, "female": Color.blue]
        ChartView(style: .scatter, data: values4)
            .fill(fill)
            .stroke(fill)
            .spacing(3)
            .labelColor(Color.yellow)
            .enableLegend(true, style: LegendStyle(labelColor: Color.white))
            .referenceLine(style: ReferenceLineStyle(axisColor: Color.yellow, axisLabelColor: Color.yellow))
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
