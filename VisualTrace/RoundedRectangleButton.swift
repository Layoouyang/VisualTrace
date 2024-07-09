//
//  RoundedRectangleButton.swift
//  VisualTrace
//
//  Created by Leo Ouyang on 6/30/24.
//

import SwiftUI

struct RoundedRectangleButton: View {
    // Action to execute upon pressing button
    let onPress: () -> Void
  //  var text: LocalizedStringKey
    let buttonText: String
    var body: some View {
        Button(action: onPress) {
                Text(buttonText)
                    .fontWeight(.medium)
                    .foregroundColor(Color(red: 0.529, green: 0.553, blue: 0.616, opacity: 0.60))
                    .frame(width: 120, height: 50)
                    .background(Color(red: 0.957, green: 0.965, blue: 0.988, opacity: 1.0))
                    .cornerRadius(15)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color(red: 0.529, green: 0.553, blue: 0.616, opacity: 0.20), lineWidth: 3)
                    )
                    .font(.headline)
                    .fontDesign(.monospaced)
            }
        }
}

#Preview {
    RoundedRectangleButton(onPress: {print("Button Pressed")}, buttonText: "Retake")
        .previewLayout(.sizeThatFits)
        .padding()
        
}
