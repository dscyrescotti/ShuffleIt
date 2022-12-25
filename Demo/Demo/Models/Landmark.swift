import MapKit
import Foundation

struct Landmark: Decodable, Identifiable {
    let id: String
    let image: String
    let name: String
    let location: String
    let lat: Double
    let long: Double
    let background: String

    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: lat, longitude: long)
    }
}

extension Array where Element == Landmark {
    static func landmarks() -> Self {
        guard let path = Bundle.main.url(forResource: "Landmarks", withExtension: "json"), let data = try? Data(contentsOf: path), let landmarks = try? JSONDecoder().decode([Landmark].self, from: data) else { return [] }
        return landmarks
    }
}
