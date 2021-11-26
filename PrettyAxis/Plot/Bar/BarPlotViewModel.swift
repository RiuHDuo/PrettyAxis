//
//  BarPlotViewModel.swift
//  PrettyAxis
//
//  Created by RiuHDuo on 2021/11/16.
//

import SwiftUI

class BarPlotViewModel: ObservableObject{
    @Published var renderData = [String : [AxisData]]()
    @Published var range = (min: 0.0, max: 0.0)
    @Published var barWidth: CGFloat = 15
    @Published var color = [String :Color]()
    @Published var spacing: CGFloat = 10
    @Published var barCornerSize: CGFloat = 2.0
    @Published var animated = false
}
