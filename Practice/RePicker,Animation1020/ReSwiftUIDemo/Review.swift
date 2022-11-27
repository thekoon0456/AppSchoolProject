//
//  Review.swift
//  ReSwiftUIDemo
//
//  Created by Deokhun KIM on 2022/11/27.
//

import SwiftUI

struct Review: View {
    //Slider값 조정 변수
    @State private var lotation: Double = 0
    //TextField 들어올 변수
    @State private var text = ""
    //Picker컬러 선택할 변수
    @State private var color = ".red"
    //사용할 컬러 담은 배열
    @State private var colors: [Color] = [.red, .green, .blue, .yellow, .purple]
    var pickerColors = ["red", "green", "blue", "yellow", "purple"]
    @State private var colorIndex = 0
    
    @State private var date = Date()
    
    var body: some View {
        VStack {
            HStack {
                Text(text)
                Image(systemName: "hammer.fill")
            }
            .font(.largeTitle)
            .bold()
            .rotationEffect(.degrees(lotation))
            .animation(.easeInOut(duration: 2))
            .foregroundColor(colors[colorIndex])
            .padding()
            TextField("안녕", text: $text)
                .textFieldStyle(.roundedBorder)
            Slider(value: $lotation, in: 0...360, step: 0.1)
            
            Picker("컬러 선택", selection: $colorIndex) {
                ForEach(0..<colors.count, id: \.self) {
                    Text("\(pickerColors[$0])")
                        .foregroundColor(colors[$0])
                }
            }                        .pickerStyle(.wheel)
            
            DatePicker("날짜를 선택하세요", selection: $date, displayedComponents: [.date])
                .padding()
        }
    }
}

struct Review_Previews: PreviewProvider {
    static var previews: some View {
        Review()
    }
}
