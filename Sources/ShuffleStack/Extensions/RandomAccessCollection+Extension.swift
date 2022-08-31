import Foundation

extension RandomAccessCollection where Index == Int {
    func nextIndex(_ index: Index, offset: Int) -> Index {
        precondition(offset > 0)
        return self.index(index, offsetBy: 1 * offset, limitedBy: endIndex - 1) ?? startIndex + offset - 1
    }
    
    func previousIndex(_ index: Index, offset: Int) -> Index {
        precondition(offset > 0)
        return self.index(index, offsetBy: -1 * offset, limitedBy: startIndex) ?? endIndex - 1 * offset
    }
    
    func nextElement(_ index: Index, offset: Int) -> Element {
        self[nextIndex(index, offset: offset)]
    }
    
    func previousElement(_ index: Index, offset: Int) -> Element {
        self[previousIndex(index, offset: offset)]
    }
}
