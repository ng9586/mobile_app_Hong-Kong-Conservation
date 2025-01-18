import SwiftUI

class Imageicon: ObservableObject {
    
    @Published private var classifier = Classifier()
    
    var object: String? {
        classifier.object
    }
    
    var category: String? {
        classifier.category
    }
    
}
