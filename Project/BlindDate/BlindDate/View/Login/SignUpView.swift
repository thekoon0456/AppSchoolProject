//
//  SignUpView.swift
//  BlindDate
//
//  Created by 이학진 on 2022/12/13.
//

import SwiftUI
import PhotosUI
struct SignUpView: View {
    @State private var isLoadingIndicator : Bool = false //인디케이터
    @ObservedObject var authStore = AuthStores()
    enum Field: Hashable {
        case userEmail
        case userPassword
        case userAge
        case userLocation
        case userName
        case userIntroduce
    }
    @FocusState private var focusedField: Field?
    
    @Environment(\.dismiss) private var dismiss
    @State private var userEmail : String = ""
    @State private var userPassword : String = ""
    @State private var userAge : String = ""
    @State private var userLocation : String = ""
    @State private var userIntroduce : String = ""
    @State private var selctedItem : PhotosPickerItem? = nil
    @State private var selectedImageData : Data? = nil
    @State private var userName : String = ""
    
    
    @State private var alertMessage : String = ""
    @State private var showingAlert : Bool = false
    
    
    @State private var pickedImage : Image = Image(systemName: "").resizable()
    @State private var isPickedPresented : Bool = false
    
    var body: some View {
        ZStack {
            VStack {
                VStack {
                    HStack() {
                        Button {
                            dismiss()
                        } label: {
                            Text("뒤로가기")
                        }
                        .padding()
                        Spacer()
                        
                    }
                    .frame(height: 30)
                    Divider()
                }
                ScrollView {
                    HStack {
                        Text("아이디")
                        TextField("이메일을 입력해주세요", text: $userEmail)
                            .focused($focusedField, equals: .userEmail)
                    }
                    HStack {
                        Text("비밀번호")
                        TextField("비밀번호를 입력해주세요.", text: $userPassword)
                            .focused($focusedField, equals: .userPassword)
                    }
                    HStack {
                        Text("이름")
                        TextField("사용하실 이름을 설정해주세요.", text: $userName)
                            .focused($focusedField, equals: .userName)
                    }
                    HStack {
                        Text("지역")
                        TextField("사는 지역을 입력해주세요", text: $userLocation)
                            .focused($focusedField, equals: .userLocation)
                    }
                    HStack {
                        Text("나이")
                        TextField("나이를 입력해주세요.", text: $userAge)
                    }
                
                    Button {
                        self.isPickedPresented.toggle()
                    } label: {
                        ZStack {
                            Text("사진을 선택해주세요")
                            pickedImage
                                .resizable()
                                .scaledToFit()
                                .frame(width: 300, height: 300)
                        }
                        .frame(width: 300, height: 300)
                    }
                    .sheet(isPresented: $isPickedPresented) {
                        ImagePickerView(pickerImage: self.$pickedImage)
                    }
                    .overlay {
                        Rectangle().stroke(.black, lineWidth: 4)
                    }

                    TextField("본인을 소개해주세요", text: $userIntroduce, axis: .vertical)
                        .focused($focusedField, equals: .userIntroduce)
                }
                VStack {
                    if showingAlert {
                        Text(alertMessage)
                            .padding()
                            .background(Color.gray)
                    }
                    Button {
                        isLoadingIndicator = true
                        authStore.registerUser(userID: userEmail, userPassword: userPassword) { intValue,uidValue  in
                            switch intValue {
                            case 200: //회원가입 성공
                                print("성공")
                                isLoadingIndicator = false
                                let createdAt = authStore.dateFormatter.string(from: authStore.date)
                                let user : User = User(
                                    id: uidValue,
                                    name: userName,
                                    email: userEmail,
                                    password: userPassword,
                                    image: "",
                                    age: Int(userAge) ?? 0,
                                    location: userLocation,
                                    introduce: userIntroduce,
                                    timestamp: "\(createdAt)")
                                
                                authStore.addUser(user, UID: uidValue) { success in
                                    if success == true {
                                        dismiss()
                                        isLoadingIndicator = false
                                    }
                                    else {
                                        
                                    }
                                }
                            case 17007:
                                print("이미 가입한 계정")
                                showingAlert = true
                                isLoadingIndicator = false
                                alertMessage = "이미 가입한 계정입니다. "
                            case 17008:
                                print("맞지 않는 포맷")
                                showingAlert = true
                                isLoadingIndicator = false
                                alertMessage = "맞지 않은 이메일 형식입니다."
                            case 17026:
                                print("비밀번호를 6자리 이상 입력")
                                isLoadingIndicator = false
                                showingAlert = true
                                alertMessage = "비밀번호를 6자리 이상 입력해주세요."
                                
                            default:
                                print("오류")
                            }
                        }
                    } label: {
                        ZStack {
                            Rectangle()
                                .foregroundColor(.black)
                            Text("회원가입하기")
                                .foregroundColor(.white)
                        }.frame(height: 80)
                    }
                }
            }
            .padding()
            .ignoresSafeArea(edges: .bottom)
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
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}

