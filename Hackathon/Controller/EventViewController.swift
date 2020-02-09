//
//  EventViewController.swift
//  Hackathon
//
//  Created by Kevin Zyskowski on 2/9/20.
//  Copyright © 2020 Kevin Zyskowski. All rights reserved.
//

import UIKit
import FirebaseFirestore

class EventViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

     @IBOutlet weak var tableView: UITableView!
     var events: [[String: Any]]!
     
     var db: Firestore!
     
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return events?.count ?? 0
     }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         if let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath) as? ProductTableViewCell {
             if let name = events![indexPath.row]["name"] {
                 cell.nameLabel?.text = name as? String
             }
             if let author = events![indexPath.row]["author"] {
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
         db.collection("events").getDocuments() { (querySnapshot, err) in
             if let err = err {
                 print("Error getting documents: \(err)")
             } else {
                 for document in querySnapshot!.documents {
                     if let events = self.events {
                         self.events!.append(document.data())
                     } else {
                         self.events = []
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
         
         events = []
         
         tableView.delegate = self
         tableView.dataSource = self
         
         getCollection() {
             self.tableView.reloadData()
         }
     }
     
     var valueToPass: [String]!

     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

         //let indexPath = tableView.indexPathForSelectedRow!
         self.performSegue(withIdentifier: "showEventDetail", sender: nil)
     }

     override func prepare(for segue: UIStoryboardSegue, sender: Any?){
         if (segue.identifier == "showEventDetail") {
             let indexPath = self.tableView!.indexPathsForSelectedRows!
             
             valueToPass = [
                 events![indexPath.first!.row]["name"] as! String,
                 events![indexPath.first!.row]["email"] as! String,
                 events![indexPath.first!.row]["description"] as! String
             ]
             
             // initialize new view controller and cast it as your view controller
             let viewController = segue.destination as! ProductDetailViewController
             // your new view controller should have property that will store passed value
             viewController.product = self.valueToPass
         }
     }

}
