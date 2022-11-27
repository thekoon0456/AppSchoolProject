//
//  ContentView.swift
//  ReSwiftUIDemo
//
//  Created by Deokhun KIM on 2022/10/20.
//

import SwiftUI

struct ContentView: View {
    //색깔들
    var colors:[Color] = [.black, .red, .green, .blue]
    var colorNames:[String] = ["Black", "Red", "Green", "Blue"]
    
    //컬러네임 어떤 색 선택하려한건지 인덱스로 접근 //0,1,2,3
    @State private var colorIndex = 0
    //slider값 변환 받아올 변수 state
    @State private var rotation: Double = 0.0 //초기값 주면 슬라이더 바가 초기값만큼 진행되어 있음
    @State private var text: String = "Welcome to SwiftUI"
    var body: some View {
        VStack {
            Spacer()
            
            Text(text) //여기는 $안들어감, 바꾸는게 아니라 바꾼게 들어가서
                .font(.largeTitle) //폰트 사이즈
                .fontWeight(.heavy) //폰트 굵기
                .rotationEffect(.degrees(rotation)) //각도만큼 기울여준다 //바인딩 안되는 이유: rotation이란 값을 바꿀수도 있음. State걸려있는 rotaion을 바꿀 수 있음. 바뀌면 body를 다시 그리게 됨. 여기는 rotation을 반영할뿐이지 바꿀순 없음
                .animation(.easeInOut(duration: 5), value: rotation) //value: rotation값만큼 회전을 함.
            //그 위치까지 애니매이션으로 부드럽게 바뀜
            //duration은 얼마동안 애니메이션 할건지에 대한 간격 (초단위)
                .foregroundColor(colors[colorIndex])
                .lineLimit(1)
            
            Spacer()
            
            Divider()
            
            Slider(value: $rotation, in: 0...360, step: 0.1) //in: 로테이션 범위, step: 이동할때마다 늘어날 단위
            
            TextField("Enter text here", text: $text) //input받고 text가 바뀜. $로 바운딩, 선언 자체에 $쓰라도 되어있음
                .textFieldStyle(RoundedBorderTextFieldStyle()) //텍스트필드 모서리 둥글게
            
            Picker(selection: $colorIndex, label: Text("Color")) {
                //반복되니 반복문 foreach사용
                ForEach(0..<colorNames.count, id: \.self) {
                    Text(colorNames[$0])
                        .foregroundColor(colors[$0])
                }
            }
            .pickerStyle(.wheel)
            .padding()
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
