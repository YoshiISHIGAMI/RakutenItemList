//
//  RakutenFetcher.swift
//  TwitterApp
//
//  Created by 横山卓也 on 2015/09/12.
//  Copyright (c) 2015年 yokoyama. All rights reserved.
//

import Foundation
import Alamofire

//https://app.rakuten.co.jp/services/api/IchibaItem/Ranking/20120927?format=json&applicationId=1010412757428744227

class RakutenFetcher{
    
    let baseURL = "https://app.rakuten.co.jp/services/api/IchibaItem/Ranking/20120927"
    var defaultParameter:[String:String] = [
        "format":"json",
        "applicationId":"1010412757428744227"
    ]
    
    
    func download(callback : ([RakutenItem]) -> Void){
        
        Alamofire.request(.GET, baseURL, parameters: defaultParameter)
        
            .responseJSON { _, _, JSON, _ in
                
                if let json: AnyObject = JSON,
                    let items = json["Items"] as? [AnyObject]{
                    
                        var returnArray:[RakutenItem] = []
                        
                        for(var i=0; i<items.count; i++){
                            
                            if let item = items[i]["Item"] as? [String:AnyObject]{
                                
                                let ritem = RakutenItem()
                                
                                if let name = item["itemName"] as? String{
                                    ritem.itemName = name
                                }
                                
                                if let price = item["itemPrice"] as? String{
                                    ritem.itemPrice = price
                                }
                                
                                if let caption = item["itemCaption"] as? String{
                                    ritem.itemCaption = caption
                                }
                                
                                
                                if let urls = item["mediumImageUrls"] as? [AnyObject],
                                    let url = urls[0]["imageUrl"] as? String{
                                    ritem.imageUrl = url
                                }
                                
                                returnArray.append(ritem)
                                
                            }
                        }
                        
                        callback(returnArray)
                        
                }
                
        }
        
    }
    
    
    
}