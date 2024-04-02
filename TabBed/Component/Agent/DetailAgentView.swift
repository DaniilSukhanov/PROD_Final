//
//  DetailAgentView.swift
//  TabBed
//
//  Created by Даниил Суханов on 02.04.2024.
//

import SwiftUI

struct DetailAgentView: View {
    let model: AgentModel
    
    var body: some View {
        VStack {
            model.photo
                .resizable()
                .scaledToFill()
                .frame(width: 80, height: 80)
                .addBorder(AppColor.secondeBoard, cornerRadius: 50, lineWidth: 3)
            Text(model.name)
                .font(AppFont.title2)
                .foregroundStyle(AppColor.baseText)
            Text("Ваш представитель")
                .font(AppFont.body)
                .foregroundStyle(AppColor.baseText)
            Text("Мобильный")
                .font(AppFont.body)
                .foregroundStyle(AppColor.baseText)
            Text(model.phone)
                .font(AppFont.body)
                .foregroundStyle(AppColor.baseText)
        }.frame(maxWidth: .infinity)
    }
}

#Preview {
    DetailAgentView(model: .init(name: "dsadsa", phone: "sdasdsad", descrition: "sadasd", photo: Image("Avatar"), id: 2))
}
