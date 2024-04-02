//
//  AddingMeetingView.swift
//  TabBed
//
//  Created by Даниил Суханов on 31.03.2024.
//

import SwiftUI

struct AddingMeetingView: View {
    @EnvironmentObject var store: Store<RootState, RootAction>
    var body: some View {
        ZStack {
            AppColor.backgroud
                .ignoresSafeArea()
            if let error = store.state.addingMeeting.error {
                ErrorView(text: error) {
                    store.dispatch(.addingMeetingAction(.setError(nil)))
                }
            } else {
                content
                    .transition(.move(edge: .leading))
            }
        }.animation(.easeInOut(duration: 0.3), value: store.state.addingMeeting.currentView)
    }
    
    @ViewBuilder var content: some View {
        switch store.state.addingMeeting.currentView {
        case .participants:
            SelectionParticipantView()
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        BackButton {
                            withAnimation {
                                store.dispatch(.addingMeetingAction(.resetData))
                                store.dispatch(.setCurrentView(store.state.addingMeeting.isEdit ? .detailMeeting : .main))
                            }
                        }
                    }
                }
        case .place:
            SelectionPlaceView()
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        BackButton {
                            withAnimation {
                                store.dispatch(.addingMeetingAction(.setCurrentViewe(.time)))
                            }
                        }
                        
                    }
                }
            
        case .time:
            SelectionTimeView()
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        BackButton {
                            withAnimation {
                                store.dispatch(.addingMeetingAction(.setCurrentViewe(.date)))
                            }
                        }
                    }
                }
            
            
        case .date:
            SelectionDateView()
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        BackButton {
                            withAnimation {
                                store.dispatch(.addingMeetingAction(.setCurrentViewe(.participants)))
                            }
                        }
                    }
                }
        case .agent:
            SelectedAgent()
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        BackButton {
                            withAnimation {
                                store.dispatch(.addingMeetingAction(.setCurrentViewe(.place)))
                            }
                        }
                    }
                }
        case .complited:
            ComplitedView()
        }
    }
}

fileprivate struct SelectionPlaceView: View {
    enum Focus {
        case text
    }
    @EnvironmentObject var store: Store<RootState, RootAction>
    var state: AddingMeetingState {
        store.state.addingMeeting
    }
    @FocusState var focus: Focus?
    @State var selectedPlace = ""
    var body: some View {
        if let error = state.error {
            ErrorView(text: error) {
                store.dispatch(.addingMeetingAction(.setError(nil)))
            }
        } else {
            LoadingView(isLoading: state.isCheakingAddress) {
                content
            }
        }
        
    }
    
    @ViewBuilder var content: some View {
        ZStack {
            AppColor.backgroud
                .ignoresSafeArea()
                .onTapGesture {
                    focus = nil
                }
            VStack {
                Spacer()
                Text("Укажите место встречи")
                    .font(AppFont.title)
                    .foregroundStyle(AppColor.baseText)
                TextField("Место", text: $selectedPlace)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .center)
                    .focused($focus, equals: .text)
                    .foregroundStyle(AppColor.baseText)
                    .background(AppColor.first)
                    .clipShape(RoundedRectangle(cornerRadius: 25))
                    .frame(maxWidth: .infinity, maxHeight: 80)
                Spacer()
                Button {
                    store.dispatch(.addingMeetingAction(.correctAddress(selectedPlace)))
                    guard let date = state.date, let time = state.time else {
                        return
                    }
                    let formatter = DateFormatter()
                    formatter.dateFormat = "y-M-d"
                    var datetime = formatter.string(from: date)
                    formatter.dateFormat = "HH:mm"
                    datetime += " \(formatter.string(from: time))"
                    print(datetime)
                    formatter.dateFormat = "y-M-d HH:mm"
                    guard let date = formatter.date(from: datetime) else {
                        return
                    }
                    store.dispatch(.addingMeetingAction(.getAgents(date)))
                } label: {
                    RoundedRectangle(cornerRadius: 25)
                        .fill(AppColor.secondBackgroud)
                        .overlay {
                            Text("Дальше")
                                .font(AppFont.title)
                                .foregroundStyle(AppColor.invertBaseText)
                        }
                }.frame(maxHeight: 80)
            }.padding().onAppear {
                selectedPlace = store.state.addingMeeting.place?.name ?? ""
            }
        }
    }
}

