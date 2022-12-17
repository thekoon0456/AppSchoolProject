//
//  MessageStores.swift
//  BlindDate
//
//  Created by 이학진 on 2022/12/14.
//

import Foundation
import FirebaseCore
import FirebaseFirestore

/// 1. 사용자가 메시지를 보낸다.
/// 2. 보낸 메시지를 파이어스토어에 저장한다.
/// 3. 파이어스토어에 저장되면 리스너가 호출된다.
/// 4. 리스너에서 Published하는 messages 배열에 추가된 메시지를 삽입한다.
/// 5. publsihed가 변경되었으므로, 채팅방에 메시지가 보이게 된다.

class MessageStores: ObservableObject {
    var roomsID: String = ""
    @Published var messages: [Message] = []
    
    private lazy var db: CollectionReference? = {
        let ref = Firestore.firestore().collection("ChattingRoom").document(roomsID).collection("message")
        return ref
    }()
    
    private var listener: ListenerRegistration?
    
    func startMessageListener() { // - 3
        self.listener = db?.order(by: "timestamp").addSnapshotListener { querySnapshot, error in
            print("메시지 리스너 호출")
            guard let documents = querySnapshot?.documents else {
                print("Error fetching documents: \(error!)")
                return
            }
            
            querySnapshot?.documentChanges.forEach { diff in
                if (diff.type == .added) {
                    // message add
                    self.addMessage(msg: diff.document.data())
                    print("New Message: \(diff.document.data())")
                }
                if (diff.type == .modified) {
                    print("Modified Message: \(diff.document.data())")
                }
                if (diff.type == .removed) {
                    print("Removed Message: \(diff.document.data())")
                }
            }
        }
    }
    
    func addMessageInFireStore(SID: String, content: String) { // - 2
        let id = UUID().uuidString
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_kr")
        dateFormatter.timeZone = TimeZone(abbreviation: "KST")
        dateFormatter.dateFormat = "HH:mm" // "yyyy-MM-dd HH:mm:ss"
        
        let dateCreatedAt = Date(timeIntervalSince1970: Date().timeIntervalSince1970)
        let date = dateFormatter.string(from: dateCreatedAt)
        
        db?.document(id)
            .setData([
                "id": id,
                "senderID": SID,
                "content": content,
                "timestamp": date
            ])
    }
    
    

    func addMessage(msg: [String:Any]) { // - 4
        print("ADD message 호출")
        let id: String = msg["id"] as? String ?? ""
        let senderID: String = msg["senderID"] as? String ?? ""
        let content: String = msg["content"] as? String ?? ""
        let timestamp: String = msg["timestamp"] as? String ?? ""
        
        let message = Message(id: id, senderID: senderID, content: content, timestamp: timestamp)
        print("추가된 메시지: \(message)")
        
        self.messages.append(message) // 채팅방에서 보여주는 순서를 시간등으로 정렬해야 할듯
    }
    
    func updateMessage(msg: [String:Any]) {
        // TODO: Update 수행
    }
    func deleteMessage(msg: [String:Any]) {
        // TODO: 삭제 수행
    }
    
    func detachMessageListener() {
        // self.listener?.remove()
        // self.messages.removeAll()
    }
}
