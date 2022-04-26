//
//  Groupable.swift
//  PrettyAxis
//
//  Created by RiuHDuo on 2022/4/24.
//

import Foundation

/// A protocol for axis data grouping
/// 
public protocol Groupable{
    
    associatedtype G: Hashable
    
    /// Group Value getter
    ///
    var group: G {get}
    
    /// Sorted function for ordering group
    ///
    /// A function that returns true if its first argument should be ordered before its second argument; otherwise, false. I
    ///
    /// - Parameters
    ///     - group1: first argument
    ///     - group2: second argument
    func order(group1: G, group2: G) -> Bool
}

extension Groupable{
    func order(group1: G, group2: G) -> Bool{
        return true
    }
}
