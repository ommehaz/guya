//
//  FoodCategory.swift
//  guya
//
//  Created by Yusuf Tezel on 26/04/2018.
//  Copyright © 2018 Yusuf Tezel. All rights reserved.
//

import Foundation

struct FoodCategory {
    let id: String
    let name: String
    let enabled: Bool
    let imageName: String
    let rank: Int
    let imageUrl: String
    
    init(id: String, data: [String:Any]) {
        self.id = id
        self.name = data["name"] as! String
        self.enabled = data["enabled"] as! Bool
        self.imageName = data["imageName"] as! String
        self.rank = data["rank"] as! Int
        self.imageUrl = data["imageUrl"] as! String
    }
}
