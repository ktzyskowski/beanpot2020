//
//  Products.swift
//  Hackathon
//
//  Created by Kevin Zyskowski on 2/8/20.
//  Copyright © 2020 Kevin Zyskowski. All rights reserved.
//

import Foundation
import FirebaseFirestore

class Products {
    var productArray = [Product]()
    var db: Firestore!
    
    init() {
        db = Firestore.firestore()
    }
    
    func loadData(completed: @escaping () -> ()) {
        db.collection("products").addSnapshotListener { (querySnaphot, error) in
            guard error == nil else {
                print("Error!")
                return completed()
            }
            self.productArray = []
            for document in querySnaphot!.documents {
                let data = document.data()
                let product = Product(name: data["name"] as! String, description: data["description"] as! String, neighborhood: data["neighborhood"] as! String, category: data["category"] as! String, author: data["author"] as! String)
                self.productArray.append(product)
            }
            completed()
        }
    }
}
