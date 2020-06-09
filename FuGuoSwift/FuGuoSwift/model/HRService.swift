//
//  HRService.swift
//  FuGuoSwift
//
//  Created by 赵彬 on 2020/6/1.
//  Copyright © 2020 赵彬. All rights reserved.
//

import UIKit

class HRService: NSObject {
    
    
    func requestEmployeesModel(itface:employeesModel,appendingPathUrlStr:String,success:@escaping (ResponseInfo) -> Void,failure:@escaping (NSError) -> Void) -> Void {
        

        self.postRequestParems(reqParame: itface.employeesModel(), appendingPathUrlStr: appendingPathUrlStr, success: { (dict) in
             let res:ResponseInfo = ResponseInfo.init(json: dict as! [String : Any])!
            success(res)
        }) { (error) in
             failure(error)
        }
    }
   
 
     func requestModel(itface:NSDictionary,appendingPathUrlStr:String,success:@escaping (ResponseInfo) -> Void,failure:@escaping (NSError) -> Void) -> Void {
          

          self.postRequestParems(reqParame: itface, appendingPathUrlStr: appendingPathUrlStr, success: { (dict) in
               let res:ResponseInfo = ResponseInfo.init(json: dict as! [String : Any])!
              success(res)
          }) { (error) in
               failure(error)
          }
      }
    
    
    
    
    
    
    
    func postRequestParems(reqParame:NSDictionary,appendingPathUrlStr:String,success:@escaping (NSDictionary) -> Void,failure:@escaping (NSError) -> Void) -> Void {
        
        let url = URL.init(string: baseURL)//服务地址
        let queryStr = self.JSONString(str: reqParame as NSDictionary)
        let quest:NSURLRequest = PicUpload.init().postRequestWithURL(url: url!.appendingPathComponent(appendingPathUrlStr), postParems: ["REQINFO":queryStr], picFilePath: [], picFileName: [])
               
            let task = URLSession.shared.dataTask(with: quest as URLRequest) { (data, resopnse, error) in
            var dict: NSDictionary? = nil
            do{

            dict =  try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableLeaves) as? NSDictionary
                }catch{
           }
        if let dict = dict {
                    
            success(dict)
            }else{
            failure(error! as NSError)
                }
            }
        task.resume()

    }
    
   //转换为json字符串
    func JSONString(str:NSDictionary) -> String {
          
           //判断json的可用性
           if !JSONSerialization.isValidJSONObject(str) {
               return ""
           }
           guard let data = try? JSONSerialization.data(withJSONObject: str, options: JSONSerialization.WritingOptions.prettyPrinted) else { return "" }
           
           let jsonStr = String(data: data, encoding: String.Encoding.utf8)
           return (jsonStr)!
       }
}
