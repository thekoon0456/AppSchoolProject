//
//  ChattingRoom.swift
//  BlindDate
//
//  Created by 이학진 on 2022/12/13.
//

import Foundation

// receiver1, senderid 이런거 대신 user1 id, user2 id이런식으로 해야할듯
/// user1 { id: name:} user2: {id: name}


struct ChattingRoom: Identifiable {
    var id: String //채팅방 id
    var usersId: [String] //참여한 유저들
    var timestamp: String
}

struct Message: Identifiable {
    var id: String //메세지 id
    var senderID: String // 보낸사람 id
    var content: String // 보내는 내용
    var timestamp: String
}

//보낸사람인지아닌지 구분하는 열거형
enum WhosMessage {
    case myMessage
    case otherMessage
}
