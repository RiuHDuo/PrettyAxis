//
//  MarkType.swift
//  PrettyAxis
//
//  Created by RiuHDuo on 2021/11/22.
//

import SwiftUI


public enum MarkType{
    case circle(radius: CGFloat)
    case rectangle(size: CGSize, cornerRadius: CGFloat)
    case custom(path: Path)
}



extension MarkType{
    var path:Path{
        switch self{
        case .circle(let r):
            return Path(ellipseIn: CGRect(x:  -r / 2, y: -r / 2, width: r, height: r))
        case .rectangle(let size, let cornerRadius):
            return Path(roundedRect: CGRect(x: -size.width / 2, y: -size.height / 2, width: size.width, height: size.height), cornerRadius: cornerRadius)
        case .custom(let path):
            return path
        }
    }
}
