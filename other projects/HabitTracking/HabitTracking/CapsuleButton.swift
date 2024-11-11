//
//  CapsuleButton.swift
//  HabitTracking
//
//  Created by jerry on 11/7/24.
//

import SwiftUI

/*
 sample button view
*/
struct CapsuleButton: View {
    
    var title: String
    var backgroundColor: Color = .red
    
    var body: some View {
        
        Text(title)
            .foregroundStyle(.white)
            .frame(width: 100, height: 50)
            .background(backgroundColor)
            .clipShape(Capsule())
    }
}

#Preview {
    CapsuleButton(title: "create")
}
