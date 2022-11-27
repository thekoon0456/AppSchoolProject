//
//  ContentView.swift
//  DollimPan
//
//  Created by 류창휘 on 2022/10/24.
//

import SwiftUI

struct ContentView2: View {
    @State private var clickedButton = false
    @State private var showingSuccessAlert = false
    @State private var showingAlert = false
    @State private var numberOfPeople: Int = 2
    @State private var currentCount: Int = 2
    @State private var namesOfP: String = ""
    @EnvironmentObject var namesClass: BindingClass
    @FocusState private var keyboardOn: Bool
    
    
    var body: some View {
        VStack {
            AppTitleView()
            Text("김치전을 몇조각으로 나눌까요?")
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
                    .disabled(clickedButton ? true : false)
                    Text("조각")
                        .opacity(clickedButton ? 0.3 : 1)
                }
                .frame(height: 150)
                Button{
                    currentCount = numberOfPeople
                    namesClass.names = []
                    namesOfP = ""
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
            
            NavigationLink(destination: RoulletView2(), isActive: $showingAlert) {
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

struct ContentView2_Previews: PreviewProvider {
    static var previews: some View {
        ContentView2().environmentObject(BindingClass())
    }
}
