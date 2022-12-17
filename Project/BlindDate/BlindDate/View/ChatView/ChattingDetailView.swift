//
//  ChattingDetailView.swift
//  BlindDate
//
//  Created by Deokhun KIM on 2022/12/13.
//

import SwiftUI

struct ChattingDetailView: View {
    @StateObject var messageStores = MessageStores()
    var userStores = UsersStore()
    
    @State private var namesDict: [String:String] = [:]
    @State private var text = ""
    
    var room: ChattingRoom
    
    var body: some View {
        VStack {
            ScrollViewReader { proxy in
                ScrollView {
                    ForEach(messageStores.messages) { message in
                        if message.senderID == UserSetting.usersID { // 보내는 사람
                            ChattingBubbleView(message: message, messageSender: .myMessage, name: UserSetting.userName)
                                .id(message.id)
                        }
                        else {
                            ChattingBubbleView(message: message, messageSender: .otherMessage, name: namesDict[message.senderID] ?? "Unkown")
                                .id(message.id)
                        }
                    }
                    .scrollContentBackground(.hidden)
                    
                    Spacer()
                }
                .onAppear {
                    proxy.scrollTo(messageStores.messages.last?.id)
                }
                
                .onChange(of: messageStores.messages.count) { _ in
                    proxy.scrollTo(messageStores.messages.last?.id)
                    
                }
                
                HStack {
                    Spacer()
                    TextField("채팅을 입력해주세요", text: $text)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: 280, height: 80, alignment: .trailing)
                    
                    Spacer()
                    Button {
                        guard !text.isEmpty else {return }
                        messageStores.addMessageInFireStore(SID: UserSetting.usersID, content: text)
                        text = ""
                        //proxy.scrollTo(messageStores.messages.last?.id)
                    } label: {
                        Image(systemName: "paperplane.fill") .foregroundColor(.accentColor)
                    }
                    Spacer()
                }
                
                .navigationTitle(room.usersId.count == 2 ? "학진" : "그룹채팅") //TODO: 채팅방 이름 넣어주는 함수 만들기
                .navigationBarTitleDisplayMode(.inline)
            }
            .onAppear {
                print("OnAppear 호출")
                Task {
                    messageStores.roomsID = room.id
                    namesDict = await userStores.userNames(id: room.usersId)
                    messageStores.startMessageListener()
                }
                
            }
            .onDisappear {
                messageStores.detachMessageListener()
            }
        }
    }
}

struct ChattingDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ChattingDetailView(room: ChattingRoom(id: "111111", usersId: [], timestamp: "12:30"))
    }
}
