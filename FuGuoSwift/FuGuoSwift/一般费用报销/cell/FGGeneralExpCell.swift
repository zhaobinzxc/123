//
//  FGGeneralExpCell.swift
//  FuGuoSwift
//
//  Created by 赵彬 on 2020/6/3.
//  Copyright © 2020 赵彬. All rights reserved.
//

import UIKit
protocol SomeProtocol {
    //协议内容

    func passParams(tmpInteger:NSInteger)
    
    
}


class FGGeneralExpCell: UITableViewCell {
    
   

    @IBOutlet weak var leftLab: UILabel!
    
    @IBOutlet weak var rightBut: UIButton!
    
    @IBOutlet weak var showBut: UIButton!
    
    var titleNameArr:Array<Any>!
    
    //定义block
    typealias block = (_ str:String) -> Void
    //声明
    var callBack = block?.self
    
    var delegate:SomeProtocol?
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
      
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
}
    

    @IBAction func clearButtonText(_ sender: UIButton) {
        
     
    }
    
    
    @IBAction func selectTextButton(_ sender: UIButton) {
        if self.delegate != nil {
            self.delegate?.passParams(tmpInteger: sender.tag)
        }
    }
}