fileprivate struct SelectionTimeView: View {
    @EnvironmentObject var store: Store<RootState, RootAction>
    @State var selectedDate: Date = .now
    
    var body: some View {
        ZStack {
            AppColor.backgroud
                .ignoresSafeArea()
            VStack {
                Spacer()
                Text("Укажите время")
                    .font(AppFont.title)
                    .foregroundStyle(AppColor.baseText)
                DatePicker("", selection: $selectedDate, displayedComponents: .hourAndMinute)
                    .colorMultiply(AppColor.secondBackgroud)
                    .tint(AppColor.baseText)
                    .datePickerStyle(.wheel)
                    .background(AppColor.first)
                    .clipShape(RoundedRectangle(cornerRadius: 25))
                Spacer()
                Button {
                    store.dispatch(.addingMeetingAction(.setTime(selectedDate)))
                } label: {
                    Rectangle()
                        .fill(AppColor.secondBackgroud)
                        .addBorder(AppColor.secondBackgroud, cornerRadius: 25, lineWidth: 3)
                        .overlay {
                            Text("Дальше")
                                .font(AppFont.title)
                                .foregroundStyle(AppColor.invertBaseText)
                        }
                }.frame(maxHeight: 80)
                
            }
            .padding().onAppear {
                selectedDate = store.state.addingMeeting.time ?? .now
            }
        }
    }
}

fileprivate struct SelectionDateView: View {
    @EnvironmentObject var store: Store<RootState, RootAction>
    @State var selectedDate: Date = .now
    private let range = {
        let calendar = Calendar.current
        let startComponents = DateComponents(
            year: 2024,
            month: 4,
            day: 4,
            hour: 00,
            minute: 00,
            second: 00
        )
        let endComponents = DateComponents(
            year: 2024,
            month: 4,
            day: 12,
            hour: 23,
            minute: 59,
            second: 59
            )
        return calendar.date(from:startComponents)!...calendar.date(from:endComponents)!
    }()
    var body: some View {
        VStack {
            Spacer()
            Text("Укажите дату")
                .font(AppFont.title)
                .foregroundStyle(AppColor.baseText)
            
            DatePicker("", selection: $selectedDate, in: range, displayedComponents: .date)
                .colorMultiply(AppColor.secondBackgroud)
                .tint(AppColor.baseText)
                .datePickerStyle(.graphical)
                .background(AppColor.first).clipShape(RoundedRectangle(cornerRadius: 25))
            Spacer()
            Button {
                store.dispatch(.addingMeetingAction(.setDate(selectedDate)))
            } label: {
                Rectangle()
                    .fill(AppColor.secondBackgroud)
                    .addBorder(AppColor.secondBackgroud, cornerRadius: 25, lineWidth: 3)
                    .overlay {
                        Text("Дальше")
                            .font(AppFont.title)
                            .foregroundStyle(AppColor.invertBaseText)
                    }
            }.frame(maxHeight: 80)
        }
        .padding().onAppear {
            selectedDate = store.state.addingMeeting.date ?? .now
        }
    }
}

fileprivate struct SelectionParticipantView: View {
    struct Conteiner {
        @State var name: String = ""
        @State var phone: String = ""
    }
    enum Fosus {
        case text
    }
    
    @EnvironmentObject var store: Store<RootState, RootAction>
    @State var amountParticipants = 1
    @State private var cache = [Int: Conteiner]()
    @FocusState var focus: Fosus?
    var body: some View {
        VStack {
            EmptyView()
                .frame(height: 80)
            ScrollView {
                Text("Укажите участников встречи")
                    .font(AppFont.title)
                    .foregroundStyle(AppColor.baseText)
                VStack {
                    ForEach(0..<amountParticipants, id: \.self) { index in
                        VStack {
                            TextField("Имя", text: .init(get: { cache[index]?.name ?? "" }, set: {
                                cache[index] = Conteiner(name: $0, phone: cache[index]?.phone ?? "")
                            }))
                            .focused($focus, equals: .text)
                                .padding()
                                .background(AppColor.first)
                                .clipShape(RoundedRectangle(cornerRadius: 25))
                            TextField("Телефон", text: .init(get: { cache[index]?.phone ?? "" }, set: {
                                cache[index] = Conteiner(name: cache[index]?.name ?? "", phone: $0)
                            }))
                            .focused($focus, equals: .text)
                                .padding()
                                .background(AppColor.first)
                                .clipShape(RoundedRectangle(cornerRadius: 25))
                        }
                    }
                }
                Button {
                    amountParticipants += 1
                } label: {
                    AppImage.plus
                        .foregroundStyle(AppColor.baseText)
                        .font(AppFont.largeTitle)
                }
            }
            Spacer()
            Button {
                var result = [Participant]()
                for item in cache.values {
                    result.append(.init(name: item.name, position: "Участник", phoneNumber: item.phone))
                }
                store.dispatch(.addingMeetingAction(.setParticipants(result)))
            } label: {
                Rectangle()
                    .fill(AppColor.secondBackgroud)
                    .addBorder(AppColor.secondBackgroud, cornerRadius: 25, lineWidth: 3)
                    .overlay {
                        Text("Дальше")
                            .font(AppFont.title)
                            .foregroundStyle(AppColor.invertBaseText)
                    }
            }.frame(maxHeight: 80).disabled(cache.isEmpty)
        }.padding()
            .onTapGesture {
                focus = nil
            }.onAppear {
                for item in store.state.addingMeeting.participants.enumerated() {
                    cache[item.offset] = Conteiner(name: item.element.name, phone: item.element.phoneNumber)
                }
            }
    }
}

