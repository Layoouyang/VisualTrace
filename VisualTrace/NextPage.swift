//
//  NextPage.swift
//  VisualTrace
//
//  Created by Leo Ouyang on 7/2/24.
//

import SwiftUI

// Page that user uses

struct NextPage: View {
    var selectedImage: UIImage?

    @Environment(\.presentationMode) var presentationMode
    @State private var isEditing = false
    @GestureState private var gestureScale: CGFloat = 1.0
    @State private var finalScale: CGFloat = 1.0
    @State private var initialScale: CGFloat = 1.0
    @State private var offset: CGSize = .zero
    @GestureState private var dragOffset: CGSize = .zero
    @State private var initialOffset: CGSize = .zero
    @State private var opacityValue: Double = 1.0
    @State private var initialOpacity: Double = 1.0

    var body: some View {
        ZStack {
            ARViewContainer()
                .edgesIgnoringSafeArea(.all)
            
            // Places the image over the AR View Container
            // Centered and scaled; can be edited
            if let image = selectedImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 400, height: 400)
                    .scaleEffect(finalScale * gestureScale)
                    .offset(x: offset.width + dragOffset.width, y: offset.height + dragOffset.height)
                    .opacity(opacityValue)
                    .gesture(
                        isEditing ?
                        SimultaneousGesture(
                            MagnificationGesture()
                                .updating($gestureScale) { value, state, _ in
                                    state = value
                                }
                                .onEnded { value in
                                    finalScale *= value
                                },
                            DragGesture()
                                .updating($dragOffset) { value, state, _ in
                                    state = value.translation
                                }
                                .onEnded { value in
                                    offset.width += value.translation.width
                                    offset.height += value.translation.height
                                }
                        )
                        : nil
                    )
                    .padding()
            }

            VStack {
                HStack {
                    // Back button
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .frame(width: 44, height: 44)
                            .background(Color.white.opacity(0.8))
                            .clipShape(Circle())
                            .shadow(radius: 4)
                    }
                    .padding(.leading, 35)
                    .padding(.top, 15)

                    Spacer()
                    
                    // Cancel user changes
                    if isEditing {
                        Button(action: {
                            // Reset to initial values before current edit
                            finalScale = initialScale
                            offset = initialOffset
                            opacityValue = initialOpacity
                            isEditing.toggle() // Exit editing mode
                        }) {
                            Image(systemName: "xmark")
                                .frame(width: 44, height: 44)
                                .background(Color.white.opacity(0.8))
                                .clipShape(Circle())
                                .shadow(radius: 4)
                                .transition(.opacity)
                        }
                        .padding(.trailing, 15)
                        .padding(.top, 15)
                    }

                    // Pencil button allows used to edit
                    // Checkmark button saves edits
                    Button(action: {
                        if isEditing {
                            finalScale *= gestureScale
                            // Update initial values after editing
                            initialScale = finalScale
                            initialOffset = offset
                            initialOpacity = opacityValue
                        }
                        isEditing.toggle()
                    }) {
                        Image(systemName: isEditing ? "checkmark" : "pencil")
                            .frame(width: 44, height: 44)
                            .background(Color.white.opacity(0.8))
                            .clipShape(Circle())
                            .shadow(radius: 4)
                    }
                    .padding(.trailing, 35)
                    .padding(.top, 15)
                }

                Spacer()

                // Toggles the opacity of the image
                HStack {
                    Slider(value: $opacityValue, in: 0.0...1.0)
                        .padding(.horizontal, 40)
                }
                .opacity(isEditing ? 1.0 : 0.0)
            }
        }
        .onAppear {
            // Initialize initial values
            initialScale = finalScale
            initialOffset = offset
            initialOpacity = opacityValue
        }
        .navigationBarHidden(true)
    }
}

struct NextPage_Previews: PreviewProvider {
    static var previews: some View {
        NextPage(selectedImage: UIImage(named: "exampleImage"))
    }
}
