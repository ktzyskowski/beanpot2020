//
//  ProductViewController.swift
//  Hackathon
//
//  Created by Kevin Zyskowski on 2/8/20.
//  Copyright © 2020 Kevin Zyskowski. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class ProductViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var products: [[String: Any]]!
    
    var db: Firestore!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as? ProductTableViewCell {
            if let name = products![indexPath.row]["name"] {
                cell.nameLabel?.text = name as? String
            }
            if let author = products![indexPath.row]["author"] {
                cell.authorLabel?.text = author as? String

            }
            cell.layoutMargins = .zero // remove table cell separator margin
            cell.contentView.layoutMargins.left = 20
            return cell
        }
        
        //cell.nameLabel?.text = products![indexPath.row]["name"]! as! String
        //cell.authorLabel?.text = products![indexPath.row]["author"]! as! String
        return UITableViewCell()
    }
    
    private func getCollection(onCompleted: @escaping () -> ()) {
        db.collection("products").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    if let products = self.products {
                        self.products!.append(document.data())
                    } else {
                        self.products = []
                    }
                    self.tableView.reloadData()
                }
            }
            onCompleted()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        db = Firestore.firestore()
        
        products = []
        
        tableView.delegate = self
        tableView.dataSource = self
        
        getCollection() {
            self.tableView.reloadData()
        }
    }
    
    var valueToPass: [String]!

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        //let indexPath = tableView.indexPathForSelectedRow!
        self.performSegue(withIdentifier: "showProductDetail", sender: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if (segue.identifier == "showProductDetail") {
            let indexPath = self.tableView!.indexPathsForSelectedRows!
            
            valueToPass = [
                products![indexPath.first!.row]["name"] as! String,
                products![indexPath.first!.row]["author"] as! String,
                products![indexPath.first!.row]["description"] as! String
            ]
            
            // initialize new view controller and cast it as your view controller
            let viewController = segue.destination as! ProductDetailViewController
            // your new view controller should have property that will store passed value
            viewController.product = self.valueToPass
        }
    }
}
