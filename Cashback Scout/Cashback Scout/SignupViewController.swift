//
//  SignupViewController.swift
//  Cashback Scout
//
//  Created by Slobodan Kovrlija on 2/14/19.
//  Copyright © 2019 Slobodan Kovrlija. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController {

    // IBOutlets
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    // Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signupTapped(_ sender: Any) {
        APIManager.shared.createNewUserWith(name: nameTextField.text!, email: emailTextField.text!) { (flag) in
            if flag {
                print("successfull signup")
            }
        }
    }
    
    @IBAction func backToLogin(_ sender: Any) {
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
