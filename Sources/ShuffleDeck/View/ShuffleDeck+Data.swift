import Utils
import SwiftUI

extension ShuffleDeck {
    internal func leftDataElement(_ offset: Int) -> Data.Element? {
        switch style {
        case .infiniteShuffle:
            return data.previousElement(forLoop: index, offset: offset)
        case .finiteShuffle:
            return data.previousElement(forUnloop: index, offset: offset)
        }
    }

    internal func rightDataElement(_ offset: Int) -> Data.Element? {
        switch style {
        case .infiniteShuffle:
            return data.nextElement(forLoop: index, offset: offset)
        case .finiteShuffle:
            return data.nextElement(forUnloop: index, offset: offset)
        }
    }
}
