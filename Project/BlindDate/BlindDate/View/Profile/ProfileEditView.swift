//
//  ProfileEditView.swift
//  BlindDate
//
//  Created by 조현호 on 2022/12/13.
//

import SwiftUI

struct ProfileEditView: View {
    let user = users[0]
    
    @State private var name = ""
    @State private var age = ""
    @State private var location = ""
    @State private var introduce = ""
    @State private var isEdited: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                ProfileEditImage(imageName: user.image)
                Divider()
                
                VStack {
                    TextField("이름", text: $name)
                    Divider()
                    TextField("나이", text: $age)
                    Divider()
                    TextField("지역", text: $location)
                    Divider()
                    TextField("한줄소개", text: $introduce)
                    Divider()
                }.padding()
                
                Spacer()
                
                Button {
                    isEdited.toggle()
                } label: {
                    Text("수정완료")
                        .foregroundColor(.pink)
                }
            }
        }
    }
}

struct ProfileEditImage: View {
    var imageName: String
    
    var body: some View {
        VStack {
            Button {
                print("")
            } label: {
                Image(imageName)
                    .resizable()
                    .frame(width:200, height: 200)
                    .clipShape(Circle())
            }
        }
    }
}

struct ProfileImage: View {
    var imageName: String
    
    var body: some View {
        ZStack {
            Image(imageName)
                .resizable()
                .frame(width:300, height: 300)
                .clipShape(Circle())
        }
    }
}

struct ProfileEditView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileEditView()
    }
}
