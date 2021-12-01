//
//  LegendView.swift
//  PrettyAxis
//
//  Created by RiuHDuo on 2021/11/30.
//

import SwiftUI

struct LegendView: View {
    var list = [(String, AnyShapeStyle)]()
    var style: LegendStyle
    
    var body: some View {
        LazyVGrid(columns:[GridItem(.flexible()),GridItem(.flexible()),GridItem(.flexible())], spacing: 0){
            ForEach(list, id: \.self.0) { item in
                HStack{
                    Circle()
                        .fill(item.1)
                        .frame(width: 8, height: 8)
                    Text(item.0)
                        .font(.system(size: 10))
                        .foregroundColor(Color.white)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .padding(.bottom, 16)
    }
}

