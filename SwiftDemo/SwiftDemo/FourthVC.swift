//
//  FourthVC.swift
//  SwiftDemo
//
//  Created by 宋飞龙 on 17/3/14.
//  Copyright © 2017年 宋飞龙. All rights reserved.
//

import UIKit

class FourthVC: BaseTableVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.leftBack(on: true)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func getPageList(flag: String) {
        HttpServiceUtil.list1(pageNumber: self.pageNumber, pageSize: self.pageSize , success: { (res) in
            let dic = res as! NSDictionary
            //let data:NSMutableArray = ProjectConstant.arrayToMutableArray(array: dic.object(forKey: "data")!)
            self.refreshTable(dataSource: dic.object(forKey: "data") as! Array, flag: flag)
        }) { (err) in
            
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId:String = "FourthCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId) as? FourthCell
        if cell == nil {
            cell = FourthCell(style: UITableViewCellStyle.default, reuseIdentifier: cellId) as FourthCell
        }
        cell?.contentView.backgroundColor = UIColor.red
        let dic:NSDictionary = self.tableDataSource![indexPath.row] as! NSDictionary;
        cell?.label.text = dic.object(forKey: "siteName") as! String?
        return cell!
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
