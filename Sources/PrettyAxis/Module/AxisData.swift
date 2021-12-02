//
//  AxisData.swift
//  PrettyAxis
//
//  Created by RiuHDuo on 2021/11/16.
//

import Foundation
import SwiftUI


struct AxisData<X, Y, Z>: Hashable where X: Hashable, Y: Hashable, Z: Hashable{
    let xValue: X
    let yValue: Y
    let zValue: Z?
    
    
    init(xValue: X, yValue: Y, zValue: Z? = nil){
        self.xValue = xValue
        self.yValue = yValue
        self.zValue = zValue
    }
}
