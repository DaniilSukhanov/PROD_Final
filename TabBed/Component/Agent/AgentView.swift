//
//  Avatar.swift
//  TabBed
//
//  Created by Даниил Суханов on 31.03.2024.
//

import SwiftUI

struct AgentView: View {
    let agent: Agent
    
    var body: some View {
        HStack {
            agent.photo
                .resizable()
                .frame(maxWidth: 70, maxHeight: 70)
                .addBorder(AppColor.second, cornerRadius: 35, lineWidth: 3)
            VStack(alignment: .leading) {
                Text(agent.name)
                    .font(AppFont.title3)
                    .foregroundStyle(AppColor.baseText)
                    .lineLimit(1)
                Text(agent.descrition)
                    .font(AppFont.body)
                    .foregroundStyle(AppColor.baseText)
                    .lineLimit(1)
            }
            Spacer()
        }.padding()
            .background(AppColor.secondeBoard)
            .addBorder(AppColor.second, cornerRadius: 25, lineWidth: 3)
    }
}

#Preview {
    AgentView(agent:  .init(name: "2389903290", phone: "79839832", descrition: "2139873", photo: Image("Avatar")))
}
