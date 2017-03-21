//
//  SecondVC.swift
//  SwiftDemo
//
//  Created by 宋飞龙 on 17/3/10.
//  Copyright © 2017年 宋飞龙. All rights reserved.
//

import UIKit
import MJRefresh
import RxCocoa
import RxSwift
import Moya
import RxDataSources

let dataSource  = RxTableViewSectionedReloadDataSource<SectionModel<String, SecondModel>>()

class SecondVC: BaseTableVC {
    
    var titleName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.leftBack(on: true)
        self.popGestureBack(isEnabled: true)
    }
    
    let disposeBag = DisposeBag()
    let viewModel = SecondViewMode()
    var  model:[SecondModel]?
    
    //override  重写父类的方法
    override func leftItemClick() {
        self.navigationController!.popViewController(animated: true)
    }
    
    override func getPageList(flag: String) {
//        viewModel
//            .getList(pageNumber: self.pageNumber, pageSize: self.pageSize)
//            .subscribe({ [unowned self] event in
//                switch event {
//                    case .next(let models):
//                        self.model = models
//                        self.tableView.reloadData()
//                    case .error(let error):
//                        print(error)
//                    case .completed:
//                        self.tableView.mj_header.endRefreshing()
//                        self.tableView.mj_footer.endRefreshing()
//                }
//            })
//            .addDisposableTo(disposeBag)
        
        viewModel.getList(pageNumber: self.pageNumber, pageSize: self.pageSize)
            .subscribe(onNext: { (mo:[SecondModel]) in
                self.model = mo
                self.tableView.reloadData()
            }, onError: { (error) in
                print(error)
            }, onCompleted: { 
                self.tableView.mj_header.endRefreshing()
                self.tableView.mj_footer.endRefreshing()
            })
            .addDisposableTo(disposeBag)
        
//        HttpServiceUtil.list(pageNumber: self.pageNumber, pageSize: self.pageSize , success: { (res) in
//            self.refreshTable(dataSource: ProjectConstant.getAnyObject_valueToArray(responseObject:res,key:"data"), flag: flag)
//        }) { (err) in
//            
//        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let models = model else {
            return 0
        }
        return models.count
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
        //let dic = ProjectConstant.getAnyObject_valueToDictionary(responseObject: self.tableDataSource!, index: indexPath.row)
        let data = self.model?[indexPath.row]
        
        cell?.label.text = data?.name
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
