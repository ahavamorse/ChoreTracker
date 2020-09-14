//
//  ChoreController.swift
//  ChoreTracker
//
//  Created by Ahava Morse on 8/10/20.
//  Copyright © 2020 Ahava Morse. All rights reserved.
//

import Foundation
import UIKit

class ChoreController {
    
    var chores: [Chore]
    let baseURL: URL = URL(string: "https://choretracker-c5d22.firebaseio.com/")!
    let uuid = UIDevice.current.identifierForVendor?.uuidString
    
    var choreListUrl: URL? {
        
        let fileManager = FileManager.default
        let documentsDir = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
        let choresUrl = documentsDir?.appendingPathComponent("ChoreList.plist")
        
        return choresUrl
    }
    
    // Same to userController (erase getChores from viewController)
    init() {
        chores = []
//        getChores { (error) in
//            if let error = error {
//                NSLog("Error: \(error)")
//            }
//        }
        
        loadFromPersistentStore()
    }
    
    func completeChore(chore: Chore) {
        if let choreIndex = chores.firstIndex(of: chore) {
            let user = chore.nextUser
            chores[choreIndex].users.remove(at: 0)
            chores[choreIndex].users.append(user)
            
            putChores()
            saveToPersistentStore()
        }
    }
    
    func skipUser(chore: Chore) {
        // TODO: Come back to user
        if let choreIndex = chores.firstIndex(of: chore) {
            let user = chore.nextUser
            chores[choreIndex].users.remove(at: 0)
            chores[choreIndex].users.append(user)
            
            putChores()
            saveToPersistentStore()
        }
    }
    
    func addChore(newChore: Chore) {
        chores.append(newChore)
        putChores()
        saveToPersistentStore()
    }
    
    func editChore(from oldChore: Chore, into newChore: Chore) {
        
        if let choreIndex = chores.firstIndex(of: oldChore) {
            chores.remove(at: choreIndex)
            chores.insert(newChore, at: choreIndex)
        }
        putChores()
        saveToPersistentStore()
    }
    
    func deleteChore(chore: Chore) {
        if let index = chores.firstIndex(of: chore) {
            chores.remove(at: index)
        }
        putChores()
        saveToPersistentStore()
    }
    
    func removeUser(user: User) {
        for index in 0...chores.count - 1 {
            if let userIndex = chores[index].users.firstIndex(of: user) {
                chores[index].users.remove(at: userIndex)
            }
        }
        putChores()
        saveToPersistentStore()
    }
    
    func getChores(completion: @escaping (Error?) -> ()) {
        guard let uuid = uuid else {
            completion(NSError(domain: "No uuid", code: 0, userInfo: nil))
            return
        }
        
        let userUrl = baseURL.appendingPathComponent(uuid)
        let getChoresUrl = userUrl.appendingPathComponent("chores").appendingPathExtension("json")
        
        var request = URLRequest(url: getChoresUrl)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                NSLog("Error receiving chore data: \(error)")
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
                let chores = try decoder.decode([Chore].self, from: data)
                self.chores = []
                for (chore) in chores {
                    self.chores.append(chore)
                }
                
                completion(nil)
            } catch {
                NSLog("Error decoding chore objects: \(error)")
                completion(error)
                return
            }
        }.resume()
    }
    
    func putChores() {
        guard let uuid = uuid else {
            NSLog("No uuid")
            return
        }
        
        let userUrl = baseURL.appendingPathComponent(uuid)
        
        let putChoresUrl = userUrl.appendingPathComponent("chores").appendingPathExtension("json")
        
        var request = URLRequest(url: putChoresUrl)
        
        request.httpMethod = "PUT"
        
        let jsonEncoder = JSONEncoder()
        do {
            let jsonData = try jsonEncoder.encode(self.chores)
            request.httpBody = jsonData
        } catch {
            NSLog("Error encoding chore objects: \(error)")
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
            let choresData = try encoder.encode(chores)
            guard let choreListUrl = choreListUrl else { return }
            try choresData.write(to: choreListUrl)
            
            print("saved chores")
        } catch {
            print("Couldn't save chores: \(error)")
        }
    }
    
    func loadFromPersistentStore() {
        do {
            guard let choreListUrl = choreListUrl else { return }
            
            let choresPlist = try Data(contentsOf: choreListUrl)
            let decoder = PropertyListDecoder()
            let decodedChores = try decoder.decode([Chore].self, from: choresPlist)
            self.chores = decodedChores
            
            print("recovered chores")
        } catch {
            print("Couldn't load chores: \(error)")
            getChores { (error) in
                if let error = error {
                    NSLog("Error: \(error)")
                }
            }
        }
    }
}
