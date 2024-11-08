//
//  TextFieldView.swift
//  HabitTracking
//
//  Created by jerry on 11/7/24.
//

import SwiftUI

/*
 sample text field view
 */
struct TextFieldView: View {
    
    var title: String = "Description"
    var imageName = "book.pages"
    var frameHeight: CGFloat = 100
    
    @Binding var goalValue: String
    
    //checks if the text field is empty
    var emptyField: Bool {
        if goalValue == "" {
            return true
        }
        return false
    }
    
    var body: some View {
        VStack(alignment:.leading) {
            HStack(alignment: .top) {
                
                Image(systemName: imageName)
                
                TextField(title, text: $goalValue, axis: .vertical)
                    .frame(height: frameHeight, alignment: .top)
                    .lineLimit(5)

            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 10.0))
            .shadow(radius: 10)
            
            Text(emptyField ? "\(title) can't be empty!" : "")
                .font(.caption2)
                .padding(4)
        }
        .padding()
    }
}

#Preview {
    TextFieldView(goalValue: .constant("drink"))
}
