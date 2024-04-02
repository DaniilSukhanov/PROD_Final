//
//  ShortlyInfoMeetingView.swift
//  TabBed
//
//  Created by Даниил Суханов on 30.03.2024.
//

import SwiftUI

struct ShortlyInfoMeetingView: View {
    let model: ShortlyInfoMeetingModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Заявка на ООО")
                .foregroundStyle(AppColor.baseText)
                .font(AppFont.title2.bold())
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
            Text("Количество учатников - \(model.participants.count)")
                .font(AppFont.body)
                .foregroundStyle(AppColor.baseText)
            HStack {
                Text("Представитель")
                    .font(AppFont.title2.bold())
                    .foregroundStyle(AppColor.baseText)
                Spacer()
            }
            Divider()
            AgentView(agent: model.agent)
        }.padding()
            .background(AppColor.first)
            .addBorder(AppColor.first, cornerRadius: 25, lineWidth: 3)
    }
}

#Preview {
   ZStack {
        AppColor.backgroud
            .ignoresSafeArea()
       ShortlyInfoMeetingView(model: .init(date: "23 ноября 23:00", place: "3212321", participants: [], agent: .init(name: "Петя Пепеткин", phone: "+7 (666)666-66-66", descrition: "Я крут!", photo: Image("Agent"), id: 1), status: .active, id: 123))
    }
}
