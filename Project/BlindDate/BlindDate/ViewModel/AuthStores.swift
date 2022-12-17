//
//  AuthViewModel.swift
//  BlindDate
//
//  Created by 이학진 on 2022/12/13.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore

class AuthStores : ObservableObject {
    @Published var users : [User] = []
    
    let database = Firestore.firestore()
    
    var user: User? // 로그인을 한 유저에 관한 정보 프로퍼티
    static var userID: String?
    static var userRoomsID: [String]?
    
    let date = Date()
    var dateFormatter : DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        return dateFormatter
    }()
//    func signIn() async {
//            do {
//                let authResult = try await Auth.auth().signIn(withEmail: email, password: password)
//                // self.user = authResult.user
//                print("로그인 성공")
//                print("로그인한 유저 이메일: \(String(describing: self.user?.email)), uid: \(String(describing: self.user?.uid))")
//                loginStatus = .logined
//
//                await self.findUserName()
//            }
//            catch {
//                print("Sign In Error : \(error)")
//            }
//        }
    func login(email: String, password: String, completion : @escaping (Int) -> ()) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard let self = self else { return }
            
            if let error = error {
                let code = (error as NSError).code
                print(code)
                print(error.localizedDescription)
                completion(code)
            }
            else {
                //성공
                Task {
                    
                    await self.setLoginUserInfo(uid: (authResult?.user.uid)!)
                }
                completion(200)
            }
        }
    }
    
    func setLoginUserInfo(uid: String) async {
        print("로그인한 유저의 uid: \(uid)")
        // AuthStores.userID = uid
        //var ref = Firestore.firestore().collection("user").whereField("id", isEqualTo: uid)
        let document = Firestore.firestore().collection("users").document(uid)
        
        do {
            let querySnapShot = try await document.getDocument()
            if let userdata = querySnapShot.data() {
                print("user의 사는곳: \(userdata["location"] as? String ?? "")")
                let user = User(id: uid,
                                name: userdata["name"] as? String ?? "",
                                email: userdata["email"] as? String ?? "",
                                password: userdata["password"] as? String ?? "",
                                image: userdata["image"] as? String ?? "",
                                age: userdata["age"] as? Int ?? 0,
                                location: userdata["location"] as? String ?? "",
                                introduce: userdata["introduce"] as? String ?? "",
                                timestamp: userdata["timestamp"] as? String ?? "")
                self.user = user
                
                UserSetting.usersID = user.id
                UserSetting.roomsID = userdata["roomsID"] as? [String] ?? []
                UserSetting.userName = userdata["name"] as? String ?? ""
            }
            
        } catch {
            print("로그인한 유저정보 가져오기 에러: \(error)")
        }
    }
 
    
    func registerUser(userID: String, userPassword: String, completiopn: @escaping (Int, String) -> ()) {
        Auth.auth().createUser(withEmail: userID, password: userPassword) { result, error in
            if let error {
                let code = (error as NSError).code
                print("Error \(error.localizedDescription)")
                print(code)
                completiopn(code, "")
            }
            else {
                let uid = result?.user.uid
                completiopn(200, uid ?? "") //성공 번호
            }
        }
    }
    func addUser(_ users: User, UID : String, completion : @escaping (Bool) -> ()) {
        database.collection("users")
            .document(users.id)
            .setData([
                "id" : users.id,
                "name" : users.name,
                "email" : users.email,
                "password" : users.password,
                "image" : users.image,
                "age" : users.age,
                "location" : users.location,
                "introduce" : users.introduce,
                "timestamp" : users.timestamp,
                "roomsID" : []
            ]) { error in
                if let error = error {
                    print("Error\(error)")
                    completion(false)
                }
                else {
                    print("Success")
                    completion(true)
                }
            }
    }
}
