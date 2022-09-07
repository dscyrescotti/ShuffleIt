import Foundation

extension RandomAccessCollection where Index == Int {
    /// A method that returns the upcoming index based on the current index and offset.
    func nextIndex(_ index: Index, offset: Int) -> Index {
        precondition(offset > 0)
        return self.index(index, offsetBy: 1 * offset, limitedBy: endIndex - 1) ?? startIndex + offset - 1
    }
    
    /// A method that returns the previous index based on the current index and offset.
    func previousIndex(_ index: Index, offset: Int) -> Index {
        precondition(offset > 0)
        return self.index(index, offsetBy: -1 * offset, limitedBy: startIndex) ?? endIndex - 1 * offset
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
