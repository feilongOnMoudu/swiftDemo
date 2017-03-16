//
//  SecondVC.swift
//  SwiftDemo
//
//  Created by 宋飞龙 on 17/3/10.
//  Copyright © 2017年 宋飞龙. All rights reserved.
//

import UIKit
import MJRefresh


class SecondVC: BaseTableVC {
    
    var titleName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.leftBack(on: true)
        self.popGestureBack(isEnabled: true)
    }
    
    //override  重写父类的方法
    override func leftItemClick() {
        self.navigationController!.popViewController(animated: true)
    }
    
    override func getPageList(flag: String) {
        HttpServiceUtil.list(pageNumber: self.pageNumber, pageSize: self.pageSize , success: { (res) in
            self.refreshTable(dataSource: ProjectConstant.getAnyObject_valueToArray(responseObject:res,key:"data"), flag: flag)
        }) { (err) in
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId:String = "SecondCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId) as? SecondCell
        if cell == nil {
            cell = SecondCell(style: UITableViewCellStyle.default, reuseIdentifier: cellId) as SecondCell
        }
        cell?.contentView.backgroundColor = UIColor.red
        let dic = ProjectConstant.getAnyObject_valueToDictionary(responseObject: self.tableDataSource!, index: indexPath.row)
        cell?.label.text = dic["siteName"] as? String
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dic:NSDictionary = self.tableDataSource![indexPath.row] as! NSDictionary;
        titleName = dic.object(forKey: "siteName") as? String
        self.performSegue(withIdentifier: "toto", sender: self)
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toto" {
            segue.destination.setValue(titleName, forKey: "title")
        }
    }
    
    
}
