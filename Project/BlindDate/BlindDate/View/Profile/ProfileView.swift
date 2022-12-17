//
//  ProfileView.swift
//  BlindDate
//
//  Created by 이학진 on 2022/12/13.
//

import SwiftUI

struct ProfileView: View {
    let user = users[0]
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Text("프로필")
                        .font(.largeTitle)
                        .padding(.leading)
                        .bold()
                    Spacer()
                    NavigationLink(destination: ProfileEditView()) {
                        Text("수정")
                            .font(.title2)
                            .foregroundColor(.pink)
                            .padding(.trailing)
                    }
                }
                ProfileImage(imageName: user.image)
                
                VStack(alignment: .leading){
                    Divider()
                    Text("이름 : \(user.name)")
                    Divider()
                    Text("나이 : \(user.age)")
                    Divider()
                    Text("지역 : \(user.location)")
                    Divider()
                    Text("한줄소개 : \(user.introduce)")
                    Divider()
                }.padding()
                
//                NavigationLink(destination: LoginView()) {
//                    Text("로그아웃")
//                        .frame(width: 200,height: 60)
//                        .fontWeight(.regular)
//                        .foregroundColor(.black)
//                        .background(.pink)
//                        .cornerRadius(15)
//                }.navigationBarBackButtonHidden(true)
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
