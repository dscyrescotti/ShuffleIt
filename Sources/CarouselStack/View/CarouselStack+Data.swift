import Utils
import SwiftUI

extension CarouselStack {
    /// A property that provides the upcoming element of left side.
    internal func leftDataElement(_ offset: Int) -> Data.Element? {
        switch style {
        case .infiniteScroll:
            return data.previousElement(forLoop: index, offset: offset)
        case .finiteScroll:
            return data.previousElement(forUnloop: index, offset: offset)
        }
    }
    
    /// A property that provides the upcoming element of right side.
    internal func rightDataElement(_ offset: Int) -> Data.Element? {
        switch style {
        case .infiniteScroll:
            return data.nextElement(forLoop: index, offset: offset)
        case .finiteScroll:
            return data.nextElement(forUnloop: index, offset: offset)
        }
    }
}
