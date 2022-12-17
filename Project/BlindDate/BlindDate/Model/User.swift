//
//  User.swift
//  BlindDate
//
//  Created by 이학진 on 2022/12/13.
//

import Foundation

// 유저 구조체 안에
// 좋아요 한 사람
// 패스 한 사람
// 나를 좋아요 한 사람
// 나를 패스 한 사람

// - 변화를 관찰하기 위해서

class UserSetting {
    static var usersID: String = ""
    static var roomsID: [String] = []
    static var userName: String = ""
}

// Enviorment로 사용하기
//class UserSetting: ObservableObject {
//    @Published var currentUser: User
//
//    init(currentUser: User) {
//        self.currentUser = currentUser
//    }
//
//    func setUser(user: User) {
//        currentUser = user
//    }
//}

struct User: Codable, Identifiable {
    var id: String
    var name: String
    var email: String
    var password: String
    var image: String
    var age: Int
    var location: String
    var introduce: String
    var timestamp: String
    var roomsID: [String] = [] // [1,2,3]
    
    
    //    var rooms: [ChattingRoom] {
    //
    //    }
    
}

var users = [User(id: "abcdef123",
                  name: "훈이",
                  email: "hagjini0@gmail.com",
                  password: "123456",
                  image: "m1",
                  age: 26,
                  location: "changwon",
                  introduce: "hi",
                  timestamp: "2022-12-13"),
             User(id: "abcdef456",
                  name: "kooni",
                  email: "kooni@gmail.com",
                  password: "123456",
                  image: "1",
                  age: 21,
                  location: "Seoul",
                  introduce: "By",
                  timestamp: "2022-12-13")
]


