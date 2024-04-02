//
//  AgentView.swift
//  TabBed
//
//  Created by Даниил Суханов on 31.03.2024.
//

import SwiftUI

struct AgentView: View {
    let agent: AgentModel
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                agent.photo
                    .resizable()
                    .frame(maxWidth: 70, maxHeight: 70)
                    .addBorder(AppColor.secondeBoard, cornerRadius: 35, lineWidth: 3)
                VStack(alignment: .leading) {
                    Text(agent.name)
                        .font(AppFont.title3)
                        .foregroundStyle(AppColor.baseText)
                        .lineLimit(1)
                    Text(agent.phone)
                        .font(AppFont.body)
                        .foregroundStyle(AppColor.baseText)
                        .lineLimit(1)
                }
                Spacer()
            }
        }.padding()
            .background(AppColor.first)
            .clipShape(RoundedRectangle(cornerRadius: 25))
    }
}

#Preview {
    AgentView(agent:  .init(name: "2389903290", phone: "79839832", descrition: "2139873", photo: Image("Avatar"), id: 456787456))
}
