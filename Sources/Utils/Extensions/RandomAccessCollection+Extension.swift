import Foundation

public extension RandomAccessCollection {
    // MARK: - Loop
    /// A method that returns the upcoming index based on the current index and offset.
    func nextIndex(forLoop current: Index, offset: Int) -> Index? {
        let newOffset = (distance(from: startIndex, to: current) + offset) % distance(from: startIndex, to: endIndex)
        return  self.index(startIndex, offsetBy: newOffset, limitedBy: self.index(before: endIndex))
    }
    
    /// A method that returns the previous index based on the current index and offset.
    func previousIndex(forLoop current: Index, offset: Int) -> Index? {
        let length = distance(from: startIndex, to: endIndex)
        let newOffset = (length + distance(from: startIndex, to: current) - (offset % length)) % length
        return  self.index(startIndex, offsetBy: newOffset, limitedBy: self.index(before: endIndex))
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
    func nextIndex(forUnloop index: Index, offset: Int) -> Index? {
        self.index(index, offsetBy: offset, limitedBy: self.index(before: endIndex))
    }
    
    /// A method that returns the previous index based on the current index and offset.
    func previousIndex(forUnloop index: Index, offset: Int) -> Index? {
        self.index(index, offsetBy: -offset, limitedBy: startIndex)
    }
    
    /// A method that returns the upcoming element based on the current index and offset.
    func nextElement(forUnloop index: Index, offset: Int) -> Element? {
        guard let index = nextIndex(forUnloop: index, offset: offset) else { return nil }
        return self[safe: index]
    }
    
    /// A method that returns the previous element based on the current index and offset.
    func previousElement(forUnloop index: Index, offset: Int) -> Element? {
        guard let index = previousIndex(forUnloop: index, offset: offset) else { return nil }
        return self[safe: index]
    }
    
    /// A subscript that ensure safety when accessing index out of range.
    subscript(safe index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}
