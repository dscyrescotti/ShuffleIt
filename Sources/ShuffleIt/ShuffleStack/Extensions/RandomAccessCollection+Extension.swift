import Foundation

extension RandomAccessCollection where Index == Int {
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
}
