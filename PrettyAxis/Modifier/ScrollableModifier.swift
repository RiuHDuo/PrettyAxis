//
//  ScrollableModifier.swift
//  PrettyAxis
//
//  Created by RiuHDuo on 2022/4/26.
//

import SwiftUI



struct ScrollableModifier: ViewModifier{
    func body(content: Content) -> some View {
        ScrollView(.horizontal, showsIndicators: false){
            content.padding(4)
        }
    }
}
