//
//  ChattingListView.swift
//  BlindDate
//
//  Created by 이학진 on 2022/12/13.
//

// 유저가 로그인한다.
// 유저가 가지고있는 채팅룸 ID로 채팅방들을 보여준다
// 채팅방안에 있는 메시지는 모두 보여진다.
// 메시지의 보내는사람 아이디가 현재 유저의 id가 같다면 내 메시지 다르다면 상대방 메시지
// 이 구분을 열거형으로 하면 좋을듯 ex) case mymessage, case othermessage

import SwiftUI

struct ChattingListView: View {
    @StateObject var roomsStores = ChattingRoomsStores()
    
    var body: some View {
        NavigationStack {
            List(roomsStores.rooms) { room in
                NavigationLink {
                    ChattingDetailView(room: room)
                } label: {
                    HStack {
                        Image("1") //TODO: 이미지 파이어베이스 스토리지 연동
                            .resizable()
                            .clipShape(Circle())
                            .cornerRadius(10.0)
                            .frame(width: 60, height: 60)
                            .padding(.trailing, 5)
                            .padding(.leading, -20)
                        VStack(alignment: .leading) {
                            Text(room.usersId.count == 2 ? "학진" : "그룹채팅")
                                .font(.headline)
                                .padding(.vertical, 3)
//                            Text("\(str.chat.last?.content ?? "")")
//                                .font(.subheadline)
//                                .foregroundColor(.gray)
                        }
                    }
                }
            }
            .navigationTitle("채팅")
            .scrollContentBackground(.hidden)
        }
        .onAppear {
            print("ChattingListView Appear")
            roomsStores.startRoomsListener()
        }
        .onDisappear {
            print("ChattingListView DisAppear")
            roomsStores.detachRoomsListener()
        }
    }
}


struct ChattingListView_Previews: PreviewProvider {
    static var previews: some View {
        ChattingListView()
    }
}
