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
    
    // MARK: - IBActions
    @IBAction func signupTapped(_ sender: Any) {
        APIManager.shared.createNewUserWith(name: nameTextField.text!, email: emailTextField.text!) { (flag) in
            if flag {
                print("successful signup")
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: Constants.signupToMapSegue, sender: nil)
                }
            } else {
                print("error signing up")
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Error", message: "Error signing up.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }

}
