//
//  Axisable.swift
//  PrettyAxis
//
//  Created by RiuHDuo on 2021/11/29.
//

import Foundation


public protocol Axisable{
    associatedtype X: Hashable
    associatedtype Y: Hashable
    associatedtype Z: Hashable
    associatedtype G: Hashable
    
    
    var x: X { get }
    var y: Y { get }
    var z: Z? { get }
    var group: G? {get}
}

