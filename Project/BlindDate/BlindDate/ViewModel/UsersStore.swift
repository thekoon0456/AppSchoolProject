//
//  UsersStore.swift
//  BlindDate
//
//  Created by Deokhun KIM on 2022/12/16.
//

import Foundation
import FirebaseCore
import FirebaseFirestore

class UsersStore {
    private lazy var db: CollectionReference? = {
        let ref = Firestore.firestore().collection("users")
        return ref
    }()
    
    func userNames(id: [String]) async -> [String:String] {
        var namesDict: [String:String] = [:] //[id : 유저 이름]
        do {
            let querySnapshot = try await db?.whereField("id", in: id).getDocuments()
            guard let documents = querySnapshot?.documents else {
                return [:]
            }
            for document in documents {
                let data = document.data()
                let userName = data["name"] as? String ?? ""
                namesDict[document.documentID] = userName
                print(namesDict)
            }
            
        } catch {
            print("get users name in ChattingRoom Error: \(error)")
        }
        return namesDict
    }
}
