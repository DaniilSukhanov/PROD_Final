//
//  MainView.swift
//  TabBed
//
//  Created by Даниил Суханов on 30.03.2024.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var store: Store<RootState, RootAction>
    var state: MainState {
        store.state.main
    }
    
    var body: some View {
        VStack {
            buttonAdd
                .frame(maxHeight: 80)
            mettings
                .onAppear {
                    store.dispatch(.mainAction(.setMeetings([ShortlyInfoMeetingModel(date: "123", nameSpecialist: "123", status: .active, id: 123)])))
                }
                
        }.padding([.leading, .trailing], 16)
    }
    
    var buttonAdd: some View {
        NavigationLink {
            AddingMeetingView()
        } label: {
            Text("Добавить")
                .foregroundStyle(AppColor.baseText)
                .font(AppFont.body)
                .padding()
        }.clipShape(Rectangle())
        .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(AppColor.first)
            .addBorder(AppColor.second, cornerRadius: 25, lineWidth: 3)
            .buttonStyle(PlainButtonStyle())
        
    }
    
    var mettings: some View {
        VStack(spacing: 10) {
            if state.shortlyInfoMeetingModels.isEmpty {
                Text("Нет задач")
                    .foregroundStyle(AppColor.baseText)
            }
            ForEach(state.shortlyInfoMeetingModels, id: \.id) { model in
                NavigationLink {
                    DetailMeetingView()
                        .onAppear {
                            let model = DetailMeetingModel(phoneNumber: "123", name: "Name", description: "123", photo: Image("Avatar"), date: "123", place: "123", status: .active)
                            store.dispatch(.detailMeeting(.set(model)))
                        }
                } label: {
                    ShortlyInfoMeetingView(model: model)
                }.buttonStyle(PlainButtonStyle())

                
            }
        }
    }
}

#Preview {
    var state = RootState()
    state.main.shortlyInfoMeetingModels = [
        .init(date: "23 ноября 23:00", nameSpecialist: "Петя Пепеткин", status: .active, id: 123),
        .init(date: "23 ноября 23:00", nameSpecialist: "Пепеткин", status: .cancel, id: 321),
        .init(date: "23 ноября 23:00", nameSpecialist: "Петя",status: .completed, id: 222),
    ]
    return NavigationView{
        ZStack {
            AppColor.backgroud
                .ignoresSafeArea()
            MainView()
                .environmentObject(Store(state: state, reducer: rootReducer, middlewares: []))
        }
    }
}
