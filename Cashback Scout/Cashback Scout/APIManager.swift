//
//  APIManager.swift
//  Cashback Scout
//
//  Created by Slobodan Kovrlija on 2/14/19.
//  Copyright © 2019 Slobodan Kovrlija. All rights reserved.
//

import Foundation

struct APIManager {
    
    static let shared = APIManager()
    let baseUrlString = "https://cashback-explorer-api.herokuapp.com/"
    
    
    func createNewUserWith(name: String, email: String, completion: @escaping (Bool) -> Void) {
        let urlString = baseUrlString + "users"
        guard let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url)
        let body = [ "name": name,
                     "email": email]
        do {
            let bodyData = try JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
            request.httpMethod = "POST"
            request.httpBody = bodyData
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let httpResponse =  response as? HTTPURLResponse {
                    let token = httpResponse.allHeaderFields["Token"] as? String
                    print("Token: \(String(describing: token))")
                }
            }
            task.resume()
        } catch {
        }
        
        
    }
}
