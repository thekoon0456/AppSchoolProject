//
//  CardDetailView.swift
//  BlindDate
//
//  Created by 이학진 on 2022/12/13.
//

import SwiftUI

struct CardDetailView: View {
    var user: User
    @State private var translation: CGSize = .zero
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading) {
                
                Image(user.image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: geometry.size.width, height: geometry.size.height * 0.75)
                    .clipped()
                    .overlay(alignment: .bottomLeading) {
                        HStack(alignment: .firstTextBaseline) {
                            Text(user.name)
                                .font(.largeTitle)
                            Text("\(user.age)")
                                .font(.title3)
                            Spacer()
                            
                            Button(action: {
                                // 프로필 상세 보기 버튼
                            }, label: {
                                Image(systemName: "info.circle")
                                    .font(.title3)
                            })
                            .padding(.trailing, 20)
                        }
                        .foregroundColor(.white)
                    }
                
                
                    .padding()
                
                HStack {
                    Spacer()
                    Button(action: {
                        // 좋아요 버튼
                    }, label: {
                        HStack {
                            Text("LIKE")
                                .font(.title3)
                            Image(systemName: "hand.thumbsup.fill")
                                .renderingMode(.original)
                                .font(.title3)
                        }
                        .padding()
                        .border(.red)
                    })
                    .foregroundColor(.red)
                    
                    Spacer()
                    
                    Button(action: {
                        // 싫어요 버튼
                    }, label: {
                        HStack {
                            Text("DISLIKE")
                                .lineLimit(1)
                                .font(.title3)
                            Image(systemName: "hand.thumbsdown.fill")
                                .renderingMode(.original)
                                .font(.title3)
                        }
                        .padding()
                        .border(.blue)
                        .foregroundColor(.blue)
                    })
                    
                    
                    Spacer()
                }
                .padding()
            }
            
        }
        .padding(.bottom)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

struct CardDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CardDetailView(user:  User(id: "abcdef456",
                                   name: "chaewon",
                                   email: "kooni@gmail.com",
                                   password: "123456",
                                   image: "chaewon",
                                   age: 21,
                                   location: "Seoul",
                                   introduce: "안녕 난 채원이야",
                                   timestamp: "2022-12-13"))
    }
}
