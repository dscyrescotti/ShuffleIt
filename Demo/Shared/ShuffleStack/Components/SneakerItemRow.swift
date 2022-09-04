import SwiftUI

struct SneakerItemRow: View {
    let item: SneakerItem
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            Image(item.imageName)
                .resizable()
                .frame(width: 100, height: 100)
                .cornerRadius(16)
            VStack(alignment: .leading, spacing: 5) {
                Text(item.title)
                    .font(.headline)
                    .lineLimit(2)
                HStack(spacing: 5) {
                    Group {
                        Text(item.type)
                        Text(item.colorVariants)
                    }
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(.gray.opacity(0.2))
                    .cornerRadius(10)
                }
                .font(.caption.bold())
                Text(item.price)
                    .font(.subheadline.bold())
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(16)
        .background(.ultraThinMaterial)
        .cornerRadius(16)
    }
}

struct SneakerItemRow_Previews: PreviewProvider {
    static var previews: some View {
        SneakerItemRow(
            item: SneakerItem(
                id: "air-force4",
                imageName: "air-force4",
                title: "Nike Air Force 1 Mid '07 LV8 Next Nature",
                type: "Men's Shoes",
                colorVariants: "1 Color",
                price: "$130"
            )
        )
        .padding()
    }
}
