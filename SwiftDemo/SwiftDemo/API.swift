//
//  API.swift
//  SwiftDemo
//
//  Created by 宋飞龙 on 17/3/20.
//  Copyright © 2017年 宋飞龙. All rights reserved.
//

import Foundation
import RxSwift
import Moya
import Alamofire


enum API {
    case List(pageNumber:Int,pageSize:Int)
}

extension API : TargetType {
    public var parameterEncoding: ParameterEncoding {
        switch self {
        case .List(_,_):
            return URLEncoding.default
        }
    }

    var baseURL: URL {
        return URL(string:"http://api.ylzun.com/f/api/")!
    }
    
    var path: String {
        switch self {
        case .List(_, _):
            return "siteinfo/siteInfoPageList"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .List(_, _):
            return .post
        }
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .List(let pageNumber, let pageSize):
            return ["client":"eyJ0eXBlIjoiaU9TIiwidmVyc2lvbiI6IjEuMi4wIiwiaW9zIjp7InN5c3RlbVZlcnNpb24iOiIxMC4yIn19","pageNumber":String(pageNumber),"pageSize":String(pageSize),"areaId":"11","siteType":"6"]
        }
    }
    
    var sampleData: Data {
        switch self {
        case .List(_, _):
            return self.sampleData
            
            //return "list".data(using: String.Encoding.utf8)!
        }
    }
    
    var task: Task {
        return .request
    }
}

