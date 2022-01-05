//
//  UserController.swift
//  ChoreTracker
//
//  Created by Ahava Morse on 8/24/20.
//  Copyright © 2020 Ahava Morse. All rights reserved.
//

import Foundation
import UIKit

class UserController {
    
    var users: [User] = []
    let baseURL: URL = URL(string: "https://choretracker-c5d22.firebaseio.com/")!
    let uuid = UIDevice.current.identifierForVendor?.uuidString
    
    var userListUrl: URL? {
        let fileManager = FileManager.default
        let documentsDir = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
        let usersUrl = documentsDir?.appendingPathComponent("UserList.plist")
        
        return usersUrl
    }
    
    func addUser(newUser: User) {
        users.append(newUser)
        putUsers()
        saveToPersistentStore()
    }
    
    func deleteUser(user: User) {
        if let index = users.firstIndex(of: user) {
            users.remove(at: index)
        }
        putUsers()
        saveToPersistentStore()
    }
    
    func getUsers(completion: @escaping (([User]) -> ())) {
        fetchUsers { result in
            switch result {
            case .success(let users):
                if users.isEmpty {
                    self.loadFromPersistentStore()
                    completion(self.users)
                } else {
                    completion(users)
                }
            case .failure(_):
                self.loadFromPersistentStore()
                completion(self.users)
            }
        }
    }
    
    func fetchUsers(completion: @escaping (Result<[User], Error>) -> ()) {
        guard let uuid = uuid else {
            completion(.failure(NSError(domain: "No uuid", code: 0, userInfo: nil)))
            return
        }
        
        let userUrl = baseURL.appendingPathComponent(uuid)
        
            let getUsersUrl = userUrl.appendingPathComponent("users").appendingPathExtension("json")
            
            var request = URLRequest(url: getUsersUrl)
            request.httpMethod = "GET"
            
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                
                if let error = error {
                    NSLog("Error receiving user data: \(error)")
                    completion(.failure(error))
                    return
                }
                
                if let response = response as? HTTPURLResponse,
                    response.statusCode != 200 {
                    completion(.failure(NSError(domain: "", code: response.statusCode, userInfo: nil)))
                    return
                }
                
                guard let data = data else {
                    completion(.failure(NSError(domain: "Bad Data", code: 0, userInfo: nil)))
                    return
                }
                
//                print(String(data: data, encoding: .utf8))
                
                let decoder = JSONDecoder()
                do {
                    let users = try decoder.decode([User].self, from: data)
                    self.users = []
                    for (user) in users {
                        self.users.append(user)
                    }
                    
                    completion(.success(users))
                } catch {
                    NSLog("Error decoding user objects: \(error)")
                    completion(.failure(error))
                    return
                }
            }.resume()
        }
    
    func putUsers() {
        guard let uuid = uuid else {
            NSLog("No uuid")
            return
        }
        
        let userUrl = baseURL.appendingPathComponent(uuid)
        
        let putUsersUrl = userUrl.appendingPathComponent("users").appendingPathExtension("json")
        
        var request = URLRequest(url: putUsersUrl)
        
        request.httpMethod = "PUT"
        
        let jsonEncoder = JSONEncoder()
        do {
            let jsonData = try jsonEncoder.encode(self.users)
            request.httpBody = jsonData
        } catch {
            NSLog("Error encoding user objects: \(error)")
            return
        }
        
        URLSession.shared.dataTask(with: request) { (_, response, error) in
            if let error = error {
                NSLog("Other error: \(error)")
                return
            }
            
            if let response = response as? HTTPURLResponse,
                response.statusCode != 200 {
                NSLog("Status code: \(response.statusCode)")
                return
            }
        }.resume()
    }
    
    func saveToPersistentStore() {
        do {
            let encoder = PropertyListEncoder()
            let usersData = try encoder.encode(users)
            guard let userListUrl = userListUrl else { return }
            try usersData.write(to: userListUrl)
            
            print("saved users")
        } catch {
            print("Couldn't save users: \(error)")
        }
    }
    
    func loadFromPersistentStore() {
        do {
            guard let userListUrl = userListUrl else { return }
            
            let usersPlist = try Data(contentsOf: userListUrl)
            let decoder = PropertyListDecoder()
            let decodedUsers = try decoder.decode([User].self, from: usersPlist)
            self.users = decodedUsers
            
            print("recovered users")
        } catch {
            print("Couldn't load users: \(error)")
        }
    }
}
