import XCTest
import Combine
import SwiftUI
import ViewInspector
@testable import ShuffleIt

final class ShuffleStackShufflingTests: BaseTestCase {
    
    func testShuffleStackSpreadingOut() throws {
        let view = ShuffleStack(colors, initialIndex: 4) { color, _ in
            ColorView(color: color)
        }
        let exp1 = view.inspection.inspect(after: 0.2) { view in
            let sut = try view.actualView()
            let width = 300 - sut.padding * 2 - sut.offset * 2
            XCTAssertEqual(sut.index, 4)
            XCTAssertEqual(sut.xPosition, 0)
            XCTAssertEqual(sut.direction, .left)
            XCTAssertEqual(sut.isLockedLeft, false)
            XCTAssertEqual(sut.isLockedRight, false)
            XCTAssertEqual(sut.size, .init(width: width, height: 200))
            XCTAssertEqual(sut.autoShuffling, false)
            XCTAssertEqual(sut.isActiveGesture, false)
            sut.performSpreadingOut()
        }
        let exp2 = view.inspection.inspect(after: 0.4) { view in
            let sut = try view.actualView()
            let width = 300 - sut.padding * 2 - sut.offset * 2
            let maxSwipeDistance = sut.size.width * 0.25
            XCTAssertEqual(sut.index, 4)
            XCTAssertEqual(sut.xPosition, maxSwipeDistance)
            XCTAssertEqual(sut.direction, .left)
            XCTAssertEqual(sut.isLockedLeft, false)
            XCTAssertEqual(sut.isLockedRight, false)
            XCTAssertEqual(sut.size, .init(width: width, height: 200))
            XCTAssertEqual(sut.autoShuffling, false)
            XCTAssertEqual(sut.isActiveGesture, false)
            sut.direction = .right
            sut.performSpreadingOut()
        }
        let exp3 = view.inspection.inspect(after: 0.55) { view in
            let sut = try view.actualView()
            let width = 300 - sut.padding * 2 - sut.offset * 2
            let maxSwipeDistance = -sut.size.width * 0.25
            XCTAssertEqual(sut.index, 4)
            XCTAssertEqual(sut.xPosition, maxSwipeDistance)
            XCTAssertEqual(sut.direction, .right)
            XCTAssertEqual(sut.isLockedLeft, false)
            XCTAssertEqual(sut.isLockedRight, false)
            XCTAssertEqual(sut.size, .init(width: width, height: 200))
            XCTAssertEqual(sut.autoShuffling, false)
            XCTAssertEqual(sut.isActiveGesture, false)
        }
        ViewHosting.host(view: view, size: .init(width: 300, height: 800))
        self.wait(for: [exp1, exp2, exp3], timeout: 0.7)
    }
    