fileprivate struct SelectedAgent: View {
    @EnvironmentObject var store: Store<RootState, RootAction>
    @State var selectedAgent: AgentModel?
    
    var state: AddingMeetingState {
        store.state.addingMeeting
    }
    
    var body: some View {
        VStack {
            LoadingView(isLoading: state.isLoadingAgents, model: state.agents) { agents in
                ScrollView {
                    ForEach(agents, id: \.id) { agent in
                        AgentView(agent: agent)
                            .addBorder(selectedAgent?.id == agent.id ? AppColor.first : AppColor.second, cornerRadius: 25, lineWidth: 3)
                            .onTapGesture {
                                selectedAgent = agent
                            }
                    }
                }
            }
            Spacer()
            Button {
                store.dispatch(.addingMeetingAction(.getProducts))
                store.dispatch(.addingMeetingAction(.setCurrentAgent(selectedAgent)))
                store.dispatch(.addingMeetingAction(.createMeeting(state.participants, state.place, state.date, state.time, selectedAgent?.id)))
            } label: {
                Rectangle()
                    .fill(AppColor.secondBackgroud)
                    .addBorder(AppColor.secondBackgroud, cornerRadius: 25, lineWidth: 3)
                    .overlay {
                        Text("Добавить")
                            .font(AppFont.title)
                            .foregroundStyle(AppColor.invertBaseText)
                    }
            }.frame(maxHeight: 80)
        }.onAppear {
            selectedAgent = store.state.addingMeeting.selectedAgent
        }
    }
}

fileprivate struct ComplitedView: View {
    @EnvironmentObject var store: Store<RootState, RootAction>
    
    var state: AddingMeetingState {
        store.state.addingMeeting
    }
    
    var body: some View {
        ZStack {
            AppColor.complitedBackgroud.ignoresSafeArea()
            VStack {
                Spacer()
                AppImage.lottiHeart.resizable()
                    .scaledToFit()
                    .frame(height: 200)
                Text("Ваша заявка принята")
                    .font(AppFont.largeTitle)
                    .foregroundStyle(AppColor.baseText)
                LoadingView(isLoading: state.isLoadingProducts, model: state.products) { products in
                    VStack {
                        ForEach(products, id: \.id) { product in
                            ProductView(model: product)
                        }
                    }
                }
                Spacer()
                Button {
                    if state.isEdit {
                        store.dispatch(.setCurrentView(.detailMeeting))
                    } else {
                        store.dispatch(.setCurrentView(.main))
                    }
                    store.dispatch(.addingMeetingAction(.setCurrentViewe(.participants)))
                    store.dispatch(.addingMeetingAction(.toMain(false)))
                    store.dispatch(.addingMeetingAction(.resetData))
                } label: {
                    Rectangle()
                        .fill(AppColor.secondBackgroud)
                        .addBorder(AppColor.secondBackgroud, cornerRadius: 25, lineWidth: 3)
                        .overlay {
                            Text("Хорошо")
                                .font(AppFont.title)
                                .foregroundStyle(AppColor.invertBaseText)
                        }
                }.frame(maxHeight: 80)
            }.padding()
        }
    }
}

#Preview {
    NavigationView {
        AddingMeetingView()
    }
}
