//
//  BaseCollectionViewVC.swift
//  SwiftDemo
//
//  Created by 宋飞龙 on 17/3/27.
//  Copyright © 2017年 宋飞龙. All rights reserved.
//

import UIKit
import MJRefresh

class BaseCollectionViewVC: BaseVC,UICollectionViewDelegate,UICollectionViewDataSource {

    @IBOutlet public weak var collectionView: UICollectionView!
    
    public var collectionDataSource:Array<Any>?
    public var pageSize:Int!
    public var pageNumber:Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = .all
        self.pageSize = CUSTOM_PAGE_SIZE
        self.pageNumber = 1
        self.addHeader()
        self.addFooter()
        self.collectionView.mj_header.beginRefreshing()
        self.leftBack(on: true)
    }
    
    public func getPageList(flag:String) {
        self.refreshTable(dataSource: [], flag: flag)
    }
    
    public func refreshTable(dataSource:Array<Any>,flag:String) {
        if flag == GET_PAGE_FLAG_NEW {
            if dataSource.isEmpty {
                self.collectionView.mj_header.endRefreshing()
                self.collectionView.mj_footer.endRefreshing()
            } else {
                self.collectionDataSource = dataSource
                self.collectionView.reloadData()
                self.collectionView.mj_header.endRefreshing()
                self.collectionView.mj_footer.endRefreshing()
            }
        } else {
            if dataSource.isEmpty {
                self.collectionView.mj_header.endRefreshing()
                self.collectionView.mj_footer.endRefreshing()
            } else {
                self.collectionDataSource = self.collectionDataSource! + dataSource
                self.collectionView.reloadData()
                self.collectionView.mj_header.endRefreshing()
                self.collectionView.mj_footer.endRefreshing()
            }
        }
    }
    
    private func getNewPageList() {
        self.collectionDataSource?.removeAll()
        self.pageNumber = 1
        self.getPageList(flag: GET_PAGE_FLAG_NEW)
    }
    
    private func getNextPageList() {
        self.pageNumber = self.pageNumber + 1
        self.getPageList(flag: GET_PAGE_FLAG_NEXT)
    }
    
    public func addHeader() {
        self.collectionView.mj_header = MJRefreshNormalHeader(refreshingBlock:{
            self.getNewPageList()
        })
        self.collectionView.mj_header.isAutomaticallyChangeAlpha = true
    }
    
    public func addFooter() {
        self.collectionView.mj_footer = MJRefreshBackNormalFooter(refreshingBlock: {
            self.getNextPageList()
        })
        
        self.collectionView.mj_footer.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: DataSource & Delegate
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.collectionDataSource?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        return cell
    }
}
