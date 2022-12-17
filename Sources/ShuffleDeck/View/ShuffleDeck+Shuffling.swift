import Utils
import SwiftUI

extension ShuffleDeck {
    internal func performRestoring() {
        #warning("TODO: implement programmatic restore its child views' positions.")
        xPosition = 0
    }

    internal var translation: CGFloat {
        return size.width > 0 ? xPosition / (size.width * 0.5) : 0
    }
}
