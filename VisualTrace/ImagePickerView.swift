//
//  ImagePickerView.swift
//  VisualTrace
//
//  Created by Leo Ouyang on 6/30/24.
//

import SwiftUI

struct ImagePickerView: View {
    @Binding var showImagePicker: Bool
    @Binding var image: UIImage?
    
    var body: some View {
        ImagePicker(image: $image, isShown: $showImagePicker, sourceType: .photoLibrary)
    }
}

#Preview {
    ImagePickerView(showImagePicker: .constant(false), image: .constant(.init(imageLiteralResourceName: "")))
}
