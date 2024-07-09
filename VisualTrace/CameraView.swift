//
//  CameraView.swift
//  VisualTrace
//
//  Created by Leo Ouyang on 6/30/24.
//

import SwiftUI

struct CameraView: View {
    @Binding var showCamera: Bool
    @Binding var image: UIImage?
    
    var body: some View {
        ImagePicker(image: $image, isShown: $showCamera, sourceType: .camera)
    }
}

#Preview {
    CameraView(showCamera: .constant(true), image: .constant(nil))
}
