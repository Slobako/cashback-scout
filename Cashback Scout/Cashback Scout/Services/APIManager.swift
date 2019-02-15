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
    
    // creates new user
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
                    if let token = httpResponse.allHeaderFields["Token"] as? String {
                        print("Token: \(String(describing: token))")
                        KeychainService.saveToken(token: token)
                        completion(true)
                    }
                }
            }
            task.resume()
        } catch {
        }
    }
    
    // signs in user
    func loginUserWith(name: String, email: String, completion: @escaping (Bool) -> Void) {
        let urlString = baseUrlString + "login"
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
            if let token = KeychainService.loadToken() {
                request.addValue(token, forHTTPHeaderField: "Token")
            } else {
                print("Error: Token missing")
                return
            }
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let httpResponse =  response as? HTTPURLResponse {
                    if let token = httpResponse.allHeaderFields["Token"] as? String {
                        print("Token: \(String(describing: token))")
                        KeychainService.saveToken(token: token)
                        completion(true)
                    }
                }
            }
            task.resume()
        } catch {
        }
    }
    
    // fetches all venues in a given city
    func fetchVenuesIn(city: String, completion: @escaping (Bool) -> Void) {
        let urlString = baseUrlString + "venues"
        var components = URLComponents(string: urlString)
        components?.queryItems = [URLQueryItem(name: "city", value: "\(city)")]
        guard let url = components?.url else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        if let token = KeychainService.loadToken() {
            request.addValue(token, forHTTPHeaderField: "Token")
        } else {
            print("Error: Token missing")
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if response != nil {
                guard let data = data else { return }
                do {
                    if let json = try JSONSerialization.jsonObject(with: data) as? [String: AnyObject] {
                        print("json: \(json)")
                    }
                } catch {
                    
                }
            } else {
                print("response returned is nil")
            }
        }
        task.resume()
    }
}
