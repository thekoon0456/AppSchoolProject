//
//  ContentView.swift
//  BlindDate
//
//  Created by 이학진 on 2022/12/13.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var authStore = AuthStores()
    @State private var isLoadingIndicator : Bool = false //인디케이터
    
    
    
    //로그인 된 이력이 있는지 확인
    @State private var isLogged : Bool = false
    //이메일 저장
    @AppStorage("email") var loggedinEmail : String = ""
    //패스워드 저장
    @AppStorage("password" ) var loggedinPassword : String = ""
    var logged = false
    var body: some View {
        ZStack {
            ZStack {
                if isLogged == true {
                    MainTabView()
                }
                else {
                    LoginView(isLoggedIn: $isLogged)
                }
            }
            if isLoadingIndicator {
                ZStack {
                    Color(.systemGray)
                        .opacity(0.6)
                        .ignoresSafeArea()
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .pink))
                        .scaleEffect(3)
                }
            }
        }
        .onAppear {
//            isLoadingIndicator = true
//            print(loggedinEmail, "로그인된 이메일")
//            print(loggedinPassword, "로그인된 패스워드")
//            if !loggedinEmail.isEmpty && !loggedinPassword.isEmpty {
//                authStore.login(email: loggedinEmail, password: loggedinPassword) { codeValue in
//                    switch codeValue {
//                    case 200:
//                        //성공
//                        isLoadingIndicator = false
//                        isLogged = true
//                        
//                    default:
//                        print("에러")
//                    }
//                }
//            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
