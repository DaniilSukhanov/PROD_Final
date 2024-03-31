//
//  View+addBorder.swift
//  TabBed
//
//  Created by Даниил Суханов on 30.03.2024.
//

import Foundation
import SwiftUI

extension View {
    func addBorder<S>(_ content: S, cornerRadius: CGFloat, lineWidth: CGFloat = 1) -> some View where S : ShapeStyle {
        let roundedRect = RoundedRectangle(cornerRadius: cornerRadius)
        return clipShape(roundedRect)
            .overlay {
                roundedRect.strokeBorder(content, lineWidth: lineWidth)
            }
    }
}
