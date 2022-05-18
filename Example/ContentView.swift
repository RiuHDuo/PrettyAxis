//
//  ContentView.swift
//  Example
//
//  Created by RiuHDuo on 2022/4/25.
//

import SwiftUI
import PrettyAxis

struct ContentView: View {
    let originalData = ["Test1":  PreviewData.load([TestChartData].self, fileName: "ChartData") ?? [TestChartData](), "Test2": PreviewData.load([TestChartData].self, fileName: "ChartData2") ?? [TestChartData]()]
    
    @State var value = "0.0"
    var body: some View {
        VStack {
            Text(self.value)
                .font(.largeTitle)
                .foregroundColor(.black)
                .frame(maxWidth:.infinity, alignment: .leading)
                .padding()
            radarView
        }
    }
    
    var entities: [AxisEntity<TestChartData>]{
        let style = LinearGradient(colors: [Color("Color8").opacity(1), Color("Color7").opacity(1)], startPoint: UnitPoint.topLeading, endPoint: UnitPoint.bottomTrailing)
        let style2 = LinearGradient(colors: [Color("Color10").opacity(1), Color("Color9").opacity(1)], startPoint: UnitPoint.topLeading, endPoint: UnitPoint.bottomTrailing)
        
        let fill = LinearGradient(colors: [Color("Color8").opacity(0.5), Color("Color7").opacity(0.5)], startPoint: UnitPoint.topLeading, endPoint: UnitPoint.bottomTrailing)
        let fill2 = LinearGradient(colors: [Color("Color10").opacity(0.5), Color("Color9").opacity(0.5)], startPoint: UnitPoint.topLeading, endPoint: UnitPoint.bottomTrailing)
        
        let paintStyles = [AxisPaintStyle(stroke: style, fill: fill),
                           AxisPaintStyle(stroke: style2, fill: fill2),
        ]
        
        var i = 0
        return originalData.map { key, value in
            let entity = AxisEntity(name: key, dataProvider: value, paintStyle: paintStyles[i])
            i += 1
            return entity
        }
    }
    

    
    @ViewBuilder
    var barView: some View{
        AxisView(plot: .bar(entities: self.entities, xAxisLabels: self.originalData.first!.value.map({$0.x})))
            .xAxisStart(at: 0)
            .barRadius(2)
            .barWidth(50)
            .spacing(10)
            .groupSpacing(2)
            .appearingAnimation(.spring(response: 0.3, dampingFraction: 0.2, blendDuration: 50), diff:  0.1)
            .onTap(callback: { name, index, value  in
                self.value = name + " " + (self.originalData[name]?[index].x ?? "") + " " + String(format: "%.2f", value)
            })
        .padding()
    }
    
    @ViewBuilder
    var lineView: some View{
        let c = Circle().foregroundColor(.green).frame(width: 12, height: 12, alignment: .center)
        AxisView(plot: .line(entities: self.entities, xAxisLabels: self.originalData.first!.value.map({$0.x}), type: .straight))
            .onTap(with: c, callback: { data in
                if let data = data.first{
                    self.value = data.key + " " + (self.originalData[data.key]?[data.value.0].x ?? "") + " " + String(format: "%.2f", data.value.1)
                }
            })
        .padding()
    }
    
    @ViewBuilder
    var radarView: some View{
        AxisView(plot: .radar(entities: self.entities, xAxisLabels: self.originalData.first!.value.map({$0.x})))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
