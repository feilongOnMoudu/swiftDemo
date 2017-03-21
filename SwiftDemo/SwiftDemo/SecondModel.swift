//
//  SecondModel.swift
//  SwiftDemo
//
//  Created by 宋飞龙 on 17/3/20.
//  Copyright © 2017年 宋飞龙. All rights reserved.
//

import Foundation
import ObjectMapper

class SecondModel: Mappable {
    var name:String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        name <- map["siteName"]
    }
}

