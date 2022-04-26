//
//  AxisView.swift
//  PrettyAxis
//
//  Created by RiuHDuo on 2022/4/24.
//

import SwiftUI

public struct AxisView<Plot>: View where Plot: AxisPlot{
    var plot: Plot
    
    public init(plot: Plot){
        self.plot = plot
    }
    
    public var body: some View {
        self.plot
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
    }
}


