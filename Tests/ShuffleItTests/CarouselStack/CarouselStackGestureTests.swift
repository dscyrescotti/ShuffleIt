import XCTest
import Combine
import SwiftUI
import ViewInspector
@testable import ShuffleItForTest

#if !os(tvOS)
final class CarouselStackGestureTests: BaseTestCase {
    func testCarouselStackDragGestureUpdating() throws {
        let view = CarouselStack(colors, initialIndex: 4) { color in
            ColorView(color: color)
        }
        let exp = view.inspection.inspect(after: 0.1) { view in
            let sut = try view.actualView()
            let content = try sut.inspect().find(ViewType.ZStack.self).view(ColorView.self, 2)
            let gesture = try content.gesture(DragGesture.self)
            let value = DragGesture.Value(
                time: .now,
                location: .init(x: -sut.size.width * 0.5, y: 400),
                startLocation: .init(x: 0, y: 400),
                velocity: .init(dx: 0.2, dy: 0.2)
            )
            var state = false
            var transaction = Transaction()
            try gesture.callUpdating(value: value, state: &state, transaction: &transaction)
            XCTAssertTrue(state)
        }
        ViewHosting.host(view: view)
        self.wait(for: [exp], timeout: 0.2)
    }
    
    func testCarouselStackDragGestureOnChangedWithRightDirection() throws {
        let view = CarouselStack(colors, initialIndex: 4) { color in
            ColorView(color: color)
        }
        let exp1 = view.inspection.inspect(after: 0.1) { view in
            let sut = try view.actualView()
            let content = try sut.inspect().find(ViewType.ZStack.self).view(ColorView.self, 2)
            let gesture = try content.gesture(DragGesture.self)
            let value = DragGesture.Value(
                time: .now,
                location: .init(x: -sut.size.width, y: 400),
                startLocation: .init(x: 0, y: 400),
                velocity: .init(dx: 0.2, dy: 0.2)
            )
            try gesture.callOnChanged(value: value)
        }
        let exp2 = view.inspection.inspect(after: 0.2) { view in
            let sut = try view.actualView()
            let width = (300 + sut.spacing * 2) / 2
            let position = abs(sut.xPosition).truncatingRemainder(dividingBy: width)
            XCTAssertEqual(sut.direction, .left)
            XCTAssertEqual(sut.translation, position / width)
        }
        ViewHosting.host(view: view)
        self.wait(for: [exp1, exp2], timeout: 0.3)
    }
    
    func testCarouselStackDragGestureOnChangedWithLeftDirection() throws {
        let view = CarouselStack(colors, initialIndex: 4) { color in
            ColorView(color: color)
        }
        let exp1 = view.inspection.inspect(after: 0.1) { view in
            let sut = try view.actualView()
            let content = try sut.inspect().find(ViewType.ZStack.self).view(ColorView.self, 2)
            let gesture = try content.gesture(DragGesture.self)
            let value = DragGesture.Value(
                time: .now,
                location: .init(x: sut.size.width * 0.5, y: 400),
                startLocation: .init(x: 0, y: 400),
                velocity: .init(dx: 0.2, dy: 0.2)
            )
            try gesture.callOnChanged(value: value)
        }
        let exp2 = view.inspection.inspect(after: 0.2) { view in
            let sut = try view.actualView()
            let width = (300 + sut.spacing * 2) / 2
            let position = abs(sut.xPosition).truncatingRemainder(dividingBy: width)
            XCTAssertEqual(sut.direction, .left)
            XCTAssertEqual(sut.translation, position / width)
        }
        ViewHosting.host(view: view)
        self.wait(for: [exp1, exp2], timeout: 0.3)
    }
}
#endif
