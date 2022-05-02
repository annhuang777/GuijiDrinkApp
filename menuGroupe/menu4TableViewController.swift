//
//  menu4TableViewController.swift
//  Guiji
//
//  Created by Pin yu Huang on 2022/4/9.
//

import UIKit

class menu4TableViewController: UITableViewController {
    
    
    var menuResponse:MenuResponse?
    var  menuRecords = [MenuResponse.MenuRecords]()
    
    
    let apiKey = "keyFJVtTa4TlSkKFJ"
    
    
    
    func fetchMenuRecords(){
        let urlStr = URL(string: "https://api.airtable.com/v0/apptv4BpzWCodIRFa/menu4")
        
        var request =  URLRequest(url: urlStr!)
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            let decoder = JSONDecoder()
            
            if let data = data {
                self.menuResponse = try? decoder.decode(MenuResponse.self, from: data)
                
                DispatchQueue.main.async {
                    self.menuRecords = self.menuResponse!.records
                    self.tableView.reloadData()
                }
                
            }
        }.resume()
        
        
        
        
        
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchMenuRecords()

        
    }
    
    
    @IBSegueAction func passingMenu4(_ coder: NSCoder) -> getOrderViewController? {
        guard let row = tableView.indexPathsForSelectedRows?.first?.row else{return nil}
            
        return getOrderViewController.init(coder: coder, indexPath: row, menuInfor: menuResponse!)
    }
  

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return menuRecords.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell4", for: indexPath) as?
        menu4TableViewCell
        
        let menu = menuResponse?.records[indexPath.row]
        
        cell?.drinkItemLabel.text = menu?.fields.drinkName
        cell?.priceLabel.text = menu?.fields.price.description
        cell?.recommendLabel.text = menu?.fields.recommend
        
        if cell?.recommendLabel.text == "true"{
            cell?.itemImageView.image = UIImage(named: "mark")
        }

        // Configure the cell...

        return cell!
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
