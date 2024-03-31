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
            SelectionDateView()
        }
    }
}

fileprivate struct SelectionPlaceView: View {
    enum Focus {
        case text
    }
    @EnvironmentObject var store: Store<RootState, RootAction>
    @FocusState var focus: Focus?
    @State var selectedPlace = ""
    var body: some View {
        ZStack {
            AppColor.backgroud
                .ignoresSafeArea()
                .onTapGesture {
                    focus = nil
                }
            VStack {
                Spacer()
                TextField("Место", text: $selectedPlace)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .center)
                    .focused($focus, equals: .text)
                    .foregroundStyle(AppColor.baseText)
                    .background(AppColor.first)
                    .addBorder(AppColor.second, cornerRadius: 25, lineWidth: 3)
                    .frame(maxWidth: .infinity, maxHeight: 80)
                Spacer()
                NavigationLink {
                    Text("finish")
                        .onAppear {
                            store.dispatch(.addingMeetingAction(.setPlace(selectedPlace)))
                        }.onTapGesture {
                            
                        }
                } label: {
                    Rectangle()
                        .background(AppColor.first)
                        .addBorder(AppColor.second, cornerRadius: 25, lineWidth: 3)
                        .overlay {
                            Text("Добить")
                                .font(AppFont.body)
                                .foregroundStyle(AppColor.baseText)
                        }
                }.frame(maxHeight: 80)
                    
            }.padding()
        }.navigationTitle("Выбирите место")
            .buttonStyle(PlainButtonStyle())
            
        
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
                DatePicker("", selection: $selectedDate, in: store.state.addingMeeting.rangeTime, displayedComponents: .hourAndMinute)
                    .colorMultiply(AppColor.baseText)
                    .datePickerStyle(.wheel)
                    .background(AppColor.first)
                    .addBorder(AppColor.second, cornerRadius: 25, lineWidth: 3)
                Spacer()
                NavigationLink {
                    SelectionPlaceView()
                        .onAppear {
                            store.dispatch(.addingMeetingAction(.setTime(selectedDate)))
                        }
                } label: {
                    Rectangle()
                        .background(AppColor.first)
                        .addBorder(AppColor.second, cornerRadius: 25, lineWidth: 3)
                        .overlay {
                            Text("Добить")
                                .font(AppFont.body)
                                .foregroundStyle(AppColor.baseText)
                        }
                }.frame(maxHeight: 80)
            }.navigationTitle("Выбирите время")
                .buttonStyle(PlainButtonStyle())
                .padding()
        }
    }
}

fileprivate struct SelectionDateView: View {
    @EnvironmentObject var store: Store<RootState, RootAction>
    @State var selectedDate: Date = .now
    var body: some View {
        VStack {
            Spacer()
            DatePicker("", selection: $selectedDate, displayedComponents: .date)
                .colorMultiply(AppColor.baseText)
                .datePickerStyle(.graphical)
                .background(AppColor.first)
                .addBorder(AppColor.second, cornerRadius: 25, lineWidth: 3)
            Spacer()
            NavigationLink {
                SelectionTimeView()
                    .onAppear {
                        store.dispatch(.addingMeetingAction(.setDate(selectedDate)))
                    }
            } label: {
                Rectangle()
                    .background(AppColor.first)
                    .addBorder(AppColor.second, cornerRadius: 25, lineWidth: 3)
                    .overlay {
                        Text("Добить")
                            .font(AppFont.body)
                            .foregroundStyle(AppColor.baseText)
                    }
            }.frame(maxHeight: 80)
        }.navigationTitle("Выбирите дату")
            .buttonStyle(PlainButtonStyle())
            .padding()
    }
}

#Preview {
    NavigationView {
        AddingMeetingView()
    }
}
