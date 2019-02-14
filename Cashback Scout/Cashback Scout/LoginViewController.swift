//
//  LoginViewController.swift
//  Cashback Scout
//
//  Created by Slobodan Kovrlija on 2/13/19.
//  Copyright © 2019 Slobodan Kovrlija. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func signInTapped(_ sender: Any) {
        APIManager.shared.createNewUserWith(name: nameTextField.text!, email: emailTextField.text!) { (flag) in
            if flag {
                print("successfull signup")
            }
        }
    }
    
    
    @IBAction func signUpTapped(_ sender: Any) {
    }
    

}
