//
//  state1024App.swift
//  state1024
//
//  Created by Deokhun KIM on 2022/10/24.
//

import SwiftUI

@main
struct state1024App: App {
//    let demoData:DemoData = DemoData()
    
    var body: some Scene {
        WindowGroup {
            ContentView(demoData: DemoData())
//                .environmentObject(demoData)
        }
    }
}

