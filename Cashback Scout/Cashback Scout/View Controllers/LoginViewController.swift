//
//  LoginViewController.swift
//  Cashback Scout
//
//  Created by Slobodan Kovrlija on 2/13/19.
//  Copyright © 2019 Slobodan Kovrlija. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: - IBActions
    @IBAction func signInTapped(_ sender: Any) {        
        APIManager.shared.loginUserWith(name: nameTextField.text!, email: emailTextField.text!) { (flag) in
            if flag {
                print("successfull login")
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: Constants.loginToMapSegue, sender: nil)
                }
            } else {
                print("error logging in")
            }
        }
    }

}
