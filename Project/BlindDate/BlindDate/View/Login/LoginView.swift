//
//  LoginView.swift
//  BlindDate
//
//  Created by 이학진 on 2022/12/13.
//

import SwiftUI

struct LoginView: View {
    @State private var showingAlert : Bool = false
    @State private var alertMessage : String = ""
    @Binding var isLoggedIn : Bool
    @State private var isLoadingIndicator : Bool = false //인디케이터
    @ObservedObject var authStore = AuthStores()
    @AppStorage("email") var loggedinEmail : String = ""
    //패스워드 저장
    @AppStorage("password") var loggedinPassword : String = ""
    
    @State private var userId = ""
    @State private var password = ""
    @State private var alertText = ""
    @State private var signUpIsPresented : Bool = false

    
    var body: some View {
        ZStack {
            VStack(alignment: .center) {
                HStack {
                    Text("아이디")
                        .padding()
                    TextField("아이디를 입력하세요.", text: $userId)
                        .textInputAutocapitalization(.never)
                }
                HStack {
                    Text("비밀번호")
                        .padding()
                    TextField("비밀번호를 입력하세요.", text: $password)
                }
                Text("\(alertText)")

                Button {
                    self.signUpIsPresented.toggle()
                } label: {
                    Text("회원가입")
                }
                .fullScreenCover(isPresented: $signUpIsPresented) {
                    SignUpView()
                }

                Button {
                    isLoadingIndicator = true
                    authStore.login(email: userId, password: password) { codeValue in
                        switch codeValue {
                        case 200:
                            //성공
                            loggedinEmail = userId
                            loggedinPassword = password
                            isLoadingIndicator = false
                            isLoggedIn = true
                        case 17008: //파베 제공 에러코드
                            showingAlert = true
                            alertMessage = "이메일 형식이 아닙니다."
                            isLoadingIndicator = false
                        case 17009: //파베 제공 에러코드
                            showingAlert = true
                            alertMessage = "비밀번호가 다릅니다."
                            isLoadingIndicator = false
                        default:
                            print("고려하지 못한 에러")
                            isLoadingIndicator = false
                            alertMessage = "고려하지 못한 에러입니다~~"
                        }
                    }
                    
                } label: {
                    ZStack {
                        
                        Rectangle()
                            .frame(width: 300, height: 70)
                            .foregroundColor(.black)
                        Text("로그인")
                            .foregroundColor(.white)
                    }
                }
                if showingAlert {
                    Text(alertMessage)
                        .padding()
                        .background(Color.gray)
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
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(isLoggedIn: .constant(false))
        
    }
}
