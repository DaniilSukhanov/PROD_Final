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
            model.status.view
            HStack {
                Text(model.nameSpecialist)
                    .font(AppFont.body)
                    .foregroundStyle(AppColor.baseText)
                Spacer()
            }
            Text(model.date)
                .font(AppFont.body)
                .foregroundStyle(AppColor.baseText)
        }.padding()
            .background(AppColor.first)
            .addBorder(AppColor.second, cornerRadius: 25, lineWidth: 3)
    }
}

#Preview {
    ZStack {
        AppColor.backgroud
            .ignoresSafeArea()
        ShortlyInfoMeetingView(model: .init(date: "23 ноября 23:00", nameSpecialist: "Петя Пепеткин", status: .active, id: 123))
    }
}
