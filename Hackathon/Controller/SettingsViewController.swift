//
//  SettingsViewController.swift
//  Hackathon
//
//  Created by Kevin Zyskowski on 2/8/20.
//  Copyright © 2020 Kevin Zyskowski. All rights reserved.
//

import UIKit
import FirebaseAuth

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signOutPressed(_ sender: Any) {
        try! Auth.auth().signOut()

        /*
        if let storyboard = self.storyboard {
            let vc = storyboard.instantiateViewController(withIdentifier: "firstController") 
                    self.present(vc, animated: false, completion: nil)
                }
         */
    
    
        UIApplication.shared.keyWindow?.rootViewController = storyboard?.instantiateInitialViewController()
    }
}
