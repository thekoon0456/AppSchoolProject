//
//  BingingClass.swift
//  Rice
//
//  Created by Deokhun KIM on 2022/10/24.
//

import Foundation
import SwiftUI
import Combine

class BindingClass: ObservableObject {
    
    @Published var id = UUID()
    
    @Published var names: [String] = []
    
    //(파전, 입력한 이름) 튜플 배열
    @Published var history: [(String,String)] = []

//    init(names: [String]) {
//        self.names = names
//    }
    
    
}
