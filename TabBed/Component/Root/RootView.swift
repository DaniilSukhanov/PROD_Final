//
//  RootView.swift
//  TabBed
//
//  Created by Даниил Суханов on 30.03.2024.
//

import SwiftUI

struct RootView: View {
    @EnvironmentObject var store: Store<RootState, RootAction>
    
    var body: some View {
        NavigationStack {
            ZStack {
                AppColor.backgroud
                    .ignoresSafeArea()
                VStack {
                    ScrollView(.vertical, showsIndicators: false) {
                        MainView()
                    }
                }
            }
        }
        
    }
}

#Preview {
    RootView()
}
