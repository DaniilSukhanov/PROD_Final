//
//  ErrorView.swift
//  TabBed
//
//  Created by Даниил Суханов on 31.03.2024.
//

import SwiftUI

struct ErrorView: View {
    let text: String
    let action: () -> ()
    
    var body: some View {
        ZStack {
            AppColor.backgroud
                .ignoresSafeArea()
            VStack {
                AppImage.lottiError
                    .resizable()
                    .scaledToFit()
                    .colorMultiply(AppColor.invertBaseText)
                Text(text)
                    .font(AppFont.largeTitle)
                    .foregroundStyle(AppColor.invertBaseText)
                    .multilineTextAlignment(.center)
                AppImage.xmark
                    .foregroundStyle(AppColor.invertBaseText)
                    .font(AppFont.title2)
                    .frame(width: 80, height: 80)
                    .onTapGesture {
                        action()
                    }
            }.background(AppColor.secondBackgroud)
                .clipShape(RoundedRectangle(cornerRadius: 25))
        }
    }
}

#Preview {
    ErrorView(text: "qwertyuioiuytre") {
        
    }
}
