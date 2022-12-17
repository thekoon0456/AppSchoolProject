//
//  CardView.swift
//  BlindDate
//
//  Created by 이학진 on 2022/12/13.
//

import SwiftUI

struct CardView: View {
    let tmpUsers = users
    
    var body: some View {
        //
        GeometryReader { geometry in
            
            ScrollView(.horizontal) {
                VStack {
                    Spacer()
                    HStack(spacing: 16) {
                        ForEach(Array(tmpUsers.enumerated()), id: \.offset) { index, item in
                            CardDetailView(user: item)
                                .frame(width: geometry.size.width * 0.85, height: geometry.size.height * 0.9)
                            
                        }
                    }
                    Spacer()
                }
            }
            .scrollIndicators(.hidden)
        }
        .navigationTitle("오늘의 설레는 만남")
        .navigationBarTitleDisplayMode(.inline)
        .padding()
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView()
    }
}

