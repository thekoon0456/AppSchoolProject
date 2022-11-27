//
//  RoulletButton3.swift
//  DollimPan
//
//  Created by 류창휘 on 2022/10/24.
//

import SwiftUI

struct RoulletButton3: View {
    
    var body: some View {
        HStack {
            Spacer()
            Text("최근 결과들 보러가기")
            Spacer()
            Text("        click").multilineTextAlignment(.trailing)
                .foregroundColor(.white)
                .italic()
                .underline()
                .shadow(radius: 10)
            Spacer()
        }
        .font(.title2)
        .fontWeight(.semibold)
        .foregroundColor(Color.black)
        .frame(width: 350, height: 65)
        .overlay(RoundedRectangle(cornerRadius: 20)
            .stroke(Color.black, lineWidth: 4))
        .background(Color(red: 0.859, green: 0.784, blue: 0.675, opacity: 0.5))
        .cornerRadius(20)
        .padding()
    }
}

struct RoulletButton3_Previews: PreviewProvider {
    static var previews: some View {
        RoulletButton3()
    }
}
