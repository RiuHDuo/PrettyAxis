//
//  YAxisable.swift
//  PrettyAxis
//
//  Created by RiuHDuo on 2022/4/24.
//

import SwiftUI

/// A protocol for Y-axis value
///
public protocol YAxisDataProvider{
    associatedtype Y: Hashable
    
    /// Y-axis Value getter
    ///
    var y:Y {get}
}

