//
//  HomePage.swift
//  VisualTrace
//
//  Created by Leo Ouyang on 6/30/24.
//

import SwiftUI

struct HomePage: View {
    @State var isImagePickerShown = false
    @State var isImageTakerShown = false
    @State var selectedImage: UIImage?
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary

    var body: some View {
        NavigationStack {
            VStack (spacing: 15) {
                // title
                Text("VisualTrace")
                    .font(.title)
                    .fontWeight(.bold)
                    .fontDesign(.serif)
                    .padding(.top, 20)
                
                // if an image is selected
                if let image = selectedImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(style: StrokeStyle(lineWidth: 2, dash: [150, 5]))
                                .foregroundColor(Color(red: 0.2, green: 0.2, blue: 0.2, opacity: 0.9))
                        )
                        .cornerRadius(10)
                        .shadow(radius: 10)
                        .padding(.horizontal)
                } else {
                    VStack (spacing: 15) {
                        // logo
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(style: StrokeStyle(lineWidth: 1.5, dash: [120, 5]))
                                .foregroundColor(Color(red: 0.2, green: 0.2, blue: 0.2, opacity: 0.9))
                                .frame(width: 180, height: 180)
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(style: StrokeStyle(lineWidth: 2, dash: [5, 10]))
                                .foregroundColor(Color(red: 0.529, green: 0.553, blue: 0.616, opacity: 0.60))
                                .frame(width: 165, height: 165)
                                .background(Color(red: 0.757, green: 0.765, blue: 0.788, opacity: 0.9))
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(style: StrokeStyle(lineWidth: 1.5, dash: [120, 5]))
                                .foregroundColor(Color(red: 0.2, green: 0.2, blue: 0.2, opacity: 0.9))
                                .frame(width: 150, height: 150)
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(style: StrokeStyle(lineWidth: 1, dash: [1, 5]))
                                .foregroundColor(.black)
                                .frame(width: 165, height: 165)
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(style: StrokeStyle(lineWidth: 3, dash: [1, 5]))
                                .foregroundColor(Color.black)
                                .frame(width: 135, height: 135)
                                .background(Color.white)
                            Text("Vt")
                                .font(Font.system(size: 70))
                                .fontWeight(.semibold)
                                .fontDesign(.serif)
                                .foregroundColor(Color(red: 0.1, green: 0.1, blue: 0.1))
                        }
                        Text("Select an image:")
                            .font(.title2)
                            .fontWeight(.bold)
                            .fontDesign(.serif)
                        // filler border
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(style: StrokeStyle(lineWidth: 1.5, dash: [150, 5]))
                                .foregroundColor(Color(red: 0.2, green: 0.2, blue: 0.2, opacity: 0.9))
                                .frame(width: 300, height: 250)
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(style: StrokeStyle(lineWidth: 2, dash: [1, 5]))
                                .foregroundColor(Color(red: 0.2, green: 0.2, blue: 0.2, opacity: 0.9))
                                .frame(width: 275, height: 225)
                        }
                    }
                    .padding(.bottom)
                }

                // buttons
                HStack (spacing: 20) {
                    // camera button
                    RoundedButton(onPress: {
                        sourceType = .camera
                        isImageTakerShown.toggle()
                    }, icon: "camera")
                        .previewLayout(.sizeThatFits)
                        .transition(.slide.combined(with: .opacity))
                    
                    // check button
                    if selectedImage != nil {
                        NavigationLink(destination: NextPage(selectedImage: selectedImage)) {
                            Text("✓")
                                .frame(width: 80, height: 80)
                                .font(.title)
                                .foregroundColor(Color(red: 0.3, green: 0.3, blue: 0.3))
                                .background(Color(red: 0.957, green: 0.965, blue: 0.988, opacity: 1.0))
                                .clipShape(Circle())
                                .overlay(
                                    Circle()
                                        .stroke(Color(red: 0.1, green: 0.1, blue: 0.1), lineWidth: 1.5)
                                )
                        }
                        .transition(.slide.combined(with: .opacity))
                    }
                    
                    // upload button
                    RoundedButton(onPress: {
                        sourceType = .photoLibrary
                        isImagePickerShown.toggle()
                    }, icon: "tray.and.arrow.up")
                    .transition(.slide.combined(with: .opacity))
                }
                .padding(.bottom)
            }
            .fullScreenCover(isPresented: $isImageTakerShown) {
                ImagePicker(image: $selectedImage, isShown: $isImageTakerShown, sourceType: .camera)
                    .ignoresSafeArea()
            }
            .fullScreenCover(isPresented: $isImagePickerShown) {
                ImagePicker(image: $selectedImage, isShown: $isImagePickerShown, sourceType: .photoLibrary)
                    .ignoresSafeArea()
            }
        }
    }
}

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage()
    }
}
