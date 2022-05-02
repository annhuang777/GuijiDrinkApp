//
//  menuResponse.swift
//  Guiji
//
//  Created by Pin yu Huang on 2022/4/3.
//

import Foundation


struct MenuResponse:Codable{
    
    let records:[MenuRecords]
    
    struct MenuRecords:Codable{
        let id:String
        let createdTime:String
        let fields:MenuFields
        
    }
    
    struct MenuFields:Codable{
            let price:Int
            let drinkName:String
            let recommend:String
        
        }
        

    }


    

    

