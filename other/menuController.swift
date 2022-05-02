//
//  menuController.swift
//  Guiji
//
//  Created by Pin yu Huang on 2022/4/3.
//

import Foundation
import UIKit

let apiKey = "keyFJVtTa4TlSkKFJ"

class MenuController{
    
   
    
    static let shared = MenuController()
    let baseURL = URL(string: "https://api.airtable.com/v0/apptv4BpzWCodIRFa/")!
    
    //Get Menu
        
    
    func fetchMenu(_page:String,completion:@escaping (Result<Array<MenuRecords>, Error>)->()){
        
        let menuURL = baseURL.appendingPathComponent(_page)
        guard let component = URLComponents(url: menuURL, resolvingAgainstBaseURL: true) else{return}
        guard let menuURL = component.url else{return}
        print("\(menuURL)")
        
        
        var request = URLRequest(url: menuURL)
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { data,response,error in
           
            if let data = data{
                
                do{
                    let decodeMenuResponse = try JSONDecoder().decode(MenuResponse.self, from: data)
                    completion(.success(decodeMenuResponse.records))
                
                }catch{
                    completion(.failure(error))
                    print("deocdeMenu failed")
        
                      }
                  
                } else if let error = error {
                    completion(.failure(error))
                    print("decodeMemu failed")
                }
                    
                }.resume()
        }
    
    
    
    //Post Order
    
    func orderPost(orderData:OrderResponse,completion:@escaping (Result<String,Error>)->Void){
        
        let orderURL = baseURL.appendingPathComponent("order")
        guard let component = URLComponents(url: orderURL, resolvingAgainstBaseURL: true) else{return}
        guard let orderURL = component.url else {return}
        
        var request = URLRequest(url: orderURL)
        request.httpMethod = "post"
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        let encoder = JSONEncoder()
        request.httpBody = try? encoder.encode(orderData)
        
        
        
        
        
        
    }
    
    
    
    
    //delete Order
    
    //patch Order
    
    
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

