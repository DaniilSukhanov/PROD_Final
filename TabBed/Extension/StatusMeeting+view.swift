//
//  StatusMeeting+view.swift
//  TabBed
//
//  Created by Даниил Суханов on 31.03.2024.
//

import Foundation

import SwiftUI

extension StatusMeeting {
    @ViewBuilder var view: some View {
        switch self {
        case .active:
            Text("Активно")
                .foregroundStyle(AppColor.active)
        case .cancel:
            Text("Отменнено")
                .foregroundStyle(AppColor.cancled)
        case .completed:
            Text("Завершенно")
                .foregroundStyle(AppColor.complited)
        }
   }
}
