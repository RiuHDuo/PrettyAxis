//
//  ValueFormatter.swift
//  PrettyAxis
//
//  Created by RiuHDuo on 2022/4/26.
//

import Foundation


public protocol ValueFormatter{
    func format(value: Double) -> String
}

public class IntFormatter: ValueFormatter{
    public func format(value: Double) -> String {
        return String(format: "%.0f", value)
    }
}

public extension ValueFormatter where Self == IntFormatter{
    static var `int`: Self { .init() }
}
