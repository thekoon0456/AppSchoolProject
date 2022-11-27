//
//  ContentView.swift
//  ListDemo1025
//
//  Created by Deokhun KIM on 2022/10/25.
//

import SwiftUI

struct ToDoItem: Identifiable { //리스트 따르는 프로토콜
    var id = UUID() //id값 필수, id UUID()자동적으로 생성하도록, 일시적으로 유니크한 일련번호 만들어서 사용
    var task: String
    var imageName: String
}

var listData: [ToDoItem] = [
    ToDoItem(task: "Wash the car", imageName: "car.fill"),
    ToDoItem(task: "Vacum house", imageName: "house.fill"),
    ToDoItem(task: "Pick up kids from school bus @ 3pm", imageName: "bus.doubledecker"),
    ToDoItem(task: "Auction the kods on ebay", imageName: "cart.fill"),
    ToDoItem(task: "Order Pizza for dinner", imageName: "fork.knife")
]


struct ContentView: View {
    //토클 온오프 변수, 초기값 true로 켜져있음
    @State private var toggleStatus = true
    
    var body: some View {
        NavigationView {
            List {
                //섹션 나누기
                Section(header: Text("Settings")) {
                    Toggle(isOn: $toggleStatus) {
                        Text("Allow Notification")
                    }
                }
                
                Section(header: Text("To Do Tasks")) {
                    ForEach(listData) { item in
                        NavigationLink(destination: Text(item.task)) {
                            HStack {
                                Image(systemName: item.imageName)
                                Text(item.task)
                            }
                        }
                    }
                    //리스트 삭제 메소드
                    .onDelete(perform: deleteItem)
                    //리스트 옮기는 메소드
                    .onMove(perform: moveItem)
                }
            }
            .listStyle(.plain)
            .navigationTitle(Text("To Do List"))
            .navigationBarItems(trailing: EditButton())
        }
    }
}

//onDelete 수행할 함수
func deleteItem(indexSet: IndexSet) {
    print("indexSet: \(indexSet)")
}

//onMove 수행할 함수
func moveItem(from source: IndexSet, to destination: Int) {
    print("source: \(source)")
    print("destination: \(destination)")
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
