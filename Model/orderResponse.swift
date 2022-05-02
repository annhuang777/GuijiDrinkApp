//
//  orderResponse.swift
//  Guiji
//
//  Created by Pin yu Huang on 2022/4/8.
//

import Foundation


struct OrderResponse:Codable{
      
    let records:[OrderRecords]
    
    struct OrderRecords:Codable{
        var id:String?
        var createdTime:String?
        var fields:OrderFields
    }
   
        }
 
struct OrderFields:Codable{
    var orderName:String
    var ice:String
    var topping:String
    var sugar:String
    var quantity:Int
    var subtotal:Int
    var drinkName:String
}




