//
//  AppTitleView.swift
//  DollimPan
//
//  Created by Donghoon Bae on 2022/10/21.
//

import SwiftUI

//파전 뷰에 있는 타이틀뷰
struct AppTitleView: View {
    var body: some View {
        HStack(alignment: .center) {
            Spacer()
            VStack {
                Text("치사한 회전판 🍽")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .shadow(radius: 3)
                    .padding(2)
            }
            Spacer()
        }
    }
}

struct AppTitleView_Previews: PreviewProvider {
    static var previews: some View {
        AppTitleView()
    }
}
