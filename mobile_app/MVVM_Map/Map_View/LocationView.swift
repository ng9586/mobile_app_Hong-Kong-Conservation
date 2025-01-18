import SwiftUI
import MapKit

struct LocationView: View {
    
    @EnvironmentObject var viewModel: LocationViewModel // Access the ViewModel from the environment
    
    var body: some View {
        ZStack {
            mapLayer
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 0) {
                header
                    .padding()
                Spacer()
                locationPreviewStack
            }
        }
        .sheet(item: $viewModel.sheetLocation) { location in
            LocationDetailView(location: location) // Ensure this view is defined correctly
        }
    }

    private var header: some View {
        Button {
            viewModel.toggleLocationList()
        } label: {
            VStack {
                if let currentMapLocation = viewModel.mapLocation { // Safely unwrap mapLocation
                    Text(currentMapLocation.name + ", " + currentMapLocation.cityName)
                        .font(.title2)
                        .fontWeight(.black)
                        .foregroundColor(.primary)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(Color.clear)
                        .overlay(alignment: .leading) {
                            Image(systemName: "arrow.down")
                                .font(.headline)
                                .foregroundColor(.primary)
                                .padding()
                                .rotationEffect(Angle(degrees: viewModel.showLocationList ? 180 : 0))
                        }

                    if viewModel.showLocationList {
                        LocationListView() // Ensure this view is defined correctly
                            .transition(.slide) // Optional transition for better UX
                    }
                } else {
                    Text("No location selected") // Handle case where no location is available
                        .font(.title2)
                        .foregroundColor(.gray)
                }
            }
        }
        .background(.thinMaterial)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.3), radius: 20, x: 0, y: 15)
    }

    private var mapLayer: some View {
        Map(coordinateRegion: $viewModel.mapRegion,
            annotationItems: viewModel.locations) { location in
            MapAnnotation(coordinate: location.coordinates) {
                MapAnnotationView() // Ensure this view is defined correctly
                    .scaleEffect(viewModel.mapLocation == location ? 1 : 0.7)
                    .shadow(radius: 10)
                    .onTapGesture {
                        viewModel.selectedLocation(location: location) // Update selected location in ViewModel
                    }
            }
        }
    }

    private var locationPreviewStack: some View {
        ZStack {
            ForEach(viewModel.locations) { location in
                if viewModel.mapLocation == location {
                    LocationPreviewView(location: location) // Ensure this is defined correctly
                        .shadow(color: Color.black.opacity(0.2), radius: 20)
                        .padding()
                        .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                }
            }
        }
    }
}

struct LocationView_Previews: PreviewProvider {
    static var previews: some View {
        LocationView()
            .environmentObject(LocationViewModel()) // Provide a mock ViewModel for previews
    }
}