    func testShuffleStackIncompleteLeftShuffling() throws {
        let view = ShuffleStack(colors, initialIndex: 4) { color, _ in
            ColorView(color: color)
        }
        let exp1 = view.inspection.inspect(after: 0.2) { view in
            let sut = try view.actualView()
            let width = 300 - sut.padding * 2 - sut.offset * 2
            XCTAssertEqual(sut.index, 4)
            XCTAssertEqual(sut.xPosition, 0)
            XCTAssertEqual(sut.direction, .left)
            XCTAssertEqual(sut.isLockedLeft, false)
            XCTAssertEqual(sut.isLockedRight, false)
            XCTAssertEqual(sut.size, .init(width: width, height: 200))
            XCTAssertEqual(sut.autoShuffling, false)
            XCTAssertEqual(sut.isActiveGesture, false)
            sut.performSpreadingOut()
        }
        let exp2 = view.inspection.inspect(after: 0.4) { view in
            let sut = try view.actualView()
            let width = 300 - sut.padding * 2 - sut.offset * 2
            let maxSwipeDistance = sut.size.width * 0.25
            XCTAssertEqual(sut.index, 4)
            XCTAssertEqual(sut.xPosition, maxSwipeDistance)
            XCTAssertEqual(sut.direction, .left)
            XCTAssertEqual(sut.isLockedLeft, false)
            XCTAssertEqual(sut.isLockedRight, false)
            XCTAssertEqual(sut.size, .init(width: width, height: 200))
            XCTAssertEqual(sut.autoShuffling, false)
            XCTAssertEqual(sut.isActiveGesture, false)
            sut.xPosition = sut.size.width * 0.2
            XCTAssertTrue(sut.xPosition < maxSwipeDistance)
            sut.performRestoring()
        }
        let exp3 = view.inspection.inspect(after: 0.6) { view in
            let sut = try view.actualView()
            let width = 300 - sut.padding * 2 - sut.offset * 2
            XCTAssertEqual(sut.index, 4)
            XCTAssertEqual(sut.xPosition, 0)
            XCTAssertEqual(sut.direction, .left)
            XCTAssertEqual(sut.isLockedLeft, false)
            XCTAssertEqual(sut.isLockedRight, false)
            XCTAssertEqual(sut.size, .init(width: width, height: 200))
            XCTAssertEqual(sut.autoShuffling, false)
            XCTAssertEqual(sut.isActiveGesture, false)
        }
        ViewHosting.host(
            view: view
                .shuffleAnimation(.linear),
            size: .init(width: 300, height: 800)
        )
        self.wait(for: [exp1, exp2, exp3], timeout: 0.7)
    }
    
    func testShuffleStackIncompleteRightShuffling() throws {
        let view = ShuffleStack(colors, initialIndex: 4) { color, _ in
            ColorView(color: color)
        }
        let exp1 = view.inspection.inspect(after: 0.2) { view in
            let sut = try view.actualView()
            let width = 300 - sut.padding * 2 - sut.offset * 2
            sut.direction = .right
            XCTAssertEqual(sut.index, 4)
            XCTAssertEqual(sut.xPosition, 0)
            XCTAssertEqual(sut.direction, .right)
            XCTAssertEqual(sut.isLockedLeft, false)
            XCTAssertEqual(sut.isLockedRight, false)
            XCTAssertEqual(sut.size, .init(width: width, height: 200))
            XCTAssertEqual(sut.autoShuffling, false)
            XCTAssertEqual(sut.isActiveGesture, false)
            sut.performSpreadingOut()
        }
        let exp2 = view.inspection.inspect(after: 0.4) { view in
            let sut = try view.actualView()
            let width = 300 - sut.padding * 2 - sut.offset * 2
            let maxSwipeDistance = -sut.size.width * 0.25
            XCTAssertEqual(sut.index, 4)
            XCTAssertEqual(sut.xPosition, maxSwipeDistance)
            XCTAssertEqual(sut.direction, .right)
            XCTAssertEqual(sut.isLockedLeft, false)
            XCTAssertEqual(sut.isLockedRight, false)
            XCTAssertEqual(sut.size, .init(width: width, height: 200))
            XCTAssertEqual(sut.autoShuffling, false)
            XCTAssertEqual(sut.isActiveGesture, false)
            sut.xPosition = -sut.size.width * 0.2
            XCTAssertTrue(sut.xPosition > maxSwipeDistance)
            sut.performRestoring()
        }
        let exp3 = view.inspection.inspect(after: 0.6) { view in
            let sut = try view.actualView()
            let width = 300 - sut.padding * 2 - sut.offset * 2
            XCTAssertEqual(sut.index, 4)
            XCTAssertEqual(sut.xPosition, 0)
            XCTAssertEqual(sut.direction, .right)
            XCTAssertEqual(sut.isLockedLeft, false)
            XCTAssertEqual(sut.isLockedRight, false)
            XCTAssertEqual(sut.size, .init(width: width, height: 200))
            XCTAssertEqual(sut.autoShuffling, false)
            XCTAssertEqual(sut.isActiveGesture, false)
        }
        ViewHosting.host(
            view: view
            .shuffleAnimation(.easeIn),
            size: .init(width: 300, height: 800)
        )
        self.wait(for: [exp1, exp2, exp3], timeout: 0.7)
    }
    
