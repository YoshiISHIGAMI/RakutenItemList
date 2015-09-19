//
//  TimeLineTableViewController.swift
//  TwitterApp
//
//  Created by 横山卓也 on 2015/09/12.
//  Copyright (c) 2015年 yokoyama. All rights reserved.
//

import UIKit

class TimeLineTableViewController: UITableViewController {
    
    var dataArray:[RakutenItem] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        RakutenFetcher().download { (ritems) -> Void in
            
            self.dataArray = ritems
            self.tableView.reloadData()
        }
        
    }
    
    //テーブルの件数を登録
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    //テーブルの内容を代入
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        //セルを内部的にリサイクルしているのでこちらが必須になります。
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell
        
        let item = dataArray[indexPath.row]
        
        cell.textLabel?.text = item.itemName
        cell.imageView?.sd_setImageWithURL(NSURL(string: item.imageUrl), placeholderImage: UIImage(named: "droplr_dashboard_overview"))
        
        return cell
    }
    
}
