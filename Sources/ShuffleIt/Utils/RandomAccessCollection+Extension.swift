import Foundation

extension RandomAccessCollection {
    /// A method that returns the upcoming index based on the current index and offset.
    func nextIndex(_ index: Index, offset: Int) -> Index {
        self.index(index, offsetBy: offset, limitedBy: self.index(before: endIndex)) ?? self.index(startIndex, offsetBy: offset - self.distance(from: index, to: endIndex))
    }
    
    /// A method that returns the previous index based on the current index and offset.
    func previousIndex(_ index: Index, offset: Int) -> Index {
        self.index(index, offsetBy: -offset, limitedBy: startIndex) ?? self.index(endIndex, offsetBy:  self.distance(from: startIndex, to: index) - offset)
    }
    
    /// A method that returns the upcoming element based on the current index and offset.
    func nextElement(_ index: Index, offset: Int) -> Element {
        self[nextIndex(index, offset: offset)]
    }
    
    /// A method that returns the previous element based on the current index and offset.
    func previousElement(_ index: Index, offset: Int) -> Element {
        self[previousIndex(index, offset: offset)]
    }
    
    /// A method that returns the upcoming index based on the current index and offset.
    func nextIndex(_ index: Index, offset: Int) -> Index? {
        self.index(index, offsetBy: offset, limitedBy: self.index(before: endIndex))
    }
    
    /// A method that returns the previous index based on the current index and offset.
    func previousIndex(_ index: Index, offset: Int) -> Index? {
        self.index(index, offsetBy: -offset, limitedBy: startIndex)
    }
    
    /// A method that returns the upcoming element based on the current index and offset.
    func nextElement(_ index: Index, offset: Int) -> Element? {
        guard let index = nextIndex(index, offset: offset) else { return nil }
        return self[index]
    }
    
    /// A method that returns the previous element based on the current index and offset.
    func previousElement(_ index: Index, offset: Int) -> Element? {
        guard let index = previousIndex(index, offset: offset) else { return nil }
        return self[index]
    }
}
