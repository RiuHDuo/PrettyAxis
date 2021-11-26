//
//  TestChartData.swift
//  PrettyAxis
//
//  Created by RiuHDuo on 2021/11/16.
//

import Foundation


struct TestChartData: Decodable{
    let year: String
    let sales: Double
}



struct TestChartData2: Decodable{
    let month: String
    let value: Double
    let name: String
}


struct TestChartData3: Decodable{
    let item: String
    let score: Double
    let user: String
}



struct TestChartData4: Decodable{
    let gender: String
    let height: Double
    let weight: Double
}
