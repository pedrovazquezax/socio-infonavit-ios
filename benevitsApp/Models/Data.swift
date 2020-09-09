//
//  data.swift
//  testwork
//
//  Created by Pedro Antonio Vazquez Rodriguez on 08/09/20.
//  Copyright © 2020 Pedro Antonio Vazquez Rodriguez. All rights reserved.
//

import Foundation

struct LoginData: Codable {
    var email:String
    var password:String
    }


struct   Wallet:Decodable{
    var id:Int
    var name:String
    var benevits:[Benevit]?
    enum CodingKeys:String,CodingKey{
        case id = "id"
        case name = "name"
    }
}

struct  Ally:Decodable {
    var id:Int
    var name:String
    var miniLogoFullPath:String
    enum CodingKeys:String,CodingKey{
          case id = "id"
          case name = "name"
         case miniLogoFullPath = "mini_logo_full_path"
      }
}
struct Territories:Decodable{
    var id:Int
    var name:String
    enum CodingKeys:String,CodingKey{
          case id = "id"
          case name = "name"
      }
}
  

struct Benevit:Decodable{
    var id:Int
    var title:String
    var name:String
    var wallet:Wallet
    var vectorFullPath:String
    var ally:Ally
    var locked:Bool?
    var expirationDate :String
    var territories:[Territories]
    enum CodingKeys:String,CodingKey{
        case id = "id"
        case title = "title"
        case name = "name"
        case wallet = "wallet"
        case vectorFullPath = "vector_full_path"
        case ally = "ally"
        case expirationDate = "expiration_date"
        case territories = "territories"
    }
}
    
struct AllBenevits:Decodable {
    var Locked:[Benevit]
    var Unlocked:[Benevit]
    enum CodingKeys:String,CodingKey{
        case Locked = "locked"
        case Unlocked = "unlocked"
    }

}



struct userSetings:Decodable {
    var id:Int
    
    enum CodingKeys:String,CodingKey{
        case id = "id"
    }

}
