//
//  ChattingBubbleView.swift
//  BlindDate
//
//  Created by Deokhun KIM on 2022/12/13.
//

import SwiftUI


struct ChattingBubbleView: View {
    // var chattingRoom = chattingRooms
    var message: Message
    var messageSender: WhosMessage
    var name: String
    
    var body: some View {
        VStack {
            switch messageSender {
            case .myMessage:
                HStack {
                    Spacer()
                    VStack(alignment: .trailing) {
                        Text(name)
                            .font(.footnote)
                            .foregroundColor(.gray)
                        //                        Text("\(message.last?.content ?? "")")
                        Text(message.content)
                            .foregroundColor(.black)
                            .font(.subheadline)
                            .padding(10)
                            .background(RoundedRectangle(cornerRadius: 10))
                            .foregroundColor(.accentColor)
                        
                        Text(message.timestamp)
                            .foregroundColor(.black)
                    }
                    Image("m1")
                        .resizable()
                        .clipShape(Circle())
                        .cornerRadius(10.0)
                        .frame(width: 50, height: 50)
                }
            case .otherMessage:
                HStack {
                    Image("m1")
                        .resizable()
                        .clipShape(Circle())
                        .cornerRadius(10.0)
                        .frame(width: 50, height: 50)
                    VStack(alignment: .leading) {
                        Text(name)
                            .font(.footnote)
                            .foregroundColor(.gray)
                        //Text("\(message.last?.content ?? "")")
                        Text(message.content)
                            .foregroundColor(.black)
                            .font(.subheadline)
                            .padding(8)
                            .background(RoundedRectangle(cornerRadius: 10))
                            .foregroundColor(Color(.systemGray5))
                        Text(message.timestamp)
                            .foregroundColor(.black)
                    }
                    Spacer()
                }
            }
        }
    }
}

struct ChattingBubbleView_Previews: PreviewProvider {
    static var previews: some View {
        ChattingBubbleView(message: Message(id: "111111", senderID: "111111", content: "안녕", timestamp: "12:50"), messageSender: .myMessage, name: "덕훈" )
    }
}
