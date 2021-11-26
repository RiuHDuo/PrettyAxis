//
//  PriewData.swift
//  PrettyAxis
//
//  Created by RiuHDuo on 2021/11/16.
//

import Foundation

extension Bundle{
    static var current: Bundle?{
        get{
           // return Bundle(identifier: "RiuHDuo.PrettyAxis")
            return Bundle.main
        }
    }
}

class PreviewData{
    class func load<T>(_ t: T.Type, fileName: String) -> T? where T: Decodable{
        guard let path = Bundle.current?.path(forResource: fileName, ofType: "json") else{
            return nil
        }
        
        do{
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            let decoder = JSONDecoder()
            let ret = try decoder.decode(t, from: data)
            return ret
        }catch let e {
            print(e)
            return nil
        }
    }

}

