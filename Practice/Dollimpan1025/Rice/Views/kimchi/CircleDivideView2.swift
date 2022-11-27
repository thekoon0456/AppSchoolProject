//
//  CircleDivideView.swift
//  DollimPan
//
//  Created by Donghoon Bae on 2022/10/24.
//

import SwiftUI

struct CircleDivideView2: View {
    @EnvironmentObject var namesClass: BindingClass
//    let symbols = ["덕훈", "창휘", "동훈", "학진", "현호", "소민", "혜민", "예리"]
    
    var body: some View {
        WheelShape(namesClass.names.sorted())
            .stroke(
                Color(.white), lineWidth: 3.0)
//            .background(
//                Circle()
//                    .stroke(Color(.black), lineWidth: 0)
//            )
            .overlay(
                annotations.foregroundColor(.white).font(.largeTitle).bold().shadow(radius: 5))
    }
    
    var annotations : some View {
        ZStack {
            let theta = CGFloat(2) * .pi / CGFloat(namesClass.names.count)
            GeometryReader { geo in
                let center = CGPoint(x: geo.size.width / 2, y: geo.size.height / 2)
                let radius = min(geo.size.width / 2, geo.size.height / 2) / 1.5
                ForEach(0..<namesClass.names.count, id: \.self) { index in
                    let offset = theta * CGFloat(index) + theta / 2
                    Text(namesClass.names[index])
                        .rotationEffect(.degrees(90))
                        .offset(x: center.x, y: center.y)
                        .offset(x: radius * cos(offset), y: radius * sin(offset))
                        .frame(alignment: .center)
                        .offset(x: -30, y: -10)
                }
            }
        }
    }
    struct WheelShape: Shape {
        let symbols : [String]
        
        init(_ symbols: [String]) {
            self.symbols = symbols
        }
        
        func path(in rect: CGRect) -> Path {
            // center of the shape we are drawing in
            let center = CGPoint(x: rect.size.width / 2, y: rect.size.height / 2)
            let radius = min(rect.size.width / 2, rect.size.height / 2)
            // each angle offset in radians
            let theta = CGFloat(2) * .pi / CGFloat(symbols.count)
            var path = Path()
            
            // enumerate the array so index is available
            symbols.enumerated().forEach({ (index, symbol) in
                let offset = theta * CGFloat(index)
                path.move(to: center)
                path.addLine(to: CGPoint(x: radius * cos(offset) + center.x, y: radius * sin(offset) + center.y))
            })
            
            return path
        }
    }
}
struct CircleDivideView2_Previews: PreviewProvider {
    static var previews: some View {
        CircleDivideView2().environmentObject(BindingClass())
    }
    
}


