//
//  FGSelectTextViewController.swift
//  FuGuoSwift
//
//  Created by 赵彬 on 2020/6/4.
//  Copyright © 2020 赵彬. All rights reserved.
//

import UIKit

typealias sendValueClosure = (_ string:String)->Void

class FGSelectTextViewController: FGBaseViewController,UITableViewDelegate,UITableViewDataSource {
   
    var nameArr = NSMutableArray.init()
    
    //声明一个闭包
    var testClosure:sendValueClosure?
    
    @IBOutlet weak var myTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nameArr = ["lisan","lisan1","lisan2","lisan3","lisan4","lisan5",]
        self.myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.myTableView.tableFooterView = UIView.init()
        self.myTableView.tableHeaderView = UIView.init()
        self.title = "挑选人物"
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           
           return self.nameArr.count
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           
           let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
           cell.textLabel?.text = (self.nameArr[indexPath.row] as! String)
           return cell
           
       }
       
       func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //判断闭包是否存在，然后在调用
        if testClosure != nil {
            testClosure!(self.nameArr[indexPath.row] as! String)
             print(self.nameArr[indexPath.row])
            self.navigationController?.popViewController(animated: true)
        }
          
       }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
