//
//  LoginViewController.swift
//  Hackathon
//
//  Created by Kevin Zyskowski on 2/8/20.
//  Copyright © 2020 Kevin Zyskowski. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    var handle: AuthStateDidChangeListenerHandle?

    override func viewWillAppear(_ animated: Bool) {
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
          if let user = user {
            self.performSegue(withIdentifier: "showHome", sender: nil)
          }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        emailField.delegate = self
        passwordField.delegate = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        Auth.auth().removeStateDidChangeListener(handle!)
    }
    
    @IBAction func loginPressed(_ sender: Any) {
        if (emailField.text ==  "" || passwordField.text == "") {
            return
        }
        
        Auth.auth().signIn(withEmail: emailField.text!, password: passwordField.text!) { [weak self] authResult, error in
            guard self != nil else { return }
            self?.performSegue(withIdentifier: "showHome", sender: nil)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
}
