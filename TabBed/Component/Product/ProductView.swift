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
    @State var isShow = false
    
    var body: some View {
        
        VStack {
            HStack {
                model.image
                    .resizable()
                    .scaledToFit()
                    .frame(height: 60)
                VStack(alignment: .leading) {
                    Link(destination: model.url) {
                        Text(model.name)
                            .font(AppFont.title2.bold())
                            .foregroundStyle(AppColor.baseText)
                    }.environment(\.openURL, OpenURLAction { url in
                        store.dispatch(.clickBanner(model.id))
                        return .systemAction
                    })
                    Text(isShow ? "Скрыть..." : "Подробнее...")
                        .font(AppFont.title3)
                        .foregroundStyle(AppColor.baseText)
                        .onTapGesture {
                            withAnimation {
                                isShow.toggle()
                            }
                        }
                }
            }
            if isShow {
                Divider()
                Text(model.description)
                    .font(AppFont.body)
                    .foregroundStyle(AppColor.baseText)
                    .animation(.easeIn, value: isShow)
            }
        }.padding()
            .background(AppColor.bannerbackgroud)
            .clipShape(RoundedRectangle(cornerRadius: 25))
            .buttonStyle(PlainButtonStyle())
            
    }
}

#Preview {
    ProductView(model: .init(name: "iuhdfsi", id: 3, description: "fhsdhjhjkfdsfdsfsdjdsfjkdjkdjkjkdjkljklsfdsf", image: Image("Avatar"), url: URL(string: "https://yandex.ru/images/search?from=tabbar&text=DatePicker%20closed%20data%20swiftui")!))
}
