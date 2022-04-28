//
//  ContentView.swift
//  Example
//
//  Created by RiuHDuo on 2022/4/25.
//

import SwiftUI
import PrettyAxis

struct ContentView: View {
    let value1 = PreviewData.load([TestChartData].self, fileName: "ChartData") ?? [TestChartData]()
    let value2 = PreviewData.load([TestChartData].self, fileName: "ChartData2") ?? [TestChartData]()
    @State var value = "0.0"
    var body: some View {
        VStack {
            Text(self.value)
                .font(.largeTitle)
                .foregroundColor(.black)
                .frame(maxWidth:.infinity, alignment: .leading)
                .padding()
            AxisView(plot: .line(entities: self.entities, xAxisLabels: value1.map({$0.x})))
                .fromZeroValue()
                .legendStyle(LegendStyle(legendShape: Circle()))
                .appearAnimation(.linear(duration: 5))
                .onTap(with: Path.star, callback: { values in
                    var str = ""
                    values.forEach { v in
                        str += v.key + " " + String(format: "%0.2f",  v.value) + " "
                    }
                    self.value = str
                })
            .padding()
        }
        .onAppear(){
            self.value =   value1.first!.x + " " + String(format: "%0.2f",  value1.first?.y ?? 0)
        }
    }
    
    var entities: [AxisEntity<TestChartData>]{
        let style = LinearGradient(colors: [Color("Color1"), Color("Color2"), Color("Color3")], startPoint: UnitPoint.leading, endPoint: UnitPoint.trailing)
        let style2 = LinearGradient(colors: [Color("Color4"), Color("Color5"), Color("Color6")], startPoint: UnitPoint.leading, endPoint: UnitPoint.trailing)
        
        let fill = LinearGradient(colors: [Color("Color1").opacity(0.5), Color("Color2").opacity(0.5), Color("Color3").opacity(0.5)], startPoint: UnitPoint.leading, endPoint: UnitPoint.trailing)
        let fill2 = LinearGradient(colors: [Color("Color4").opacity(0.5), Color("Color5").opacity(0.5), Color("Color6").opacity(0.5)], startPoint: UnitPoint.leading, endPoint: UnitPoint.trailing)
        return [AxisEntity(name: "Test1", dataProvider: value1, paintStyle: .init(stroke: style, fill: fill)), AxisEntity(name: "Test2", dataProvider: value2, paintStyle: .init(stroke: style2, fill: fill2))]
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
