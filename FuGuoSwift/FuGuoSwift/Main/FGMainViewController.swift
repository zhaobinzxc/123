//
//  FGMainViewController.swift
//  FuGuoSwift
//
//  Created by 赵彬 on 2020/5/29.
//  Copyright © 2020 赵彬. All rights reserved.
//

import UIKit

extension URL {
    func withQueries(_ queries: [String: String]) -> URL? {
        var components = URLComponents(url: self,
        resolvingAgainstBaseURL: true)
        components?.queryItems = queries.compactMap
        { URLQueryItem(name: $0.0, value: $0.1) }
        return components?.url
    }
}


struct ResponseInfo {
    
    struct PropertyKey {
        static let message = "message"
        static let sessionId = "sessionId"
        static let statusCode = "statusCode"
        static let userList = "userList"
        static let serialNo = "serialNo"
        
    }
    
    var message:String
    var sessionId:String?
    var serialNo:String?
    var statusCode:String
    var userList:Array<Any>?
    
    init?(json:[String:Any]) {
        
        guard let message = json[PropertyKey.message],  let statusCode = json[PropertyKey.statusCode] else {
            return nil
        }
        self.message = message as! String
        self.sessionId = (json[PropertyKey.sessionId] as! String)
        self.statusCode = statusCode as! String
        if json[PropertyKey.userList] != nil {
            self.userList = (json[PropertyKey.userList] as! Array)
        }
       
        if json[PropertyKey.serialNo] != nil {
            self.serialNo = (json[PropertyKey.serialNo] as! String)
        }
        
    }

}

struct UserInfo {
    
    struct PropertyKey {
           static let userCode = "userCode"
           static let userDepartment = "userDepartment"
           static let userDepartmentCode = "userDepartmentCode"
           static let userName = "userName"
       }
       
       var userCode:String
       var userDepartment:String?
       var userDepartmentCode:String
       var userName:String?
    
       init?(json:[String:String]) {
           
           guard let userCode = json[PropertyKey.userCode],  let userName = json[PropertyKey.userName] else {
               return nil
           }
           self.userCode = userCode
           self.userDepartment = json[PropertyKey.userDepartment]
           self.userName = userName
          self.userDepartmentCode = json[PropertyKey.userDepartmentCode]!
       }
    
}

class FGMainViewController: FGBaseViewController,UITableViewDelegate,UITableViewDataSource {
    
   
    
    

    @IBOutlet weak var myTableView: UITableView!
    
    var PeopleDic = UserInfo(json:[String : String].init())
    var isTaskID  = Bool.init()
    var ApplicationFormArray = NSMutableArray.init()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "富国基金个人报销平台"
        
        
        self.initTableView()
        self.requestUserInfo()
    }
    
    
    
    func requestTypeJson(taskId:String) -> Void{
       
        self.ApplicationFormArray = [["type" : "001","URL":"Training.json"],["type":"002","URL":"entertain.json"],["type" : "003","URL" : "contractPayment.json"],["type" : "004","URL" : "literature.json"]]
       
        
    }
    

    //请求客户信息
    func requestUserInfo() -> Void {
     let queryModel = employeesModel.init()
           queryModel.agent = "zhangsan"
           HRService.init().requestEmployeesModel(itface: queryModel, appendingPathUrlStr: "Reimburse_ment.action", success: { (responseInfo) in
               
               if responseInfo.statusCode == "SUCCESS" {
                let userinfo = UserInfo.init(json: responseInfo.userList![0] as! [String : String])
                self.PeopleDic = userinfo
                self.isTaskID = false
                self.requestTypeJson(taskId: "zhangsan")
                
               }
               
           }) { (error) in
               print(error)
    }
    }
    
    //初始化tableView
    func initTableView() -> Void {
        self.myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "myTableView")
        self.myTableView.tableFooterView = UIView.init()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell :UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "myTableView", for: indexPath)
        cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        if indexPath.row == 0 {
            cell.textLabel?.text = "一般费用报销"
        }else if indexPath.row == 1 {
             cell.textLabel?.text = "出差费用报销"
        }else if indexPath.row == 2 {
             cell.textLabel?.text = "报销列表查询"
        }else if indexPath.row == 3 {
             cell.textLabel?.text = "选择银行卡"
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     
        if indexPath.row == 0 {

            let base = FGGeneralExpenViewController.init()
            base.PeopleDic = self.PeopleDic
            self.navigationController?.pushViewController(base, animated: true)
            
        } else if indexPath.row == 1 {
            let base = FGChuChaiViewController.init()
            self.navigationController?.pushViewController(base, animated: true)
        }else if indexPath.row == 2 {
            
        }else if indexPath.row == 3 {
            
        }
    }

    
    
}
