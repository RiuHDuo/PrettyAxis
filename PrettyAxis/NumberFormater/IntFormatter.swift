//
//  IntFormater.swift
//  PrettyAxis
//
//  Created by RiuHDuo on 2021/11/15.
//

import Foundation


public class IntFormatter: NumberFormatter{
    public func format(value: Double) -> String {
        return String(format: "%.0f", value)
    }
}
