import SwiftUI

struct LandmarkCard: View {
    let landmark: Landmark

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Image(landmark.image)
                .resizable()
            LinearGradient(
                colors: [
                    .clear,
                    .clear,
                    .black.opacity(0.7)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            VStack(alignment: .leading) {
                Text(landmark.name)
                    .font(.title.bold())
                Text(landmark.location)
                    .font(.title3.bold())
            }
            .foregroundColor(.white)
            .padding()
        }
        .frame(width: 300, height: 400)
        .cornerRadius(20)
        .shadow(radius: 10)
    }
}

struct LandmarkCard_Previews: PreviewProvider {
    static var previews: some View {
        LandmarkCard(
            landmark: Landmark(
                id: "shwedagon_pagoda",
                image: "shwedagon_pagoda",
                name: "Shwedagon Pagoda",
                location: "Yangon, Myanmar",
                lat: 0,
                long: 0,
                background: ""
            )
        )
    }
}
