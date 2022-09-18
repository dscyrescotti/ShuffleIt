import Foundation

struct Sneaker: Decodable {
    let id: String
    let title: String
    let slogan: String
    let imageName: String
    let theme: SneakerTheme
    let items: [SneakerItem]
}

struct SneakerTheme: Decodable {
    let primary: String
    let secondary: String
    let tertiary: String
    let background: String
    let foreground: String
}

struct SneakerItem: Decodable, Identifiable {
    let id: String
    let imageName: String
    let title: String
    let type: String
    let colorVariants: String
    let price: String
}

extension Array where Element == Sneaker {
    static func sneakers() -> [Sneaker] {
        guard let path = Bundle.main.url(forResource: "Sneakers", withExtension: "json"), let data = try? Data(contentsOf: path), let sneakers = try? JSONDecoder().decode([Sneaker].self, from: data) else { return [] }
        return sneakers
    }
}
