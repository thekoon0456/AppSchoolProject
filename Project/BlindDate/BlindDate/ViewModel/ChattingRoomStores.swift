//
//  ChattingRoomStores.swift
//  BlindDate
//
//  Created by 이학진 on 2022/12/14.
//

import Foundation
import FirebaseCore
import FirebaseFirestore

// MARK: - 채팅룸을 가지고 있는 스토어
/// 한명의 유저는 여러개의 채팅방을 가지고 있다.
/// 유저의 roomsID 프로퍼티에 담긴 documentID들을 가져온다.
/// Query
class ChattingRoomsStores: ObservableObject {
    @Published var rooms: [ChattingRoom] = []
    
    private lazy var db: CollectionReference? = {
        let ref = Firestore.firestore().collection("ChattingRoom")
        return ref
    }()
    
    private var listener: ListenerRegistration?
    
    // MARK: - ChattingRoom 컬렉션의 document들이 변경되면 호출
    // document안에 값이 변경되도 호출 ex) document의 id가 변경되도 수신 함
    // 그러나 안에 존재하는 컬렉션이 변경되면 호출은 안됨
    func startRoomsListener() {
        print("USersetting.roomsID: \(UserSetting.roomsID)")
        self.listener = db?.whereField("id", in: UserSetting.roomsID).addSnapshotListener { querySnapshot, error in
            print("룸 리스너 호출")
            
            guard let documents = querySnapshot?.documents else {
                print("Error fetching documents: \(error!)")
                return
            }
            
            querySnapshot?.documentChanges.forEach { diff in
                if (diff.type == .added) {
                    // rooms add
                    self.addRoom(room: diff.document.data())
                    print(diff.document.data())
                }
                if (diff.type == .modified) {
                    // rooms update
                }
                if (diff.type == .removed) {
                    // rooms removed
                }
            }
        }
    }
    
    func addRoomInFireStore(SID: String, RID: String) { // - 2
        let id = UUID().uuidString
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_kr")
        dateFormatter.timeZone = TimeZone(abbreviation: "KST")
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm" // "yyyy-MM-dd HH:mm:ss"
        
        let dateCreatedAt = Date(timeIntervalSince1970: Date().timeIntervalSince1970)
        let date = dateFormatter.string(from: dateCreatedAt)
        
        db?.document(id)
            .setData([
                "id": id,
                "usersId" : [],//FIXME: 수정필요
                "timestamp": date
            ])
    }
    
    func addRoom(room: [String:Any]) {
        let id: String = room["id"] as? String ?? ""
        let usersId: [String] = room["usersId"] as? [String] ?? []
        let timestamp: String = room["timestamp"] as? String ?? ""
        
        let room = ChattingRoom(id: id, usersId: usersId, timestamp: timestamp)
        print("추가로 생성된 방: \(room)")
        
        self.rooms.append(room)
    }
    
    func deleteRoom() {
        
    }
    
    func detachRoomsListener() {
        self.listener?.remove()
        self.rooms.removeAll()
    }
}


