import XCTest
import Combine
import SwiftUI
import ViewInspector
@testable import ShuffleIt_Test

final class ShuffleStackGestureTests: BaseTestCase {
    
    func testShuffleStackDragGestureUpdating() throws {
        let view = ShuffleStack(colors, initialIndex: 4) { color in
            ColorView(color: color)
        }
        let exp1 = view.inspection.inspect(after: 0.1) { view in
            let sut = try view.actualView()
            let main = try sut.inspect().find(ViewType.ZStack.self).find(ViewType.Group.self).view(ColorView.self, 2)
            let gesture = try main.gesture(DragGesture.self)
            let value = DragGesture.Value(
                time: .now,
                location: .init(x: -sut.size.width * 0.3, y: 400),
                startLocation: .init(x: 0, y: 400),
                velocity: .init(dx: 0.2, dy: 0.2)
            )
            var state = false
            var transaction = Transaction()
            try gesture.callUpdating(value: value, state: &state, transaction: &transaction)
            XCTAssertTrue(state)
        }
        ViewHosting.host(
            view: view
            .shuffleAnimation(.easeIn),
            size: .init(width: 300, height: 800)
        )
        self.wait(for: [exp1], timeout: 0.2)
    }
    
    func testShuffleStackDragGestureOnChangedWithRightDirection() throws {
        let view = ShuffleStack(colors, initialIndex: 4) { color in
            ColorView(color: color)
        }
        let exp1 = view.inspection.inspect(after: 0.1) { view in
            let sut = try view.actualView()
            let main = try sut.inspect().find(ViewType.ZStack.self).find(ViewType.Group.self).view(ColorView.self, 2)
            let gesture = try main.gesture(DragGesture.self)
            let value = DragGesture.Value(
                time: .now,
                location: .init(x: -sut.size.width * 0.3, y: 400),
                startLocation: .init(x: 0, y: 400),
                velocity: .init(dx: 0.2, dy: 0.2)
            )
            try gesture.callOnChanged(value: value)
        }
        let exp2 = view.inspection.inspect(after: 0.2) { view in
            let sut = try view.actualView()
            let width = 300 - sut.padding * 2 - sut.offset * 2
            XCTAssertEqual(sut.direction, .right)
            XCTAssertEqual(sut.translation, sut.xPosition / width * 2)
        }
        ViewHosting.host(
            view: view
            .shuffleAnimation(.easeIn),
            size: .init(width: 300, height: 800)
        )
        self.wait(for: [exp1, exp2], timeout: 0.3)
    }
    
    func testShuffleStackDragGestureOnChangedWithLeftDirection() throws {
        let view = ShuffleStack(colors, initialIndex: 4) { color in
            ColorView(color: color)
        }
        let exp1 = view.inspection.inspect(after: 0.1) { view in
            let sut = try view.actualView()
            let main = try sut.inspect().find(ViewType.ZStack.self).find(ViewType.Group.self).view(ColorView.self, 2)
            let gesture = try main.gesture(DragGesture.self)
            let value = DragGesture.Value(
                time: .now,
                location: .init(x: sut.size.width * 0.3, y: 400),
                startLocation: .init(x: 0, y: 400),
                velocity: .init(dx: 0.2, dy: 0.2)
            )
            try gesture.callOnChanged(value: value)
        }
        let exp2 = view.inspection.inspect(after: 0.2) { view in
            let sut = try view.actualView()
            let width = 300 - sut.padding * 2 - sut.offset * 2
            XCTAssertEqual(sut.direction, .left)
            XCTAssertEqual(sut.translation, sut.xPosition / width * 2)
        }
        ViewHosting.host(
            view: view
            .shuffleAnimation(.easeIn),
            size: .init(width: 300, height: 800)
        )
        self.wait(for: [exp1, exp2], timeout: 0.3)
    }
}
