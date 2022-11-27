//
//  ContentView.swift
//  state1024
//
//  Created by Deokhun KIM on 2022/10/24.
//

import SwiftUI
import Combine

struct ContentView: View {
    //받을때는 ObservedObject!
    @ObservedObject var demoData: DemoData
    //모달 토글할 바인딩 변수
    @State var isModal: Bool = false
    
    //액션시트 바인딩 변수
    @State var isSheet: Bool = false
    
    var actionSheet: ActionSheet {
        ActionSheet(title: Text("액션시트"), message: Text("텍스트"))
    }
    
    
    var body: some View {
        NavigationView {
            VStack {
                Text("userCount: \(demoData.userCount)")
                    .padding()
                Text("currentUser: \(demoData.currentUser)")
                    .padding()
                
                Button {
                    demoData.updateData()
                } label: {
                    Text("Update date")
                }
                .padding()

                NavigationLink(destination: SecondView(demoData: DemoData())) {
                    Text("Push")
                        .padding()
                    


                    Button("모달보기~") {
                        //버튼 누르면 모달 토글
                        isModal.toggle()
                    }.sheet(isPresented: $isModal, content: {
                        //나올 뷰
                        modalView()
                    })
                }


                Button("Action Sheet") {
                    isSheet.toggle()
                }.actionSheet(isPresented: $isSheet, content: {
                    actionSheet
                })
                
            }
            .navigationTitle("Master")

        }
    }
}

struct modalView: View {
    var body: some View {
        Text("모달~")
    }
}

struct SecondView: View {
    
    @ObservedObject var demoData: DemoData
    
    @State private var texts = """
aaaaaa
aaaa
aaaaa
"""
    var colors: [Color] = [.red, .blue, .green]
    var colorsStr = ["red", "blue", "green"]
    @State private var colorIndex = 0
    
    var body: some View {
        NavigationView {
            VStack {
                Text("userCount: \(demoData.userCount)")
                    .padding()
                Text("currentUser: \(demoData.currentUser)")
                    .padding()
                
                Button {
                    demoData.updateData()
                } label: {
                    Text("Update date")
                }
                .padding()
                
                Label("안녕", systemImage: "hammer.fill")
//                TextEditor(text: $texts)
//                    .textFieldStyle(RoundedBorderTextFieldStyle())
//                    .padding()
                SecureField("비밀번호를 입력하세요", text: $texts)
                
                //사파리에서 열림
                Link("네이버로", destination: URL(string: "https://www.naver.com")!)
                
                Picker("색깔을 골라보세여", selection: $colorIndex) {
                    ForEach(0..<colorsStr.count, id: \.self) {
                        Text(colorsStr[$0]).tag($0)
                    }
                }.pickerStyle(.segmented)
                
                List {
                    Section(header: Text("UIKit"), footer: Text("We will miss you")) {
                        Text("UITableView")
                    }

                    Section(header: Text("SwiftUI"), footer: Text("A lot to learn")) {
                        Text("List")
                    }
                }.listStyle(InsetGroupedListStyle())
            }
            .navigationBarTitle(Text("Detail"))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(demoData: DemoData())
//            .environmentObject(DemoData())
    }
}
