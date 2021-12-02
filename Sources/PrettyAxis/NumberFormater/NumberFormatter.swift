//
//  NUmberFormater.swift
//  PrettyAxis
//
//  Created by RiuHDuo on 2021/11/15.
//

import Foundation


public protocol NumberFormatter{
    func format(value: Double) -> String
}


public extension NumberFormatter where Self == IntFormatter{
    static var `int`: Self { .init() }
}
