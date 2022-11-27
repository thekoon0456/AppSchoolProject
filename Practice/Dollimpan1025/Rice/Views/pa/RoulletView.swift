//
//  RoulletView.swift
//  DollimPan
//
//  Created by 조현호 on 2022/10/21.
//

import SwiftUI

struct RoulletView: View {
    @State var currentAngle: Angle = .degrees(0)
    @State var finalAngle: Angle = .degrees(0)
    @EnvironmentObject var namesClass: BindingClass
    @State var currentPerson: String = ""
    
    var randomDegrees: Double {
        get {
            Double.random(in:2000.0...5000.0)
        }
    }
    
    var body: some View {
        VStack{
            ZStack{
                //                ImageView()
                Image("파전")
                    .resizable()
                    .frame(width:400, height:400)
                
                CircleDivideView()
                    .rotationEffect(.degrees(-90))
                
                Image("막걸리")
                    .resizable()
                    .frame(width: 60,height: 200)                        .rotationEffect(currentAngle)
                    .gesture(
                        RotationGesture()
                            .onChanged { angle in
                                currentAngle = angle
                            }
                            .onEnded { angle in
                                currentAngle = .degrees(randomDegrees)
                                congratulation()
                                
                                
                            }
                    )
                    .animation(.easeInOut(duration: 2))
            }
            .padding()
            .background(Image("backgroun_img"))

            Text("\(currentPerson)")
                .animation(.easeInOut(duration: 4))
                .font(.largeTitle)
                .foregroundColor(.black)
                .bold()
                .shadow(radius: 10)
                .padding()
        }
    }
    
    func congratulation() {
        
        let currentDegress = currentAngle.degrees
        let gakdo: Double = currentDegress.truncatingRemainder(dividingBy: 360.0)
//        switch gakdo {
//        case 0..<45:
//            currentPerson = namesClass.names[0]
//        case 45..<90:
//            currentPerson = namesClass.names[1]
//        case 90..<135:
//            currentPerson = namesClass.names[2]
//        case 135..<180:
//            currentPerson = namesClass.names[3]
//        case 180..<225:
//            currentPerson = namesClass.names[4]
//        case 225..<270:
//            currentPerson = namesClass.names[5]
//        case 270..<315:
//            currentPerson = namesClass.names[6]
//        case 315..<360:
//            currentPerson = namesClass.names[7]
//        default:
//            0
//        }
        //각도 비교해서 인덱스 정하고 history배열에 넣음
        let index = Int(gakdo / (360.0 / Double(namesClass.names.count)))
        currentPerson = namesClass.names[index]
        namesClass.history.append(("A","\(currentPerson)"))
    }
}

struct RoulletView_Previews: PreviewProvider {
    static var previews: some View {
        RoulletView().environmentObject(BindingClass())
    }
}
