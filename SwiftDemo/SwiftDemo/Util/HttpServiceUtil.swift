//
//  HttpServiceUtil.swift
//  SwiftDemo
//
//  Created by 宋飞龙 on 17/3/13.
//  Copyright © 2017年 宋飞龙. All rights reserved.
//

import UIKit


class HttpServiceUtil: NSObject {
    
    public class func list(pageNumber:Int,pageSize:Int,success:@escaping ((Any) ->()),failuer:@escaping ((Any) ->())) {
        let dic = ["client":"eyJ0eXBlIjoiaU9TIiwidmVyc2lvbiI6IjEuMi4wIiwiaW9zIjp7InN5c3RlbVZlcnNpb24iOiIxMC4yIn19","pageNumber":String(pageNumber),"pageSize":String(pageSize),"areaId":"11","siteType":"6"]
        AFNetwokingUtil.postJson("http://api.ylzun.com/f/api/siteinfo/siteInfoPageList", withParameters: dic, success: { (red) in
            success(red!)
        }) { (err) in
            failuer(err!)
        }
    }
    
    public class func list1(pageNumber:Int,pageSize:Int,success:@escaping ((Any)->()),failuer:@escaping ((Any) ->())) {
        let dic = ["client":"eyJ0eXBlIjoiaU9TIiwidmVyc2lvbiI6IjEuMi4wIiwiaW9zIjp7InN5c3RlbVZlcnNpb24iOiIxMC4yIn19","pageNumber":String(pageNumber),"pageSize":String(pageSize),"areaId":"11","siteType":"1"]
        AFNetwokingUtil.postJson("http://api.ylzun.com/f/api/siteinfo/siteInfoPageList", withParameters: dic, success: { (red) in
            success(red!)
        }) { (err) in
            failuer(err!)
        }
    }
}
