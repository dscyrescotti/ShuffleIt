import SwiftUI
import ViewInspector

struct ColorView: View {
    let color: Color
    var body: some View {
        color
            .frame(height: 200)
            .cornerRadius(15)
    }
}
