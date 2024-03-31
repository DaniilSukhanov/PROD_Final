//
//  LoadingView.swift
//  TabBed
//
//  Created by Даниил Суханов on 31.03.2024.
//

import SwiftUI

struct LoadingView<T, ContentView: View>: View {
    let isLoading: Bool
    let model: T?
    let content: (T) -> ContentView
    
    init(isLoading: Bool, model: T?, content: @escaping (T) -> ContentView) {
        self.isLoading = isLoading
        self.model = model
        self.content = content
    }
    
    @ViewBuilder var body: some View {
        if isLoading {
            ProgressView()
                .tint(AppColor.second)
            
        } else if let model {
            content(model)
        } else {
            Text("error")
        }
    }
    
}

#Preview {
    let model: ShortlyInfoMeetingModel? = nil
    return ZStack {
        AppColor.backgroud
            .ignoresSafeArea()
        LoadingView(isLoading: false, model: model) { model in
            Text("test")
        }
    }
}
