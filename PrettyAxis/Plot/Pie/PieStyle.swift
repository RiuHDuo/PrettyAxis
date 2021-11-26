//
//  File.swift
//  PrettyAxis
//
//  Created by RiuHDuo on 2021/11/24.
//

import SwiftUI


struct PieStyle{
    
    var spacing: CGFloat = 0
     
    var labelWidth: CGFloat = 0
    
    public var showReferenceLine = false
    
    public var labelStyle: LabelStyle  = AxisLabelStyle()
    
    public var referenceLineStyle = ReferenceLineStyle.default
    
    public var fromZero: Bool = true
    
    func contentView(plot: Plot) -> some View{
       return  EmptyView()
    }
}
