//
//  PicUpload.swift
//  FuGuoSwift
//
//  Created by 赵彬 on 2020/6/1.
//  Copyright © 2020 赵彬. All rights reserved.
//

import UIKit

class PicUpload: NSObject {

   //底层网络请求
    func postRequestWithURL(url:URL, postParems:NSMutableDictionary,picFilePath:NSMutableArray,picFileName:NSMutableArray) -> NSMutableURLRequest {
        
        let hyphens:String = "--"
        let boundary:String = "@@@@"
        let end:String = "\r\n"
        
        let myRequestData1:NSMutableData = NSMutableData.init()
        
        let keys:NSArray = postParems.allKeys as NSArray
        
        
        for key in keys {
            
            let body:NSMutableString = NSMutableString.init()
            body.append(hyphens)
            body.append(boundary)
            body.append(end)
            body.append("Content-Disposition: form-data; name=\"REQINFO\"")
            body.append(end)
            body.append(end)
            body.append(postParems.object(forKey: key) as! String)
            body.append(end)
            let bodyStr:String = body as String
        
            myRequestData1.append( bodyStr.data(using: .utf8)!)
        }
        
        myRequestData1.append(hyphens.data(using: .utf8)!)
        myRequestData1.append(boundary.data(using: .utf8)!)
        myRequestData1.append(hyphens.data(using: .utf8)!)
        myRequestData1.append(end.data(using: .utf8)!)
        
        let request = NSMutableURLRequest.init(url: url, cachePolicy: NSURLRequest.CachePolicy.reloadIgnoringCacheData, timeoutInterval: 20)
        let content:NSMutableString = "multipart/form-data; boundary="
        content.append(boundary)
        request.setValue(content as String, forHTTPHeaderField: "Content-Type")
        
        request.setValue(String(format:"%ld", myRequestData1.length), forHTTPHeaderField: "Content-Length")
        request.httpBody = myRequestData1 as Data
        request.httpMethod = "POST"
        return request
    }
    
}
