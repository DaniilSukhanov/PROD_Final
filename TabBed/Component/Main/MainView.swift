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
    
    let id = UUID()
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                if let error = state.error {
                    ErrorView(text: error) {
                        store.dispatch(.mainAction(.setError(nil)))
                    }.zIndex(0)
                } else {
                    if state.shortlyInfoMeetingModels.isEmpty {
                        VStack {
                            AppImage.lottiSleep
                                .resizable()
                                .scaledToFit()
                                .frame(height: 150)
                                .colorMultiply(AppColor.firstColor)
                            Text("Список заявок пуст")
                                .font(AppFont.title3)
                                .foregroundStyle(AppColor.baseText)
                        }
                    }
                    LoadingView(isLoading: state.isLoadingMeetings) {
                        
                        ScrollView(.vertical, showsIndicators: false) {
                            LazyVStack {
                                mettings
                            }.padding([.leading, .trailing], 16)
                            Spacer()
                                .frame(height: geometry.size.height * 0.1 + 40)
                        }.refreshable {
                            withAnimation {
                                store.dispatch(.mainAction(.getMeetings))
                            }
                        }.id(id)
                            .transition(.opacity.animation(.easeInOut(duration: 1.2)))
                        
                        
                    }.onAppear {
                        withAnimation {
                            store.dispatch(.mainAction(.getMeetings))
                        }
                    }.zIndex(1)
                }
                buttonAdd
                    .frame(maxWidth: geometry.size.width * 0.75, maxHeight: 70)
                    .position(x: 0.5 * geometry.size.width, y: geometry.size.height * 0.93)
                    .zIndex(2)
                
            }.navigationTitle("Заявки").navigationBarTitleDisplayMode(.large)
        }
        
    }
    
    var buttonAdd: some View {
        Button {
            store.dispatch(.setCurrentView(.addingMeeting))
        } label: {
            RoundedRectangle(cornerRadius: 25)
                .fill(AppColor.secondBackgroud)
                .overlay {
                    Text("Добавить")
                        .foregroundStyle(AppColor.invertBaseText)
                        .font(AppFont.title)
                        .padding([.leading, .trailing], 32)
                }
        }
        
    }
    
    @ViewBuilder var mettings: some View {
        VStack(spacing: 10) {
            ForEach(state.shortlyInfoMeetingModels, id: \.id) { model in
                Button {
                    store.dispatch(.detailMeeting(.get(model.id)))
                    store.dispatch(.setCurrentView(.detailMeeting))
                } label: {
                    ShortlyInfoMeetingView(model: model)
                }.buttonStyle(PlainButtonStyle())
                    .transition(.opacity.animation(.easeInOut(duration: 3)))
            }
        }
    }
    
    
}

#Preview {
    var state = RootState()
    state.main.shortlyInfoMeetingModels = [
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
