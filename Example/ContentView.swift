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
    @State var value = "0.0"
    var body: some View {
        VStack {
            Text(self.value)
                .font(.largeTitle)
                .foregroundColor(.black)
                .frame(maxWidth:.infinity, alignment: .leading)
                .padding()
            AxisView(plot: .line(provider: value1, type: .smooth(curviness: 0.4)))
                .fromZeroValue()
                .stroke(LinearGradient(colors: [Color("Color1"), Color("Color2"), Color("Color3")], startPoint: UnitPoint.leading, endPoint: UnitPoint.trailing))
                .spacing(200)
                .fill(.blue.opacity(0.3))
                .appearAnimation(.linear(duration: 1))
                .onTap(with: Circle().frame(width: 10, height: 10).foregroundColor(.red), callback: { x, value in
                    self.value = x + " " + String(format: "%0.2f",  value)
                })
            .padding()
        }
        .onAppear(){
            self.value =   value1.first!.x + " " + String(format: "%0.2f",  value1.first?.y ?? 0)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
