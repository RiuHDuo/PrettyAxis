//
//  TestChartData.swift
//  PrettyAxis
//
//  Created by RiuHDuo on 2021/11/16.
//

import Foundation
import PrettyAxis


struct TestChartData: Decodable{
    let year: String
    let sales: Double
}

extension TestChartData: LineDataProvider{
    var x: String{
        return year
    }
    
    var y: Double{
        return sales
    }
    
    var z: AnyHashable? { return nil}
    var group: AnyHashable? { return nil}
}
