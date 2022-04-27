//
//  AxisEntity.swift
//  PrettyAxis
//
//  Created by RiuHDuo on 2022/4/27.
//

import Foundation

/// Data Entity of Chart
///
public struct AxisEntity<S>{
    /// Data group name.
    ///
    public var name: String
    
    /// Data provider.
    ///
    public var dataProvider: [S]
    
    /// Style of paint
    /// 
    public var paintStyle: AxisPaintStyle  = .default
    
    
    public init(name: String, dataProvider: [S], paintStyle: AxisPaintStyle = .default){
        self.name = name
        self.dataProvider = dataProvider
        self.paintStyle = paintStyle
    }
}
