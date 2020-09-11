//
//  ChoreController.swift
//  ChoreTracker
//
//  Created by Ahava Morse on 8/10/20.
//  Copyright © 2020 Ahava Morse. All rights reserved.
//

import Foundation

class ChoreController {
    
    var chores: [Chore] = []
    let baseURL: URL = URL(string: "https://choretracker-c5d22.firebaseio.com/")!
    
    func completeChore(chore: Chore) -> Chore {
        if let choreIndex = chores.firstIndex(of: chore) {
            let user = chore.nextUser
            chores[choreIndex].users.remove(at: 0)
            chores[choreIndex].users.append(user)
            
            return chores[choreIndex]
        } else {
            return chore
        }
    }
    
    func skipUser(chore: Chore) -> Chore {
        // Can be upgraded later to allow catch up
        if let choreIndex = chores.firstIndex(of: chore) {
            let user = chore.nextUser
            chores[choreIndex].users.remove(at: 0)
            chores[choreIndex].users.append(user)
            
            return chores[choreIndex]
        } else {
            return chore
        }
    }
    
    func addChore(newChore: Chore) {
        chores.append(newChore)
    }
    
    func editChore(from oldChore: Chore, into newChore: Chore) {
        
        if let choreIndex = chores.firstIndex(of: oldChore) {
            chores.remove(at: choreIndex)
            chores.insert(newChore, at: choreIndex)
        }
    }
    
    func deleteChore(chore: Chore) {
        if let index = chores.firstIndex(of: chore) {
            chores.remove(at: index)
        }
    }
    
    func getChores(completion: @escaping (Error?) -> ()) {
        let getChoresUrl = baseURL.appendingPathComponent("chores").appendingPathExtension("json")
        
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
    
    func put(chore: Chore) {
        let addChoreUrl = baseURL.appendingPathComponent("chores").appendingPathExtension("json")
        
        var request = URLRequest(url: addChoreUrl)
        
        request.httpMethod = "POST"
        
        let jsonEncoder = JSONEncoder()
        do {
            let jsonData = try jsonEncoder.encode(chore)
            request.httpBody = jsonData
        } catch {
            NSLog("Error encoding album object: \(error)")
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
    
}
