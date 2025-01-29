import SwiftUI

struct CameraView: View {
    @StateObject private var classifier = ImageClassifier()
    @State private var uiImage: UIImage?
    @State private var showImagePicker = false
    @State private var useCamera = false // New state variable to determine if using camera or photo library
    
    var body: some View {
        NavigationView {
            VStack {
                if let image = uiImage {
                    ZStack(alignment: .bottom) {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 300, height: 300)
                        
                        if let object = classifier.object, let confidence = classifier.confidence {
                            Text("\(object) - \(String(format: "%.2f", confidence * 100))%")
                                .padding(8)
                                .background(Color.black.opacity(0.7))
                                .foregroundColor(.white)
                                .cornerRadius(5)
                        }
                    }
                } else {
                    Text("Please select an image")
                        .font(.headline)
                }
                
                HStack {
                    Button("Use Camera") {
                        useCamera = true
                        showImagePicker = true
                    }
                    .padding()
                    
                    Button("Select from Library") {
                        useCamera = false
                        showImagePicker = true
                    }
                    .padding()
                }
            }
            .sheet(isPresented: $showImagePicker) {
                ImagePicker(uiImage: $uiImage, isPresenting: $showImagePicker, sourceType: useCamera ? .camera : .photoLibrary)
                    .onDisappear {
                        if let uiImage = uiImage {
                            classifier.detect(uiImage: uiImage) // Call classification method
                        }
                    }
            }
            .navigationTitle("Image Classification")
        }
    }
}

