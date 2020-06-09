//
//  employeesModel.swift
//  FuGuoSwift
//
//  Created by 赵彬 on 2020/6/1.
//  Copyright © 2020 赵彬. All rights reserved.
//

import UIKit

class employeesModel: NSObject {
    
    var agent:String = ""
    
    func employeesModel() -> NSDictionary {
        
        let dict:NSMutableDictionary = NSMutableDictionary.init()
       
        dict.setObject(self.agent, forKey:"agent" as NSCopying)
        return dict
    }
}
