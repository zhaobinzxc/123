//
//  FGGeneralExpenViewController.swift
//  FuGuoSwift
//
//  Created by 赵彬 on 2020/6/2.
//  Copyright © 2020 赵彬. All rights reserved.
//

import UIKit







class FGGeneralExpenViewController: FGBaseViewController,SomeProtocol,UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,FGTakePhotoCollectionCellDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate {
    
    
   
    
    var PeopleDic = UserInfo.init(json: [String : String].init())
    var peopleCode:String!
    var BudgeDepartmentCode:String!
    var titleNameArray:Array<Any>?
    var titleNameArr:Array<Any>?
    var tagStr:NSInteger!
    
    var delegate:SomeProtocol!
    @IBOutlet weak var progressIV: UIImageView!
    @IBOutlet weak var myTableView: UITableView!
    
    @IBOutlet weak var myCollectionView: UICollectionView!
    @IBOutlet weak var nextBut: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initData()
    }

    //初始化
    func initData() -> Void {
        self.delegate = self
    self.title = "一般费用报销"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "back_new@2x.png"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(back))
    self.peopleCode = self.PeopleDic?.userCode
    self.titleNameArray = ["经办人","报销人","预算归属","项目","费用指标","申请单"]
    self.BudgeDepartmentCode = self.PeopleDic?.userDepartmentCode
        self.requestSerialNoStr()

    self.myTableView.register(UINib.init(nibName: "FGGeneralExpCell", bundle: nil), forCellReuseIdentifier: "dequeueReusableCell")
    self.myTableView.isScrollEnabled = false
    self.myTableView.tableHeaderView = UIView.init()
    self.myTableView.tableFooterView = UIView.init()
        
    self.myCollectionView.register(UINib.init(nibName: "FGTakePhotoCollectionCell", bundle: nil), forCellWithReuseIdentifier: "FGTakePhotoCollectionCell")
    }
    //获取批次号
    func requestSerialNoStr() -> Void {
        let model = employeesModel.init()
        model.agent = self.peopleCode
        HRService.init().requestEmployeesModel(itface: model, appendingPathUrlStr: "CreatSerialno.action", success: { (responseInfo) in
            
            print(responseInfo.serialNo! as String)
        }) { (error) in
            print(error)
        }
        
        
    }
    
    //下一步
    @IBAction func nextButton(_ sender: UIButton) {
        self.myTableView.isHidden = true
        self.progressIV.image = UIImage.init(named: "header_3.jpg")
        self.initCollectionView()
    }
    //初始化
    func initCollectionView() -> Void {
        
        self.myCollectionView.isHidden = false
      
    }
    
   //返回上一步
    @objc func back() {
        
        self.navigationController?.popViewController(animated: true)
    }
    
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.titleNameArray!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "dequeueReusableCell", for: indexPath) as! FGGeneralExpCell
        self.configure(cell: cell, indexPath: indexPath)
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        return cell
    }
    
    func configure(cell:FGGeneralExpCell,indexPath: IndexPath) -> Void {
        
        cell.leftLab?.text = (self.titleNameArray![indexPath.row] as! String)
        cell.showBut.tag = indexPath.row + 1
        cell.delegate = self
    }
    //协议
    func passParams(tmpInteger: NSInteger) {
           self.tagStr = tmpInteger
           let selectVC = FGSelectTextViewController.init()
          selectVC.testClosure = myClosure
          self.navigationController?.pushViewController(selectVC, animated: true)
    }
    //定义一个带字符串参数的闭包
    func myClosure(testStr:String)->Void{
             //给textLab 赋值
             //这句话什么时候执行？，闭包类似于oc中的block或者可以理解成c语言中函数，只有当被调用的时候里面的内容才会执行
     let but:UIButton = self.myTableView.viewWithTag(self.tagStr as NSInteger) as! UIButton
     but.setTitle(testStr, for: UIControl.State.normal)
     let docPath  = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.allDomainsMask, true)[0] as NSString
        print(docPath)
        let filePath = docPath.appendingPathComponent("text.txt")
        
        let dataSource = NSMutableArray();
        dataSource.add("衣带渐宽终不悔");
        dataSource.add("为伊消得人憔悴");
        dataSource.add("故国不堪回首明月中");
        dataSource.add("人生若只如初见");
        dataSource.add("暮然回首，那人却在灯火阑珊处");
       let dict = ["dict":dataSource] as NSDictionary
       let str:String =  HRService.init().JSONString(str: dict)
       try! str.write(toFile: filePath, atomically: true, encoding: String.Encoding.utf8)
    
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
           return 1
       }
       
       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FGTakePhotoCollectionCell", for: indexPath) as! FGTakePhotoCollectionCell
        cell.delegate = self
        
        return cell
        
        
       }
    
    func userTakePhoto() {
        
        let alert = UIAlertController.init(title: "温馨提示", message: "拍照", preferredStyle: UIAlertController.Style.alert)
        let action = UIAlertAction.init(title: "拍照", style: UIAlertAction.Style.default) { (action) in
            self.takePhoto()
        }
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
        
        
    }
    //拍照
    func takePhoto() -> Void {
      
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
            
            let camera = UIImagePickerController()
            camera.delegate = self
            camera.sourceType = .camera
            self.present(camera, animated: true, completion: nil)
            
        }else{
            print("不支持拍照")
        }
        
        
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let image : UIImage = info[UIImagePickerController.InfoKey.editedImage] as! UIImage

       print(image)

        self.dismiss(animated: true, completion: nil)
        
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
