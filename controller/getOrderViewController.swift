//
//  getOrderViewController.swift
//  Guiji
//
//  Created by Pin yu Huang on 2022/4/16.
//

import UIKit


class getOrderViewController: UIViewController {
    
    
    
    let apiKey = "keyFJVtTa4TlSkKFJ"
    

     //ice
    @IBOutlet weak var iceBtn: UIButton!
    @IBOutlet var iceOptions: [UIButton]!
    
    //sugar
    @IBOutlet weak var sugarBTn: UIButton!
    @IBOutlet var sugarOptions: [UIButton]!//extraTopping
    
    //topping
    @IBOutlet weak var toppingBtn: UIButton!
    @IBOutlet var toppingOptions: [UIButton]!
    
    //passingDataFromMenuVC(name and price)
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    //nameTextField
    
    @IBOutlet weak var nameTextField: UITextField!
    
    //mimus and plus button
    
    @IBOutlet weak var plusBtn: UIButton!
    @IBOutlet weak var amountLabel: UILabel!
    
    @IBOutlet weak var minusBtn: UIButton!
    @IBOutlet weak var subtatol: UILabel!
    
    //addCartBTn
    
    @IBOutlet weak var addBtn: UIButton!
    
    
    //init:
    
    var amountNum :Int = 1
    
    var ordrPrice:Int = 0
    
