import Foundation
import MapKit
import SwiftUI

class LocationViewModel: ObservableObject {
    
    // All loaded locations
    @Published var locations: [Location] = []
    
    // Current location on the map (make this optional)
    @Published var mapLocation: Location? {
        didSet {
            if let location = mapLocation {
                updateMapRegion(location: location)
            }
        }
    }
    
    // Current region on the map
    @Published var mapRegion: MKCoordinateRegion = MKCoordinateRegion()
    let mapSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    
    // Show list of locations
    @Published var showLocationList: Bool = false
    
    // Show location details via sheet
    @Published var sheetLocation: Location? = nil
    
    init() {
        let locationData = LocationsDataService.locations
        self.locations = locationData
        
        // Safely set the initial map location
        if let firstLocation = locations.first {
            self.mapLocation = firstLocation
            updateMapRegion(location: firstLocation)
        } else {
            fatalError("No locations available.")
        }
    }
    
    private func updateMapRegion(location: Location) {
        // Ensure this is called within the context of a view update.
        DispatchQueue.main.async {
            withAnimation(.easeInOut) { // Ensure this is used correctly in a UI context
                self.mapRegion = MKCoordinateRegion(center: location.coordinates, span: self.mapSpan)
            }
        }
    }
    
    func toggleLocationList() {
        withAnimation(.easeInOut) {
            showLocationList.toggle()
        }
    }
    
    func selectedLocation(location: Location) {
        withAnimation(.easeInOut) {
            mapLocation = location
            showLocationList = false
        }
    }
    
    func nextButtonAction() {
        guard let currentIndex = locations.firstIndex(where: { $0 == mapLocation }) else { return }
        
        let nextIndex = currentIndex + 1
        
        if nextIndex < locations.count {
            let nextLocation = locations[nextIndex]
            selectedLocation(location: nextLocation)
        } else {
            if let firstLocation = locations.first {
                selectedLocation(location: firstLocation)
            }
        }
    }
}
