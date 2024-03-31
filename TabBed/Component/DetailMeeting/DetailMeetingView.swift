//
//  DetailMeetingView.swift
//  TabBed
//
//  Created by Даниил Суханов on 31.03.2024.
//

import SwiftUI

struct DetailMeetingView: View {
    @EnvironmentObject var store: Store<RootState, RootAction>
    var state: DetailMeetingState {
        store.state.detailMeeting
    }
    
    var body: some View {
        ZStack {
            AppColor.backgroud
                .ignoresSafeArea()
            LoadingView(isLoading: state.isLoading, model: state.model) { model in
                ContentView(model: model)
            }
        }
    }
}

fileprivate struct ContentView: View {
    let model: DetailMeetingModel
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                avatar
                    .frame(maxHeight: 120)
                Text(model.description)
                    .font(AppFont.body)
                    .foregroundStyle(AppColor.baseText)
                    .padding([.leading, .trailing], 16)
                Text(model.phoneNumber)
                    .font(AppFont.body)
                    .foregroundStyle(AppColor.baseText)
                    .padding([.leading, .bottom, .trailing], 16)
            }.background(AppColor.first)
                .addBorder(AppColor.second, cornerRadius: 25, lineWidth: 3)
            detailInfo
                .padding()
                .background(AppColor.first)
                .addBorder(AppColor.second, cornerRadius: 25, lineWidth: 3)
            Spacer()
        }.padding([.top, .leading, .trailing], 16)
            .navigationTitle("Детальная информация")
    
    }
    
    var avatar: some View {
        HStack {
            model.photo
                .resizable()
                .frame(maxWidth: 80)
                .clipShape(Circle())
            Text(model.name)
                .font(AppFont.title2)
                .foregroundStyle(AppColor.baseText)
            Spacer()
        }.padding([.top, .bottom, .leading], 16)
    }
    
    var detailInfo: some View {
        VStack {
            Text("Доп инфа")
                .font(AppFont.largeTitle)
                .foregroundStyle(AppColor.baseText)
            HStack {
                Text("Статус")
                    .font(AppFont.body)
                    .foregroundStyle(AppColor.baseText)
                Spacer()
                model.status.view
                    .font(AppFont.body)
            }
            HStack {
                Text("Дата")
                    .font(AppFont.body)
                    .foregroundStyle(AppColor.baseText)
                Spacer()
                Text(model.date)
                    .font(AppFont.body)
                    .foregroundStyle(AppColor.baseText)
            }
            HStack {
                Text("Место встречи")
                    .font(AppFont.body)
                    .foregroundStyle(AppColor.baseText)
                Spacer()
                Text(model.place)
                    .font(AppFont.body)
                    .foregroundStyle(AppColor.baseText)
            }
        }
    }
}

#Preview {
    var state = RootState()
    state.detailMeeting.model = .init(
        phoneNumber: "+7(666)666-66-66",
        name: "Петя Пепеткин",
        description: "Я Крутой!!!",
        photo: Image("Avatar"),
        date: "23 ноября 23:00",
        place: "Ад", status: .active
    )
    state.detailMeeting.isLoading = false
    return DetailMeetingView()
        .environmentObject(Store(state: state, reducer: rootReducer, middlewares: []))
}
