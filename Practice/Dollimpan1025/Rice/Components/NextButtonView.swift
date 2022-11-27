//
//  NextButtonView.swift
//  DollimPan
//
//  Created by Donghoon Bae on 2022/10/21.
//

import SwiftUI

struct NextButtonView: View {
//    @Binding var showingAlert : Bool
//    @Binding var names: [String]
    @State private var changingView : Bool = false
    var body: some View {

        HStack {
            Spacer()
            Text("나눠요")
            Spacer()
        }
        .font(.title2)
        .fontWeight(.semibold)
        .foregroundColor(Color.black)
        .frame(width: 300, height: 60)
        .overlay(RoundedRectangle(cornerRadius: 20)
            .stroke(Color.black, lineWidth: 4))
        .background(Color(red: 0.859, green: 0.784, blue: 0.675, opacity: 0.5))
        .cornerRadius(20)
        .padding()
//        .onTapGesture {
//            if names.count != 8 {
//                showingAlert = true
//            }
//        }
    }
}

//struct NextButtonView_Previews: PreviewProvider {
//    static var previews: some View {
//        NextButtonView(showingAlert: true, names: ["dd"])
////        말씀하신게 이렇게 맞나요??
//    }
//}
