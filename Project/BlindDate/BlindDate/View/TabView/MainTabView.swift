//
//  TabView.swift
//  BlindDate
//
//  Created by 이학진 on 2022/12/13.
//

import SwiftUI

struct MainTabView: View {
    @State private var selection: Int = 1
    
    var body: some View {
        TabView(selection: $selection) {
            NavigationStack {
                HomeView()
                    //.environmentObject(user)
            }.tabItem {
                Image(systemName: "house.fill")
                Text("홈")
            }.tag(1)
            
            NavigationStack {
                ChattingListView()
                //ChattingDetailView(roomID: "jdoRzWCKfnQaNwEJ4coY")
            }.tabItem {
                Image(systemName: "ellipsis.message")
                Text("채팅")
            }.tag(2)
            
            NavigationStack {
                ProfileView()
            }.tabItem {
                Image(systemName: "person.circle")
                Text("프로필")
            }.tag(3)
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var user = User(id: "abcdef123",
                           name: "훈이",
                           email: "hagjini0@gmail.com",
                           password: "123456",
                           image: "m1",
                           age: 26,
                           location: "changwon",
                           introduce: "hi",
                           timestamp: "2022-12-13")
    static var previews: some View {
        MainTabView()
    }
}
