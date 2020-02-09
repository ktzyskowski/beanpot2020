//
//  SignupViewController.swift
//  Hackathon
//
//  Created by Kevin Zyskowski on 2/8/20.
//  Copyright © 2020 Kevin Zyskowski. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignupViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var passwordConfirmField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        emailField.delegate = self
        passwordField.delegate = self
        passwordConfirmField.delegate = self
    }
    
    @IBAction func createAccountPressed(_ sender: Any) {
        if (emailField.text == ""
            || passwordField.text == ""
            || passwordConfirmField.text == "") {
            return
        }
        else if (passwordField.text != passwordConfirmField.text) {
            return
        }
        else {
            Auth.auth().createUser(withEmail: emailField.text!, password: passwordField.text!) { authResult, error in
                if Auth.auth().currentUser != nil {
                    self.performSegue(withIdentifier: "showHome", sender: nil)
                } else {
                    self.performSegue(withIdentifier: "showLogin", sender: nil)
                }
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
}
