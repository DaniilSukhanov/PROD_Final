//
//  ProductView.swift
//  TabBed
//
//  Created by Даниил Суханов on 02.04.2024.
//

import SwiftUI

struct ProductView: View {
    @EnvironmentObject var store: Store<RootState, RootAction>
    let model: ProductModel
    @State var isDetail = false
    
    var body: some View {
        
        HStack {
            model.image
                .resizable()
                .scaledToFit()
                .frame(height: 60)
            VStack(alignment: .leading) {
                Text(model.name)
                    .font(AppFont.title2.bold())
                    .foregroundStyle(AppColor.baseText)
                    .multilineTextAlignment(.leading)
                Text(model.description)
                    .font(AppFont.body)
                    .foregroundStyle(AppColor.baseText)
                    .lineLimit(isDetail ? 666 : 1)
                    .multilineTextAlignment(.leading)
                Link("Подробнее...", destination: model.url)
                    .environment(\.openURL, OpenURLAction { url in
                        store.dispatch(.clickBanner(model.id))
                        return .systemAction
                    })
                
            }
        }.padding()
            .background(AppColor.bannerbackgroud)
            .clipShape(RoundedRectangle(cornerRadius: 25))
            .overlay(alignment: .topTrailing) {
                Button {
                    isDetail.toggle()
                } label: {
                    Image(systemName: isDetail ? "chevron.down" : "chevron.up")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .foregroundStyle(AppColor.baseText)
                }.offset(x: -8, y: 8)
            }.animation(.easeInOut, value: isDetail)
            .frame(maxWidth: .infinity)
            
    }
}

#Preview {
    ProductView(model: .init(name: "iuhdfsi", id: 3, description: "fhsdhjhjkfdsfdsfsdjdsfjkdjkdjkjkdjkljklsfdsf", image: Image("Avatar"), url: URL(string: "https://yandex.ru/images/search?from=tabbar&text=DatePicker%20closed%20data%20swiftui")!))
}
