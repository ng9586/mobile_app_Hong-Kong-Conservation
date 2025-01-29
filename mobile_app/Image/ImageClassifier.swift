import Foundation
import UIKit
import Vision
import CoreML

class ImageClassifier: ObservableObject {
    @Published var object: String?
    @Published var confidence: Double?

    func detect(uiImage: UIImage) {
        // Initialize the model with configuration
        guard let model = try? MobileNetV2(configuration: MLModelConfiguration()) else {
            print("Failed to load model")
            return
        }

        // Create a request for the model
        let request = VNCoreMLRequest(model: try! VNCoreMLModel(for: model.model)) { request, error in
            if let error = error {
                print("Error during classification: \(error.localizedDescription)")
                return
            }

            guard let results = request.results as? [VNClassificationObservation] else {
                print("Failed to classify image")
                return
            }

            if let topResult = results.first {
                DispatchQueue.main.async {
                    self.object = topResult.identifier // Set the identified object name
                    self.confidence = Double(topResult.confidence) // Get the confidence level
                }
            }
        }

        guard let ciImage = CIImage(image: uiImage) else {
            print("Failed to convert UIImage to CIImage")
            return
        }

        let handler = VNImageRequestHandler(ciImage: ciImage, options: [:])
        do {
            try handler.perform([request])
        } catch {
            print("Failed to perform classification: \(error)")
        }
    }
}
