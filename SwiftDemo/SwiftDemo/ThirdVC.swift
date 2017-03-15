//
//  ThirdVC.swift
//  SwiftDemo
//
//  Created by 宋飞龙 on 17/3/14.
//  Copyright © 2017年 宋飞龙. All rights reserved.
//

import UIKit

class ThirdVC: BaseVC {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.leftBack(on: true)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func click(_ sender: UIButton) {
        self.performSegue(withIdentifier: "toto1", sender: self)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
