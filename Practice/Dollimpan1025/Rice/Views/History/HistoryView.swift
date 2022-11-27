//
//  HistoryView.swift
//  Rice
//
//  Created by Deokhun KIM on 2022/10/24.
//

import SwiftUI

struct HistoryView: View {
    @EnvironmentObject var namesClass: BindingClass
    
    
    
    var body: some View {
        VStack {
            Text("결과를 보자")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .shadow(radius: 3)
                .padding(40)
            
            List {
                ForEach(namesClass.history, id: \.1.self) { name in
                    Text("\(name.0 == "A" ? "파전" : "김치전") 먹은사람 \(name.1) 입니다")
                }
//                .onMove(perform: moveItems)
                .onDelete(perform: deleteItems)
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(Color.black)
                .background(Color(red: 0.859, green: 0.784, blue: 0.675, opacity: 0.5))
            }
            .listStyle(.plain)
            .overlay(RoundedRectangle(cornerRadius: 20)
                .stroke(Color.black, lineWidth: 4))
            .cornerRadius(20)
            .frame(width: 350, height: 500)
        }.background(Image("backgroun_img"))
            .navigationBarItems(trailing: EditButton())
    }
    
//    func moveItems(from source: IndexSet, to destination: Int) {
//        namesClass.history.move(fromOffsets: source, toOffset: destination)
//    }
    
    func deleteItems(at offsets: IndexSet) {
        namesClass.history.remove(atOffsets: offsets)
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView().environmentObject(BindingClass())
    }
}

