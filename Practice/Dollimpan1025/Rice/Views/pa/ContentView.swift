
//
//  ContentView.swift
//  DollimPan
//
//  Created by Donghoon Bae on 2022/10/21.
//

import SwiftUI



struct ContentView: View {
    //BindingClass과 연동
    @EnvironmentObject var namesClass: BindingClass
    
    @State private var showingSuccessAlert = true
    
    //네비게이션뷰로 넘어감
    @State private var showingAlert = false
    
    //피커 선택 사람수. 초기값2
    @State private var numberOfPeople: Int = 2
    //피커 선택하고 버튼 클릭하면 disable되도록
    @State private var clickedButton = false
    
    //피커에서 선택된 수, 초기값2
    @State private var currentCount: Int = 2
    
    //TextField에 입력된 사람 이름
    @State private var namesOfP: String = ""

    @FocusState private var keyboardOn: Bool
    
    
    var body: some View {
        VStack {
            AppTitleView()
            Text("파전을 몇조각으로 나눌까요?")
                .font(.title2)
                .padding()
            
            VStack {
                HStack {
                    Picker(selection: $numberOfPeople, label: Text("명수")) {
                        ForEach(2...8, id: \.self) { man in
                            Text("\(man)")
                        }
                    }
                    .pickerStyle(.wheel)
                    .opacity(clickedButton ? 0.3 : 1)
                    //clickedButton이 true면 disabled되도록
                    .disabled(clickedButton ? true : false)
                    Text("조각")
                        .opacity(clickedButton ? 0.3 : 1)
                }
                .frame(height: 150)
                Button{
                    //피커에 선택된 수만큼 currentCount에 할당
                    currentCount = numberOfPeople
                    
                    //?
                    namesClass.names = []
                    namesOfP = ""
                    //버튼 누르면 clickedButton true로 바꾸도록
                    clickedButton = true
                } label: {
                    Text("확인")
                }
                .disabled(clickedButton ? true : false)
                .padding()
                
            }
            Divider()
            HStack {
                ForEach(namesClass.names, id: \.self) { name in
                    Text("\(name)")
                }
            }
            .padding()
            
            HStack {
                TextField("이름을 입력하세요.", text: $namesOfP)
                    .textFieldStyle(.roundedBorder)
                    .focused($keyboardOn)
                Button{
                    if namesClass.names.count <= currentCount - 1 {
                        namesClass.names.append(namesOfP)
                    } else {
                        keyboardOn = false
                    }
                    
                    print(namesClass.names)
                    namesOfP = ""
                }
            label: {
                Text("입력")
            }
            .focused($keyboardOn)
                
            }
            .opacity(clickedButton ? 1 : 0.3)
            .disabled(clickedButton ? false : true)
            
            Spacer()
            
            NavigationLink(destination: RoulletView(), isActive: $showingAlert) {
                NextButtonView()
            }
            .alert(isPresented: namesClass.names.count == currentCount ? $showingSuccessAlert : $showingAlert) {
                Alert(title: Text("⚠️ Caution"),
                      message: Text("인원 수 만큼 이름을 채워주세요.😢"),
                      dismissButton: .default(Text("Close")))
            }
        }
        .padding()
        .background(Image("backgroun_img"))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(BindingClass())
    }
}

