import SwiftUI
import Combine
import ShuffleIt
import MapKit

struct ShuffleDeckDemoView: View {
    @Environment(\.dismiss) var dismiss
    @State private var region: MKCoordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 0, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 0.09, longitudeDelta: 0.09))
    @State private var landmark: Landmark?

    let landmarks: [Landmark] = .landmarks()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            VStack(alignment: .leading) {
                Text("Captivating Landmarks")
                    .font(.title.bold())
                Text("For Your Next Adventure")
                    .font(.title2.bold())
            }
            .padding()
            ShuffleDeck(
                landmarks,
                initialIndex: 0
            ) { landmark in
                LandmarkCard(landmark: landmark)
            }
            .shuffleDeckAnimation(.easeInOut)
            .shuffleDeckScale(0.5)
            .onShuffleDeck { context in
                let landmark = landmarks[context.index]
                self.landmark = landmark
                withAnimation(.easeInOut) {
                    region.center = landmark.coordinate
                }
            }
            .padding(.vertical)
            VStack(alignment: .leading) {
                Text("View on Map")
                    .font(.headline.bold())
                Map(coordinateRegion: $region, annotationItems: landmarks) { landmark in
                    MapPin(coordinate: landmark.coordinate)
                }
                .cornerRadius(15)
            }
            .padding()
        }
        .overlay(alignment: .topTrailing) {
            Button(action: {
                dismiss()
            }) {
                Image(systemName: "xmark.circle.fill")
                    .font(.largeTitle)
                    .foregroundStyle(.white)
                    .background {
                        Circle()
                            .foregroundColor(.black.opacity(0.4))
                            .padding(4)
                    }
            }
            .buttonStyle(.plain)
            .padding([.top, .horizontal])
        }
        .background {
            if let landmark = landmark {
                GeometryReader { proxy in
                    ZStack {
                        Circle()
                            .scale(1.1, anchor: .bottomTrailing)
                            .position(x: proxy.size.width, y: proxy.size.height / 2.5)
                            .foregroundColor(Color(hex: landmark.background).opacity(0.3))
                        Circle()
                            .scale(0.7, anchor: .bottomTrailing)
                            .position(x: 0, y: proxy.size.height / 1.5)
                            .foregroundColor(Color(hex: landmark.background).opacity(0.45))
                    }
                    .blur(radius: 40)
                    .background(.white)
                    .ignoresSafeArea()
                }
            }
        }
        .onAppear {
            guard let landmark = landmarks.first else { return }
            self.landmark = landmark
            withAnimation(.easeInOut) {
                region.center = landmark.coordinate
            }
        }
    }
}