    func testShuffleStackCompleteLeftShuffling() throws {
        let view = ShuffleStack(colors, initialIndex: 4) { color, _ in
            ColorView(color: color)
        }
        let exp1 = view.inspection.inspect(after: 0.2) { view in
            let sut = try view.actualView()
            let width = 300 - sut.padding * 2 - sut.offset * 2
            XCTAssertEqual(sut.index, 4)
            XCTAssertEqual(sut.xPosition, 0)
            XCTAssertEqual(sut.direction, .left)
            XCTAssertEqual(sut.isLockedLeft, false)
            XCTAssertEqual(sut.isLockedRight, false)
            XCTAssertEqual(sut.size, .init(width: width, height: 200))
            XCTAssertEqual(sut.autoShuffling, false)
            XCTAssertEqual(sut.isActiveGesture, false)
            sut.performSpreadingOut()
        }
        let exp2 = view.inspection.inspect(after: 0.4) { view in
            let sut = try view.actualView()
            let width = 300 - sut.padding * 2 - sut.offset * 2
            let maxSwipeDistance = sut.size.width * 0.25
            XCTAssertEqual(sut.index, 4)
            XCTAssertEqual(sut.xPosition, maxSwipeDistance)
            XCTAssertEqual(sut.direction, .left)
            XCTAssertEqual(sut.isLockedLeft, false)
            XCTAssertEqual(sut.isLockedRight, false)
            XCTAssertEqual(sut.size, .init(width: width, height: 200))
            XCTAssertEqual(sut.autoShuffling, false)
            XCTAssertEqual(sut.isActiveGesture, false)
            sut.performRestoring()
        }
        let exp3 = view.inspection.inspect(after: 0.8) { view in
            let sut = try view.actualView()
            let width = 300 - sut.padding * 2 - sut.offset * 2
            XCTAssertEqual(sut.index, 3)
            XCTAssertEqual(sut.xPosition, 0)
            XCTAssertEqual(sut.direction, .right)
            XCTAssertEqual(sut.isLockedLeft, false)
            XCTAssertEqual(sut.isLockedRight, false)
            XCTAssertEqual(sut.size, .init(width: width, height: 200))
            XCTAssertEqual(sut.autoShuffling, false)
            XCTAssertEqual(sut.isActiveGesture, false)
        }
        ViewHosting.host(
            view: view.shuffleAnimation(.easeOut),
            size: .init(width: 300, height: 800)
        )
        self.wait(for: [exp1, exp2, exp3], timeout: 1)
    }
    
    func testShuffleStackCompleteRightShuffling() throws {
        let view = ShuffleStack(colors, initialIndex: 5) { color in
            ColorView(color: color)
        }
        let exp1 = view.inspection.inspect(after: 0.2) { view in
            let sut = try view.actualView()
            let width = 300 - sut.padding * 2 - sut.offset * 2
            sut.direction = .right
            XCTAssertEqual(sut.index, 5)
            XCTAssertEqual(sut.xPosition, 0)
            XCTAssertEqual(sut.direction, .right)
            XCTAssertEqual(sut.isLockedLeft, false)
            XCTAssertEqual(sut.isLockedRight, false)
            XCTAssertEqual(sut.size, .init(width: width, height: 200))
            XCTAssertEqual(sut.autoShuffling, false)
            XCTAssertEqual(sut.isActiveGesture, false)
            sut.performSpreadingOut()
        }
        let exp2 = view.inspection.inspect(after: 0.4) { view in
            let sut = try view.actualView()
            let width = 300 - sut.padding * 2 - sut.offset * 2
            let maxSwipeDistance = -sut.size.width * 0.25
            XCTAssertEqual(sut.index, 5)
            XCTAssertEqual(sut.xPosition, maxSwipeDistance)
            XCTAssertEqual(sut.direction, .right)
            XCTAssertEqual(sut.isLockedLeft, false)
            XCTAssertEqual(sut.isLockedRight, false)
            XCTAssertEqual(sut.size, .init(width: width, height: 200))
            XCTAssertEqual(sut.autoShuffling, false)
            XCTAssertEqual(sut.isActiveGesture, false)
            sut.performRestoring()
        }
        let exp3 = view.inspection.inspect(after: 0.8) { view in
            let sut = try view.actualView()
            let width = 300 - sut.padding * 2 - sut.offset * 2
            XCTAssertEqual(sut.index, 6)
            XCTAssertEqual(sut.xPosition, 0)
            XCTAssertEqual(sut.direction, .left)
            XCTAssertEqual(sut.isLockedLeft, false)
            XCTAssertEqual(sut.isLockedRight, false)
            XCTAssertEqual(sut.size, .init(width: width, height: 200))
            XCTAssertEqual(sut.autoShuffling, false)
            XCTAssertEqual(sut.isActiveGesture, false)
        }
        ViewHosting.host(
            view: view
                .shuffleAnimation(.easeIn),
            size: .init(width: 300, height: 800)
        )
        self.wait(for: [exp1, exp2, exp3], timeout: 1)
    }
    
