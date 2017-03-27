//
//  SecondViewModel.swift
//  SwiftDemo
//
//  Created by 宋飞龙 on 17/3/20.
//  Copyright © 2017年 宋飞龙. All rights reserved.
//

import UIKit
import RxSwift
import Moya

class SecondViewMode {
    let provider = RxMoyaProvider<API>()
    func getList(pageNumber:Int,pageSize:Int) -> Observable<[SecondModel]> {
        return provider.request(.List(pageNumber: pageNumber, pageSize: pageSize))
                       .mapArray(SecondModel.self)
    }
}
