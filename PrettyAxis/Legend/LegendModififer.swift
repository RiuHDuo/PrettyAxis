//
//  LegendModififer.swift
//  PrettyAxis
//
//  Created by RiuHDuo on 2022/4/25.
//

import SwiftUI


struct LegendModifier: ViewModifier{
    
    var isHidden: Bool
    
    func body(content: Content) -> some View{
        VStack{
            if isHidden == false{
                
            }
            content
        }
    }
}
