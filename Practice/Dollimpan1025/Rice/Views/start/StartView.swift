//
//  StartView.swift
//  DollimPan
//
//  Created by 류창휘 on 2022/10/24.
//

import SwiftUI

struct StartView: View {
    @EnvironmentObject var bindingClass: BindingClass
    
//    @State private var result = bindingClass.history.last!.components(separatedBy: ":")
    
    
    
    var body: some View {
        NavigationView {
            VStack {
                Text("우리는 무적의 6조 🔨")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .shadow(radius: 3)
                    .padding(3)
                Text("무엇이든 돌려드립니다")
                    .font(.title2)
                    .fontWeight(.ultraLight)
                    .padding(.bottom, 50)
                
                NavigationLink(destination: ContentView()) {
                    RoulletButton()
                }
                NavigationLink(destination: ContentView2()) {
                    RoulletButton2()
                }
                NavigationLink(destination: HistoryView()) {
                    RoulletButton3()
                    
                }.padding(.bottom, 30)
                
                if bindingClass.history.last != nil {
                    Text("최근 돌림판의 결과는")
                        .font(.title)
                        .fontWeight(.semibold)
                        .shadow(radius: 3)
                        .padding(2)
                    Text("\(bindingClass.history.last?.0 ?? "" == "A" ? "파전" : "김치전") 먹은사람 \(bindingClass.history.last?.1 ?? "")")
                        .font(.title2)
                        .underline()
                        .padding()
                    Text("입니다")
                        .font(.title)
                        .fontWeight(.semibold)
                        .shadow(radius: 3)
                        .padding(2)
                } else {
                    Text("아직 안돌림")
                        .font(.title)
                        .fontWeight(.semibold)
                        .shadow(radius: 3)
                        .padding(2)

                }
                // 최근 결과들 보러가기
            }
            .background(Image("backgroun_img"))
        }
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView().environmentObject(BindingClass())
    }
}
