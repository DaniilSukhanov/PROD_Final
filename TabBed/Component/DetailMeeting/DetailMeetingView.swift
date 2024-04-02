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
            AppColor.secondBackgroud
                .ignoresSafeArea()
            ZStack(alignment: .bottom) {
                Rectangle()
                    .fill(AppColor.backgroud)
                    .cornerRadius(25, corners: [.topLeft, .topRight])
                    .ignoresSafeArea(.all, edges: .bottom)
                    
                    
                ScrollView {
                    LoadingView(isLoading: state.isLoading, model: state.model) { model in
                        VStack(spacing: 0) {
                            ContentView(model: model)
                        }.navigationTitle("Заявка").navigationBarTitleDisplayMode(.large)
                    }
                }
            }.toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(action: { store.dispatch(.setCurrentView(.main)) }) {
                        AppImage.back.foregroundStyle(AppColor.first)
                            .font(AppFont.title)
                    }.frame(width: 80, height: 80)
                }
            }
        }
    }
}

fileprivate struct ContentView: View {
    @EnvironmentObject var store: Store<RootState, RootAction>
    let model: DetailMeetingModel
    
    var body: some View {
        content
            .background(AppColor.backgroud)
            .addBorder(AppColor.backgroud, cornerRadius: 25)
    }
    
    var content: some View {
        VStack(alignment: .leading, spacing: 10) {
            InfoView(model: model)
            ParticipantsView(model: model)
            DocumentsView(model: model)
            AgentsView(model: model)
            
            Button {
                store.dispatch(.detailMeeting(.delete(model.id)))
                store.dispatch(.setCurrentView(.main))
                store.dispatch(.mainAction(.getMeetings))
            } label: {
                RoundedRectangle(cornerRadius: 25)
                    .fill(AppColor.cancled)
                    .overlay {
                        Text("Отменить")
                            .font(AppFont.title2)
                            .foregroundStyle(AppColor.invertBaseText)
                    }.padding().frame(height: 80)
            }
            Button {
                store.dispatch(.addingMeetingAction(.loadData(model)))
                store.dispatch(.setCurrentView(.addingMeeting))
            } label: {
                RoundedRectangle(cornerRadius: 25)
                    .fill(AppColor.secondBackgroud)
                    .overlay {
                        Text("Редактировать")
                            .font(AppFont.title2)
                            .foregroundStyle(AppColor.invertBaseText)
                    }.padding().frame(height: 80)
            }
        }.padding()
    }
    

}

fileprivate struct ParticipantsView: View {
    let model: DetailMeetingModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Участники встречи")
                .font(AppFont.title)
                .foregroundStyle(AppColor.baseText)
            VStack(alignment: .leading) {
                ForEach(Array(model.participants.enumerated()), id: \.offset) { item in
                    Text("\(item.offset+1). \(item.element.name)")
                        .font(AppFont.body)
                        .foregroundStyle(AppColor.baseText)
                }
            }
        }
    }
}

fileprivate struct DocumentsView: View {
    let model: DetailMeetingModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Документы")
                .font(AppFont.title)
                .foregroundStyle(AppColor.baseText)
            VStack(alignment: .leading) {
                ForEach(0..<model.documents.count, id: \.self) { index in
                    Text("\(index+1). \(model.documents[index])")
                        .foregroundStyle(AppColor.baseText)
                        .font(AppFont.body)
                }
            }
        }
    }
}

fileprivate struct AgentsView: View {
    let model: DetailMeetingModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("К вам приедет")
                .font(AppFont.title)
                .foregroundStyle(AppColor.baseText)
            AgentView(agent: model.agent)
        }
    }
}

fileprivate struct InfoView: View {
    let model: DetailMeetingModel
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Информация")
                    .font(AppFont.title)
                    .foregroundStyle(AppColor.baseText)
                HStack {
                    AppImage.placePoint
                        .foregroundStyle(AppColor.baseText)
                        .font(AppFont.body)
                    Text(model.place).font(AppFont.body).foregroundStyle(AppColor.baseText)
                }
                HStack {
                    AppImage.watch
                        .foregroundStyle(AppColor.baseText)
                        .font(AppFont.body)
                    Text(model.date).font(AppFont.body).foregroundStyle(AppColor.baseText)
                }
            }
            Spacer()
        }
    }
}

#Preview {
    var state = RootState()
    state.detailMeeting.model = .init(
        agent: .init(name: "Петя Пепеткин", phone: "+7(666)666-66-66", descrition: "Я Крутой!!!", photo: Image("Avatar"), id: 1),
        date: "23 ноября 23:00",
        place: "Ад", status: .active, documents: ["123", "213", "544", "422"], id: 2, participants: []
    )
    state.detailMeeting.isLoading = false
    return NavigationView { DetailMeetingView()
        .environmentObject(Store(state: state, reducer: rootReducer, middlewares: [])) }
}
