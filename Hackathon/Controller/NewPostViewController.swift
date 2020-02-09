//
//  NewPostViewController.swift
//  Hackathon
//
//  Created by Kevin Zyskowski on 2/8/20.
//  Copyright © 2020 Kevin Zyskowski. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseDatabase

class NewPostViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var typeControl: UISegmentedControl!
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var descField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleField.delegate = self
        // Do any additional setup after loading the view.
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @IBAction func createPostPressed(_ sender: Any) {
        if (titleField.text != ""
            && descField.text != "") {
            let type: String
            switch typeControl.selectedSegmentIndex {
            case 0: type = "gigs"
            case 1: type = "products"
            case 2: type = "events"
            default: type = "???"
            }
            if Auth.auth().currentUser != nil {
                let db = Firestore.firestore()
                var ref: DocumentReference? = nil
                ref = db.collection(type).addDocument(data: [
                    "name": titleField.text!,
                    "description": descField.text!,
                    "category": type,
                    "neighborhood": "boston/cambridge",
                    "author": Auth.auth().currentUser!.email!
                ]) { err in
                    if let err = err {
                        print("Error adding document: \(err)")
                    } else {
                        print("Document added with ID: \(ref!.documentID)")
                        self.performSegue(withIdentifier: "afterNewPost", sender: nil)
                    }
            }
            }
            
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
    
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        descField.resignFirstResponder()
    }
}
