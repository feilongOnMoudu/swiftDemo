//
//  BaseTableVC.swift
//  SwiftDemo
//
//  Created by 宋飞龙 on 17/3/10.
//  Copyright © 2017年 宋飞龙. All rights reserved.
//

import UIKit
import MJRefresh

class BaseTableVC: BaseVC,UITableViewDelegate,UITableViewDataSource {
    // MARK: 公共表格View，继承是必须连接到这里
    @IBOutlet public weak var tableView: UITableView!
    
    public var tableDataSource:Array<Any>?
    public var pageSize:Int!
    public var pageNumber:Int!
    let header = MJRefreshNormalHeader()
    let footer = MJRefreshBackNormalFooter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = .all
        self.pageSize = CUSTOM_PAGE_SIZE
        self.pageNumber = 1
        self.addHeader()
        self.addFooter()
        self.tableView.mj_header.beginRefreshing()
        self.tableView.tableFooterView = UIView.init()
        self.leftBack(on: true)
    }
    
    public func getPageList(flag:String) {
        self.refreshTable(dataSource: [], flag: flag)
    }
    
    public func refreshTable(dataSource:Array<Any>,flag:String) {
        if flag == GET_PAGE_FLAG_NEW {
            if dataSource.isEmpty {
                self.tableView.mj_header.endRefreshing()
                self.tableView.mj_footer.endRefreshing()
            } else {
                self.tableDataSource = dataSource
                self.tableView.reloadData()
                self.tableView.mj_header.endRefreshing()
                self.tableView.mj_footer.endRefreshing()
            }
        } else {
            if dataSource.isEmpty {
                self.tableView.mj_header.endRefreshing()
                self.tableView.mj_footer.endRefreshing()
            } else {
                self.tableDataSource = self.tableDataSource!+dataSource
                self.tableView.reloadData()
                self.tableView.mj_header.endRefreshing()
                self.tableView.mj_footer.endRefreshing()
            }
        }
    }
    
    public func addHeader() {
        self.tableView.mj_header = MJRefreshNormalHeader(refreshingBlock:{
            self.getNewPageList()
        })
        self.tableView.mj_header.isAutomaticallyChangeAlpha = true
    }
    
    public func addFooter() {
        self.tableView.mj_footer = MJRefreshBackNormalFooter(refreshingBlock: {
            self.getNextPageList()
        })
    }
    
    private func getNewPageList() {
        self.tableDataSource?.removeAll()
        self.pageNumber = 1
        self.getPageList(flag: GET_PAGE_FLAG_NEW)
    }
    
    private func getNextPageList() {
        self.pageNumber = self.pageNumber! + 1
        self.getPageList(flag: GET_PAGE_FLAG_NEXT)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return self.tableDataSource != nil ?self.tableDataSource!.count:0
        return self.tableDataSource?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier:"cell")
        return cell;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

