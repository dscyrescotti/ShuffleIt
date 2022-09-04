import Foundation

struct Sneaker: Decodable, Identifiable {
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
