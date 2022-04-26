//
//  Axisable.swift
//  PrettyAxis
//
//  Created by RiuHDuo on 2022/4/24.
//

import Foundation


/// A protocol for X-axis value
///
public protocol XAxisDataProvider{
    associatedtype X: Hashable
    
    /// X-axis Value getter
    ///
    var x:X {get}
}
