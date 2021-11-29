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

extension TestChartData: Axisable{
    var x: String{
        return year
    }
    
    var y: Double{
        return sales
    }
    
    var z: AnyHashable? { return nil}
    var groupd: AnyHashable? { return nil}
}


struct TestChartData2: Decodable{
    let month: String
    let value: Double
    let name: String
}

extension TestChartData2: Axisable{
    var x: String{
        return month
    }
    
    var y: Double{
        return value
    }
    
    var z: AnyHashable? { return nil}
    var groupd: AnyHashable? { return name}
}



struct TestChartData3: Decodable{
    let item: String
    let score: Double
    let user: String
}

extension TestChartData3: Axisable{
    var x: String{
        return item
    }
    
    var y: Double{
        return score
    }
    
    var z: AnyHashable? { return nil}
    var groupd: AnyHashable? { return user}
}




struct TestChartData4: Decodable{
    let gender: String
    let height: Double
    let weight: Double
}


extension TestChartData4: Axisable{
    var x: Double{
        return height
    }
    
    var y: Double{
        return weight
    }
    
    var z: AnyHashable? { return nil}
    var groupd: String? { return gender}
}
