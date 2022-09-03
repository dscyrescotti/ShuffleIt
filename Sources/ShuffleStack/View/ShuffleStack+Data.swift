import SwiftUI

// MARK: - Data Element
extension ShuffleStack {
    internal var leftDataElement: Data.Element {
        isLockedLeft ? data.nextElement(index, offset: 2) : data.previousElement(index, offset: 1)
    }
    
    internal var rightDataElement: Data.Element {
        isLockedRight ? data.previousElement(index, offset: 2) : data.nextElement(index, offset: 1)
    }
}
