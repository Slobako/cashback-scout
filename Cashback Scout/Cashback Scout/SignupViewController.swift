//
//  SignupViewController.swift
//  Cashback Scout
//
//  Created by Slobodan Kovrlija on 2/14/19.
//  Copyright © 2019 Slobodan Kovrlija. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func signupTapped(_ sender: Any) {
        APIManager.shared.createNewUserWith(name: nameTextField.text!, email: emailTextField.text!) { (flag) in
            if flag {
                print("successfull signup")
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: Constants.signupToMapSegue, sender: nil)
                }
            }
        }
    }

}
