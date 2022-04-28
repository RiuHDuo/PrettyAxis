//
//  LegendModififer.swift
//  PrettyAxis
//
//  Created by RiuHDuo on 2022/4/25.
//

import SwiftUI


struct LegendModifier: ViewModifier{
    var data: [(String, AxisPaintStyle)]
    var style: LegendStyle
    var isHidden: Bool

    
    func body(content: Content) -> some View{
        Group{
            if isHidden {
                content
            }
            switch self.style.position {
            case .leading :
                HStack{
                    VStack{
                        legendView
                    }
                    content
                }
            case .trailing:
                HStack(spacing: 15){
                    content
                    VStack{
                        legendView
                    }
                }
            case .top:
                VStack{
                    HStack(spacing: 15){
                        legendView
                    }
                    content
                }
            case .bottom:
                VStack{
                    content
                    HStack{
                        legendView
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    var legendView: some View{
        ForEach(self.data.indices, id: \.self){ index in
            let data = self.data[index]
            self.style.legendShape.fill(data.1.stroke).frame(width: self.style.legendShapeSize.width, height: self.style.legendShapeSize.height)
            Text(data.0).font(self.style.labelFont).foregroundColor(self.style.labelColor)
        }
    }
}
