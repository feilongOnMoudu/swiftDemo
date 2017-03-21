//
//  BaseVC.swift
//  SwiftDemo
//
//  Created by 宋飞龙 on 17/3/10.
//  Copyright © 2017年 宋飞龙. All rights reserved.
//

import UIKit

let IS_IOS7 = (UIDevice.current.systemVersion as NSString).doubleValue >= 7.0

class BaseVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func popGestureBack(isEnabled:Bool) {
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = isEnabled
    }
    
    private var rightButtn:UIButton = UIButton.init(type: UIButtonType.custom)
    
    // MARK: 添加导航条左边按钮
    private func creatLeftItemWithImage(imageName:String) {
        let button:UIButton = UIButton(type: UIButtonType.custom)
        button.frame = CGRect(origin: CGPoint(x: 10, y: 0), size: CGSize(width: 30, height: 30))
        button.addTarget(self, action: #selector(leftItemClick), for: UIControlEvents.touchUpInside)
        button.setImage(UIImage(named: imageName), for: UIControlState.normal)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: button)
        let leftBarButton:UIBarButtonItem = UIBarButtonItem.init(customView: button)
        if IS_IOS7 {
            let negativeSpacer:UIBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.fixedSpace, target: nil, action: nil)
            negativeSpacer.width =  -10
            self.navigationItem.leftBarButtonItems  = [negativeSpacer,leftBarButton]
        } else {
            self.navigationItem.leftBarButtonItem = leftBarButton
        }
    }
    
    public func leftItemClick() {
       self.navigationController!.popViewController(animated: true)
    }
    
    public func leftBack(on:Bool) {
        if on {
            self.creatLeftItemWithImage(imageName: "icon_arrow_left")
        }
    }
    
    // MARK: 添加导航条右边按钮
    private func createRighetItemWithImage(imageName:String) {
        let button:UIButton = UIButton.init(type: UIButtonType.custom)
        button.frame = CGRect(origin: CGPoint(x:-10,y:0), size: CGSize(width: 30, height: 30))
        button.addTarget(self, action: #selector(rightItemClick), for: UIControlEvents.touchUpInside)
        button.setImage(UIImage(named: imageName), for: UIControlState.normal)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: button)
        rightButtn = button;
    }
    
    // MARK: 添加导航条右边按钮
    private func createRighetItemWithTitle(title:String) {
        let button:UIButton = UIButton.init(type: UIButtonType.custom)
        button.frame = CGRect(origin: CGPoint(x:0,y:0), size: CGSize(width: 70, height: 30))
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignment.right
        button.titleLabel!.textAlignment = NSTextAlignment.right
        button.setTitle(title, for: UIControlState.normal)
        button.setTitleColor(UIColor.white, for: UIControlState.normal)
        rightButtn = button;
        button.addTarget(self, action: #selector(rightItemClick), for: UIControlEvents.touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: button)
    }
    
    public func rightItemClick() {
        
    }
    
    public func rightClick(imageOrText:Bool,name:String) {
        if imageOrText {
            self.createRighetItemWithImage(imageName: name)
        } else {
            self.createRighetItemWithTitle(title: name)
        }
    }
}
