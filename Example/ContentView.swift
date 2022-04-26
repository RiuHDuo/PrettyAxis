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
    var body: some View {
        AxisView(plot: .line(provider: value1, type: .smooth(curviness: 0.4)))
            .stroke(LinearGradient(colors: [Color("Color1"), Color("Color2"), Color("Color3")], startPoint: UnitPoint.leading, endPoint: UnitPoint.trailing))
            .fill(.blue.opacity(0.3))
            .appearAnimation(.linear(duration: 10))
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
