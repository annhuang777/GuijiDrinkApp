//
//  cartTableViewController.swift
//  Guiji
//
//  Created by Pin yu Huang on 2022/4/25.
//

import UIKit
import os
class cartTableViewController: UITableViewController {
    let logger = Logger()
    
    //總杯數及總額outlet
    
    @IBOutlet weak var cartTotalPrice: UILabel!
    @IBOutlet weak var cartTotalCups: UILabel!
    
    @IBOutlet weak var orderIndicator: UIActivityIndicatorView!
    
    
    @IBOutlet weak var totalView: UIView!
    
    
    var orderResponse:OrderResponse?
    var orderRecords = [OrderResponse.OrderRecords]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
       

        orderIndicator.startAnimating()
        totalView.isHidden = true
       
        
        fetchOrder()
       
       
    }
    
    
    func fetchOrder(){

        let urlStr = URL(string: "https://api.airtable.com/v0/apptv4BpzWCodIRFa/order")!
        var request = URLRequest(url: urlStr)

        request.setValue("Bearer keyFJVtTa4TlSkKFJ", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")


        URLSession.shared.dataTask(with: request) { data, response, error in
            do{
                let decoder = JSONDecoder()
                if let data = data {
                    self.orderResponse = try? decoder.decode(OrderResponse.self, from: data)


                    DispatchQueue.main.async { [self] in


                        self.orderRecords = self.orderResponse!.records

                        self.tableView.reloadData()
                        
                        totalView.isHidden = false
                        orderIndicator.stopAnimating()
                        orderIndicator.isHidden = true
                        
                    }
                }}catch{
                    print("fetch error")
                }

            }.resume()

     

  
    }
        

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return orderRecords.count
        
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cartCell", for: indexPath) as? cartTableViewCell
        
        let order = orderResponse?.records[indexPath.row]
        
        cell?.cartOrderName.text = order?.fields.orderName
        cell!.cartDrinkName.text = order?.fields.drinkName
        cell?.cartIce.text = order?.fields.ice
        cell?.cartSugar.text = order?.fields.sugar
        cell?.cartTopping.text = order?.fields.topping
        cell?.cartQuantity.text = order?.fields.quantity.description
        cell?.cartSubtotal.text = order?.fields.subtotal.description
        
       totalCounting()
    
        return cell!
    }
    
    func totalCounting(){
        //計算totalPrice及總杯數
        cartTotalCups.text = "\(orderRecords.count)" + "杯"
        
        var total = 0
        for i in orderRecords{
            
            total += i.fields.subtotal
            cartTotalPrice.text = "\(total)" + "元"
        }
    }
    
    
    
    
    //右滑刪除訂購資料及update airtable訂購資料
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//
        if editingStyle == .delete{

            //根據id來做刪除
            let urlStr = URL(string: "https://api.airtable.com/v0/apptv4BpzWCodIRFa/order" + "/" + (self.orderResponse?.records[indexPath.row].id)!)!

            var request = URLRequest(url: urlStr)
            request.httpMethod = "DELETE"
            request.setValue("Bearer keyFJVtTa4TlSkKFJ", forHTTPHeaderField: "Authorization")
            
            if editingStyle == .delete {
                
                
                URLSession.shared.dataTask(with: request) { data, response, error in
                   guard let response = response as? HTTPURLResponse else{return}
                    
                    print("status:",response.statusCode)
                    //feedBack = 200 成功
                    
                    DispatchQueue.main.async {
                        //刪除tableview上的row
                        tableView.deleteRows(at: [indexPath], with: .fade)
                        self.logger.log("deleteTheRow")
                        //因刪除row重新計算總金額跟總杯數
                        self.totalCounting()
                        //重新update airtable Order資料
                        self.fetchOrder()

                        self.logger.log("fetchOrderData")

                        self.orderRecords.remove(at: indexPath.row)

                    }

            }.resume()
                //刪除tableview上資料
                self.orderRecords.remove(at: indexPath.row)

                self.logger.log("removeTheRecord")

            }
            

            
            
        

           
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}



    }
    
    
    
    
    
    
    
}
    


