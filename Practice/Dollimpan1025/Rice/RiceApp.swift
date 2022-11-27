//
//  RiceApp.swift
//  Rice
//
//  Created by sole on 2022/10/24.
//

import SwiftUI

@main
struct RiceApp: App {
    var body: some Scene {
        WindowGroup {
            StartView().environmentObject(BindingClass())
        }
    }
}
