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
    @State var isAlert = false
    
    var body: some View {
        content
            .background(AppColor.backgroud)
            .addBorder(AppColor.backgroud, cornerRadius: 25)
    }
    
    var content: some View {
        VStack(alignment: .leading, spacing: 10) {
            DetailAgentView(model: model.agent)
                .padding()
                .background(AppColor.first)
                .clipShape(RoundedRectangle(cornerRadius: 25))
            InfoView(model: model)
                .padding()
                .background(AppColor.first)
                .clipShape(RoundedRectangle(cornerRadius: 25))
            ParticipantsView(model: model)
                .padding()
                .background(AppColor.first)
                .clipShape(RoundedRectangle(cornerRadius: 25))
            DocumentsView(model: model)
                .padding()
                .background(AppColor.first)
                .clipShape(RoundedRectangle(cornerRadius: 25))
            HStack {
                Button {
                    store.dispatch(.addingMeetingAction(.loadData(model)))
                    store.dispatch(.setCurrentView(.addingMeeting))
                } label: {
                    RoundedRectangle(cornerRadius: 25)
                        .fill(AppColor.secondBackgroud)
                        .overlay {
                            Text("Изменить")
                                .font(AppFont.title2)
                                .foregroundStyle(AppColor.invertBaseText)
                        }.padding().frame(height: 80)
                }
                Button {
                    isAlert = true
                } label: {
                    AppImage.trash.resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                        .foregroundStyle(AppColor.cancled)
                        .padding(.trailing, 8)
                }
            }.background(AppColor.first)
                .clipShape(RoundedRectangle(cornerRadius: 25))
        }.padding()
            .alert("Вы точно хотите удалить?", isPresented: $isAlert) {
                Button("Отмена") {
                    isAlert = false
                }
                Button("Изменить") {
                    store.dispatch(.addingMeetingAction(.loadData(model)))
                    store.dispatch(.setCurrentView(.addingMeeting))
                }
                Button("Удалить") {
                    store.dispatch(.detailMeeting(.delete(model.id)))
                    store.dispatch(.setCurrentView(.main))
                    store.dispatch(.mainAction(.getMeetings))
                }
        } message: {
            Text("Может все-таки изменить встречу?")
        }

    }
    

}

fileprivate struct ParticipantsView: View {
    let model: DetailMeetingModel
    
    var body: some View {
        
        VStack(alignment: .leading) {
            HStack {
                Text("Участники встречи")
                    .font(AppFont.title)
                    .foregroundStyle(AppColor.baseText)
                Spacer()
            }
            VStack(alignment: .leading) {
                ForEach(Array(model.participants.enumerated()), id: \.offset) { item in
                    HStack {
                        Text("\(item.offset+1). \(item.element.name)")
                            .font(AppFont.body)
                            .foregroundStyle(AppColor.baseText)
                        Spacer()
                    }
                }
            }
        }.frame(maxWidth: .infinity)
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
        }.frame(maxWidth: .infinity)
    }
}

fileprivate struct InfoView: View {
    let model: DetailMeetingModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Информация")
                .font(AppFont.title)
                .foregroundStyle(AppColor.baseText)
            HStack(alignment: .top) {
                AppImage.placePoint
                    .foregroundStyle(AppColor.baseText)
                    .font(AppFont.body)
                Text(model.place).font(AppFont.body).foregroundStyle(AppColor.baseText)
            }
            HStack(alignment: .top) {
                AppImage.watch
                    .foregroundStyle(AppColor.baseText)
                    .font(AppFont.body)
                Text(model.date).font(AppFont.body).foregroundStyle(AppColor.baseText)
            }
        }.frame(maxWidth: .infinity)
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
