//
//  NavigationConfigurator.swift
//  TabBed
//
//  Created by Даниил Суханов on 02.04.2024.
//

import SwiftUI

struct NavigationConfigurator: UIViewControllerRepresentable, Equatable {
    static func == (lhs: NavigationConfigurator, rhs: NavigationConfigurator) -> Bool {
        lhs.id == rhs.id
    }
    
    let id = UUID()
    
    var configure: (UINavigationController) -> Void = { _ in }

    func makeUIViewController(context: UIViewControllerRepresentableContext<NavigationConfigurator>) -> UIViewController {
        UIViewController()
    }
    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<NavigationConfigurator>) {
        if let nc = uiViewController.navigationController {
            self.configure(nc)
        }
    }

}