    var toppingPrice:Int = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameLabel.text = "\(productItem)"
        priceLabel.text = "\(productPrice)"
        
       
        updateSubtatol()
   
       
       
        
    }
    
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
     */
     
   
    //addBtn:alert and post APi
     
     @IBAction func addCartPressed(_ sender: UIButton) {
         
         if nameTextField.text == ""{
             
             let controller = UIAlertController(title: "訂購人空白", message: "請填寫訂購大名", preferredStyle: .alert)
             
             let action = UIAlertAction(title: "OK", style: .default)
             controller.addAction(action)
            present(controller, animated: true)
             
         }else{
             
             let orderName = nameTextField.text ?? ""
             let drinkName = productItem
             let ice = iceBtn.titleLabel?.text
             let sugar = sugarBTn.titleLabel?.text
             let topping = toppingBtn.titleLabel?.text
             let quantity = Int(amountLabel.text!)
             let subtatol = productPrice + toppingPrice
             
            let urlStr = URL(string: "https://api.airtable.com/v0/apptv4BpzWCodIRFa/order")!
             
             var request = URLRequest(url: urlStr)
             request.httpMethod = "POST"
             request.setValue("Bearer keyFJVtTa4TlSkKFJ", forHTTPHeaderField: "Authorization")
             request.setValue("application/json", forHTTPHeaderField: "Content-Type")
           
             
             let orderFields = OrderFields(orderName: orderName, ice: ice ?? "", topping: topping ?? "", sugar: sugar ?? "", quantity: quantity!, subtotal: subtatol, drinkName: drinkName)
             
             print(orderFields)
             
        
             let records = OrderResponse.OrderRecords(id:nil, createdTime: nil, fields: orderFields)


             let encoder = JSONEncoder()
             let data = try? encoder.encode(records)
             request.httpBody = data
             
            
             URLSession.shared.uploadTask(with: request, from: data){data,response,error in
                 

                 if let data = data ,let content = String(data:data, encoding:.utf8){
                     print("check",content)


                 }else{
                     print("failed")
                 }
             }.resume()
                 
            
             //訂購成功alert
             
            
            let controller = UIAlertController(title: "訂購成功", message:"a nice Choise" , preferredStyle:.alert)
            
             let action =  UIAlertAction(title:"OK", style: .default)
                 controller.addAction(action)
                 present(controller, animated: true, completion: nil)
                 
                //完成訂購後
                //addBtn 不能再按且變成灰色
                 addBtn.isEnabled = false
                 addBtn.backgroundColor = .gray
                //textField從有名字變成空白
                 nameTextField.text = ""
             
            
         }
         
        
     }

    
    
    
    
    //passingData from menu1~menu4 IBsegueAction init
    
    var indePath:Int
    var productItem:String
    var productPrice:Int
    var orderId:String
    var createdTime:String
    
    init?(coder:NSCoder,indexPath:Int,menuInfor:MenuResponse) {
        self.productItem = menuInfor.records[indexPath].fields.drinkName
        self.productPrice = menuInfor.records[indexPath].fields.price
        
        self.indePath = indexPath
        self.orderId = menuInfor.records[indexPath].id
        self.createdTime = menuInfor.records[indexPath].createdTime
        
       super.init(coder:coder)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
    
     

    //加減button and 數量
    
    @IBAction func plusPressd(_ sender: UIButton) {
        
        if amountNum<20{
            amountLabel.text = "\(amountNum)"
            amountNum += 1
            
        }
        
        updateSubtatol()
        
    }
    
    
    @IBAction func minusPressed(_ sender: UIButton) {
        
        if amountNum > 1{
            amountNum -= 1
            amountLabel.text = "\(amountNum)"
            
        }
        
        updateSubtatol()
    }
    
 
    func updateSubtatol(){
      
        
      let orderPrice = (productPrice + toppingPrice) * amountNum
        
        subtatol.text = "$\(orderPrice)"
        
    }
    
    
    
    //點nameTextField收鍵盤
    
    @IBAction func dismissKeyboard(_ sender: Any) {
        nameTextField.endEditing(true)
    }
    
    

//iceSelectionBtn
    
    
    
    @IBAction func iceButton(_ sender: UIButton) {
            //點選iceButton秀出iceOptions;反之
            for iceOption in self.iceOptions{
                //＝！相反符號
                iceOption.isHidden = !iceOption.isHidden
            }
    
        
    
    }
    
    
    
    @IBAction func iceSelectiionPressd(_ sender: UIButton) {
        
        //選擇冰量後，在iceBtn顯示
        //使用uiview.animate讓iceOptions收起（即hidden)
        //且可進行再選
        if let btnText = sender.titleLabel?.text{
            iceBtn.setTitle(btnText, for: .normal)
        }
         
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut) {
            for iceOption in self.iceOptions{
                iceOption.isHidden = true
            }
      
        }
        
        
    }
    
    //sugarSelectionBtn
    
    @IBAction func sugarBtn(_ sender: UIButton) {
     
            for sugaroption in self.sugarOptions{
                sugaroption.isHidden = !sugaroption.isHidden
            }
        
    }
    
    @IBAction func sugarSelectionPressed(_ sender: UIButton) {
       
            if let sugarText = sender.titleLabel?.text{
                sugarBTn.setTitle(sugarText, for: .normal)
                
            }
        
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut) {
            for sugerOption in self.sugarOptions{
                sugerOption.isHidden = true
            }
      
        }
        
        
        
            
       
    }
    //toppingSelectionBtn
    
    @IBAction func toppingBtn(_ sender: UIButton) {
            
        
        for toppingOption in self.toppingOptions{
        toppingOption.isHidden = !toppingOption.isHidden
        }
        //如果重選不想添加:buttonＳetTitle改完加料跟toppingPrice為0
        toppingBtn.setTitle("加料", for: .normal)
        toppingPrice = 0
        
       
         updateSubtatol()
         
    }
    
    
    @IBAction func toppingSelectionPressed(_ sender: UIButton) {
        
        if let toppingText = sender.titleLabel?.text{
            toppingBtn.setTitle(toppingText, for: .normal)
            //如果點選toppingOptionsBtn，toppingPrice為10元
            toppingPrice = 10
        }
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut) {
            for toppingOption in self.toppingOptions{
                toppingOption.isHidden = true
            }
            
            
            self.updateSubtatol()
      
        }
        
        
        
        
    }
    
    
   
    
}

