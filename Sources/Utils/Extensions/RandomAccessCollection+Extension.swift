import Foundation

public extension RandomAccessCollection {
    // MARK: - Loop
    /// A method that returns the upcoming index based on the current index and offset.
    func nextIndex(forLoop index: Index, offset: Int) -> Index? {
        let nextIndex = self.index(index, offsetBy: offset, limitedBy: self.index(before: endIndex)) ?? self.index(startIndex, offsetBy: offset - self.distance(from: index, to: endIndex))
        guard offset != 1 || nextIndex != index else { return nil }
        return nextIndex
    }
    
    /// A method that returns the previous index based on the current index and offset.
    func previousIndex(forLoop index: Index, offset: Int) -> Index? {
        let previousIndex = self.index(index, offsetBy: -offset, limitedBy: startIndex) ?? self.index(endIndex, offsetBy:  self.distance(from: startIndex, to: index) - offset)
        guard offset != 1 || previousIndex != index else { return nil }
        return previousIndex
    }
    
    /// A method that returns the upcoming element based on the current index and offset.
    func nextElement(forLoop index: Index, offset: Int) -> Element? {
        guard let index = nextIndex(forLoop: index, offset: offset) else { return nil }
        return self[safe: index]
    }
    
    /// A method that returns the previous element based on the current index and offset.
    func previousElement(forLoop index: Index, offset: Int) -> Element? {
        guard let index = previousIndex(forLoop: index, offset: offset) else { return nil }
        return self[safe: index]
    }
    
    // MARK: - Unloop
    /// A method that returns the upcoming index based on the current index and offset.
    func nextIndex(_ index: Index, offset: Int) -> Index? {
        self.index(index, offsetBy: offset, limitedBy: self.index(before: endIndex))
    }
    
    /// A method that returns the previous index based on the current index and offset.
    func previousIndex(_ index: Index, offset: Int) -> Index? {
        self.index(index, offsetBy: -offset, limitedBy: startIndex)
    }
    
    /// A method that returns the upcoming element based on the current index and offset.
    func nextElement(forUnloop index: Index, offset: Int) -> Element? {
        guard let index = nextIndex(index, offset: offset) else { return nil }
        return self[safe: index]
    }
    
    /// A method that returns the previous element based on the current index and offset.
    func previousElement(forUnloop index: Index, offset: Int) -> Element? {
        guard let index = previousIndex(index, offset: offset) else { return nil }
        return self[safe: index]
    }
    
    /// A subscript that ensure safety when accessing index out of range.
    subscript(safe index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}
