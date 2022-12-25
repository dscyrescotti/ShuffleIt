import Utils
import SwiftUI

extension ShuffleDeck {
    /// A method that generates the upcoming element of left side.
    internal func leftDataElement(_ offset: Int) -> Data.Element? {
        switch style {
        case .infiniteShuffle:
            return data.previousElement(forLoop: index, offset: offset)
        case .finiteShuffle:
            return data.previousElement(forUnloop: index, offset: offset)
        }
    }

    /// A method that generates the upcoming element of right side.
    internal func rightDataElement(_ offset: Int) -> Data.Element? {
        switch style {
        case .infiniteShuffle:
            return data.nextElement(forLoop: index, offset: offset)
        case .finiteShuffle:
            return data.nextElement(forUnloop: index, offset: offset)
        }
    }
}
