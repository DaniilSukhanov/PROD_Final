//
//  BackButton.swift
//  TabBed
//
//  Created by Даниил Суханов on 01.04.2024.
//

import SwiftUI

struct BackButton: View {
    let action: () -> ()
    
    var body: some View {
        Button(action: action) {
            AppImage.back.foregroundStyle(.gray)
                .font(AppFont.title)
        }.frame(width: 80, height: 80)
    }
}

#Preview {
    BackButton {
        
    }
}
