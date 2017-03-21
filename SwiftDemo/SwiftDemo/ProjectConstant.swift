//
//  ProjectConstant.swift
//  SwiftDemo
//
//  Created by 宋飞龙 on 17/3/13.
//  Copyright © 2017年 宋飞龙. All rights reserved.
//

import UIKit

public let GET_PAGE_FLAG_NEW:String = "new"
public let GET_PAGE_FLAG_NEXT:String = "next"
public let CUSTOM_PAGE_SIZE:Int = 3

class ProjectConstant: NSObject {
    public class func arrayToMutableArray(array:Any) ->(NSMutableArray) {
        return (array as! NSArray).mutableCopy() as! NSMutableArray
    }
    
    public class func getAnyObject_valueToDictionary(responseObject:Array<Any>,index:Int)->(Dictionary<AnyHashable, AnyObject>) {
        return responseObject[index] as! Dictionary<AnyHashable, AnyObject>
    }
    
    public class func getAnyObject_valueToArray(responseObject:Any,key:String)->(Array<Any>) {
        return (responseObject as! Dictionary<AnyHashable,AnyObject>)[key] as! Array
    }
    
    public class func getVC(vcName:String) ->(UIViewController) {
        return UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: vcName)
    }
}
