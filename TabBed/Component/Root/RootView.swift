//
//  RootView.swift
//  TabBed
//
//  Created by Даниил Суханов on 30.03.2024.
//

import SwiftUI

struct RootView: View {
    @EnvironmentObject var store: Store<RootState, RootAction>
    @State var nc: NavigationConfigurator = .init()
    
    var body: some View {
        NavigationView {
            ZStack {
                AppColor.backgroud
                    .ignoresSafeArea()
                content
                    .transition(.move(edge: .leading).animation(.easeInOut))
                    .background(nc)
                
            }.animation(.easeOut(duration: 0.3), value: store.state.currentView)
        }
    }
    
    @ViewBuilder var content: some View {
        switch store.state.currentView {
        case .main:
            MainView()
                .onAppear {
                    nc = NavigationConfigurator(configure: { nc in
                        nc.navigationBar.barTintColor = UIColor(AppColor.backgroud)
                        nc.navigationBar.titleTextAttributes = [.foregroundColor : UIColor(AppColor.baseText)]
                        nc.navigationBar.largeTitleTextAttributes = [.foregroundColor : UIColor(AppColor.baseText)]
                        nc.navigationBar.backgroundColor = UIColor(AppColor.backgroud)
                    })
                }
        case .addingMeeting:
            AddingMeetingView()
                .onAppear {
                    nc = NavigationConfigurator(configure: { nc in
                        nc.navigationBar.barTintColor = UIColor(AppColor.backgroud)
                        nc.navigationBar.titleTextAttributes = [.foregroundColor : UIColor(AppColor.baseText)]
                        nc.navigationBar.largeTitleTextAttributes = [.foregroundColor : UIColor(AppColor.baseText)]
                        nc.navigationBar.backgroundColor = UIColor(AppColor.backgroud)
                    })
                }
                
        case .detailMeeting:
            DetailMeetingView()
                .onAppear {
                    nc = NavigationConfigurator(configure: { nc in
                        nc.navigationBar.barTintColor = UIColor(AppColor.secondBackgroud)
                        nc.navigationBar.titleTextAttributes = [.foregroundColor : UIColor(AppColor.invertBaseText)]
                        nc.navigationBar.largeTitleTextAttributes = [.foregroundColor : UIColor(AppColor.invertBaseText)]
                        nc.navigationBar.backgroundColor = UIColor(AppColor.secondBackgroud)
                    })
                }
        }
    }
}

#Preview {
    RootView()
}
