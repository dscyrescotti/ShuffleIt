import Foundation
import Combine

class ValueSpy<Value> {
    private(set) var values: [Value] = []
    private var cancellable: AnyCancellable?
    init(_ publisher: AnyPublisher<Value, Never>) {
        self.values = []
        self.cancellable = publisher.sink { [weak self] value in
            self?.values.append(value)
        }
    }
}
