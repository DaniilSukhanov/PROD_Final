//
//  LoadingView.swift
//  TabBed
//
//  Created by Даниил Суханов on 31.03.2024.
//

import SwiftUI

struct LoadingView<T: Any, ContentView: View>: View {
    private let isLoading: Bool
    private let model: T?
    private let content: ((T) -> ContentView)?
    private let shortContent: (() -> ContentView)?
    
    init(isLoading: Bool, model: T?, content: @escaping (T) -> ContentView) {
        self.isLoading = isLoading
        self.model = model
        self.content = content
        self.shortContent = nil
    }
    
    init(isLoading: Bool, model: T? = 0, shortContent: @escaping () -> ContentView) {
        self.isLoading = isLoading
        self.shortContent = shortContent
        self.content = nil
        self.model = nil
    }
    
    @ViewBuilder var body: some View {
        if isLoading {
            ZStack {
                ProgressView()
                    .foregroundStyle(AppColor.second)
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea()
        } else if let model, let content {
            content(model)
        } else if let shortContent {
            shortContent()
        } else {
            EmptyView()
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
