//
//  ARViewContainer.swift
//  VisualTrace
//
//  Created by Leo Ouyang on 7/2/24.
//

import SwiftUI
import ARKit
import RealityKit

// AR View Container to have the camera on
// Image will be placed over this for the user
struct ARViewContainer: UIViewRepresentable {
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)
        
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.horizontal, .vertical]
        arView.session.run(config)
        
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
        // Update function
    }
}

struct ARViewContainer_Previews: PreviewProvider {
    static var previews: some View {
        ARViewContainer()
    }
}
