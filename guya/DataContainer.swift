//
//  DataContainer.swift
//  guya
//
//  Created by Yusuf Tezel on 26/04/2018.
//  Copyright © 2018 Yusuf Tezel. All rights reserved.
//

import Foundation
import Firebase

class DataContainer {
    static let shared = DataContainer()
    private let db = Firestore.firestore()
    var foodCategories = [FoodCategory]()
    
    private init() {
        let settings = db.settings
        settings.areTimestampsInSnapshotsEnabled = true
        db.settings = settings
    }
    
    func fetchData(callback: @escaping () -> Void){
        db.collection("foodCategory").order(by: "rank", descending: true).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    self.foodCategories.append(FoodCategory(id: document.documentID, data: document.data()))
                }
                callback()
            }
        }
    }
}
