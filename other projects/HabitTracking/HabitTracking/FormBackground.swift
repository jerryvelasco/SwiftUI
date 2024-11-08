//
//  FormBackground.swift
//  HabitTracking
//
//  Created by jerry on 11/7/24.
//

import SwiftUI

/*
 styling used for the forms 
 */
struct FormBackground: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding([.top, .bottom])
            .frame(maxWidth: .infinity)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 25.0))
            .shadow(radius: 15)
    }
}

extension View {
    func FormBackgroundStyle() -> some View {
        modifier(FormBackground())
    }
}
