//
//  UserController.swift
//  ChoreTracker
//
//  Created by Ahava Morse on 8/24/20.
//  Copyright © 2020 Ahava Morse. All rights reserved.
//

import Foundation

class UserController {
    
    let baseURL: URL = URL(string: "https://choretracker-c5d22.firebaseio.com/")!
    var users: [User] = []
    
    // Temporary users for testing
//    var users: [User] = [User(name: "Asher"), User(name: "Harmony"), User(name: "Ahava")]
    
    func addUser(newUser: User) {
        users.append(newUser)
    }
    
    func deleteUser(user: User) {
        if let index = users.firstIndex(of: user) {
            users.remove(at: index)
        }
        
        // TODO: remove user from chore user lists
    }
    
    func getUsers(completion: @escaping (Error?) -> ()) {
            let getUsersUrl = baseURL.appendingPathComponent("users").appendingPathExtension("json")
            
            var request = URLRequest(url: getUsersUrl)
            request.httpMethod = "GET"
            
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                
                if let error = error {
                    NSLog("Error receiving user data: \(error)")
                    completion(error)
                    return
                }
                
                if let response = response as? HTTPURLResponse,
                    response.statusCode != 200 {
                    completion(NSError(domain: "", code: response.statusCode, userInfo: nil))
                    return
                }
                
                guard let data = data else {
                    completion(NSError(domain: "Bad Data", code: 0, userInfo: nil))
                    return
                }
                
    //            print(String(data: data, encoding: .utf8))
                
                let decoder = JSONDecoder()
                do {
                    let users = try decoder.decode([User].self, from: data)
                    self.users = []
                    for (user) in users {
                        self.users.append(user)
                    }
                    
                    completion(nil)
                } catch {
                    NSLog("Error decoding user objects: \(error)")
                    completion(error)
                    return
                }
            }.resume()
        }
    
    
}