    func testShuffleStackAutoShufflingToRightWithContext() throws {
        let shuffleTrigger = PassthroughSubject<Direction, Never>()
        let collector = PassthroughSubject<ShuffleContext, Never>()
        let valueSpy = ValueSpy<ShuffleContext>(collector.eraseToAnyPublisher())
        let view = ShuffleStack(colors, initialIndex: 6) { color in
            ColorView(color: color)
        }
        let exp1 = view.inspection.inspect(after: 0.15) { view in
            let sut = try view.actualView()
            XCTAssertTrue(sut.autoShuffling)
            XCTAssertTrue(valueSpy.values.isEmpty)
        }
        let exp2 = view.inspection.inspect(after: 0.7) { view in
            let sut = try view.actualView()
            XCTAssertEqual(sut.direction, .left)
            XCTAssertEqual(sut.index, 0)
            let context = valueSpy.values[0]
            XCTAssertEqual(context.direction, .right)
            XCTAssertEqual(context.index, 0)
            XCTAssertEqual(context.previousIndex, 6)
        }
        ViewHosting.host(
            view: view
                .shuffleAnimation(.easeInOut)
                .shuffleTrigger(on: shuffleTrigger)
                .onShuffle({ [collector] context in
                    collector.send(context)
                }),
            size: .init(width: 300, height: 800)
        )
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
            shuffleTrigger.send(.right)
        }
        self.wait(for: [exp1, exp2], timeout: 0.8)
    }
    
    func testShuffleStackAutoShufflingToLeftWithContext() throws {
        let shuffleTrigger = PassthroughSubject<Direction, Never>()
        let collector = PassthroughSubject<ShuffleContext, Never>()
        let valueSpy = ValueSpy<ShuffleContext>(collector.eraseToAnyPublisher())
        let view = ShuffleStack(colors, initialIndex: 0) { color in
            ColorView(color: color)
        }
        let exp1 = view.inspection.inspect(after: 0.15) { view in
            let sut = try view.actualView()
            XCTAssertTrue(sut.autoShuffling)
            XCTAssertTrue(valueSpy.values.isEmpty)
        }
        let exp2 = view.inspection.inspect(after: 0.7) { view in
            let sut = try view.actualView()
            XCTAssertEqual(sut.direction, .right)
            XCTAssertEqual(sut.index, 6)
            let context = valueSpy.values[0]
            XCTAssertEqual(context.direction, .left)
            XCTAssertEqual(context.index, 6)
            XCTAssertEqual(context.previousIndex, 0)
        }
        ViewHosting.host(
            view: view
                .shuffleTrigger(on: shuffleTrigger)
                .onShuffle({ [collector] context in
                    collector.send(context)
                }),
            size: .init(width: 300, height: 800)
        )
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
            shuffleTrigger.send(.left)
        }
        self.wait(for: [exp1, exp2], timeout: 0.8)
    }
}
