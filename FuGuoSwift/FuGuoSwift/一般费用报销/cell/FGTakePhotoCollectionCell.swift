//
//  FGTakePhotoCollectionCell.swift
//  FuGuoSwift
//
//  Created by 赵彬 on 2020/6/5.
//  Copyright © 2020 赵彬. All rights reserved.
//

import UIKit

protocol FGTakePhotoCollectionCellDelegate {
    
    func userTakePhoto()
}

class FGTakePhotoCollectionCell: UICollectionViewCell {

    @IBOutlet weak var pictureIV: UIImageView!
   
    var delegate:FGTakePhotoCollectionCellDelegate!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func takePhoto(_ sender: UIButton) {
       
        if self.delegate != nil {
            
            self.delegate!.userTakePhoto()
        }

        
    }
}
