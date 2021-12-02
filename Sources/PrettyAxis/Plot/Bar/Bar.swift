//
//  Bar.swift
//  PrettyAxis
//
//  Created by RiuHDuo on 2021/11/16.
//

import SwiftUI

struct Bar: Shape {
    var cornerRadius: CGFloat
    
    var animatableData: CGFloat  = 1
    
    func path(in rect: CGRect) -> Path {
        return Path(roundedRect: CGRect(x: 0, y: rect.height * (1 - animatableData), width: rect.width, height:  rect.height * animatableData), cornerRadius: cornerRadius)
    }
    
}
