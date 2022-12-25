import XCTest
import SwiftUI
import ViewInspector
@testable import ShuffleItForTest

final class ShuffleDeckTests: BaseTestCase {
    func testShuffleDeckEnvironmentValues() throws {
        let view = ShuffleDeck(colors, initialIndex: 0) { color in
            ColorView(color: color)
        }
        let exp = view.inspection.inspect { view in
            let sut = try view.actualView()
            XCTAssertEqual(sut.animation, .easeInOut)
            XCTAssertEqual(sut.style, .infiniteShuffle)
            XCTAssertEqual(round(sut.scale * 100) / 100, 0.08)
            #if !os(tvOS)
            XCTAssertEqual(sut.disabled, true)
            #endif
            XCTAssertNotNil(sut.shuffleDeckContext)
            XCTAssertNotNil(sut.translation)
        }
        ViewHosting.host(
            view: view
                .shuffleDeckScale(0.8)
                .shuffleDeckStyle(.infiniteShuffle)
                .shuffleDeckAnimation(.easeInOut)
                #if !os(tvOS)
                .shuffleDeckDisabled(true)
                #endif
                .onShuffleDeck { _ in }
                .onShuffleDeckTranslation { _ in }
        )
        self.wait(for: [exp], timeout: 0.2)
    }

    func testShuffleDeckStates() throws {
        let view = ShuffleDeck(colors) { color in
            ColorView(color: color)
        }
        let exp = view.inspection.inspect(after: 0.2) { view in
            let sut = try view.actualView()
            let width = 300
            XCTAssertEqual(sut.index, 0)
            XCTAssertEqual(sut.xPosition, 0)
            XCTAssertEqual(sut.direction, .left)
            XCTAssertEqual(sut.size, .init(width: width, height: 200))
            XCTAssertEqual(sut.autoShuffling, false)
            XCTAssertEqual(sut.isActiveGesture, false)
        }
        ViewHosting.host(view: view, size: .init(width: 300, height: 800))
        self.wait(for: [exp], timeout: 0.5)
    }

    #if !os(tvOS)
    func testShuffleDeckDisabled() throws {
        let view = ShuffleDeck(colors, initialIndex: 0) { color, _ in
            ColorView(color: color)
        }
        let exp = view.inspection.inspect(after: 0.1) { view in
            let sut = try view.actualView()
            XCTAssertEqual(sut.style, .finiteShuffle)
            let index = try sut.inspect().find(ViewType.ZStack.self).count - 1
            let content = try sut.inspect().find(ViewType.ZStack.self).view(ColorView.self, index)
            XCTAssertThrowsError(try content.gesture(DragGesture.self))
        }
        ViewHosting.host(
            view: view
                .shuffleDeckDisabled(true)
                .shuffleDeckStyle(.finiteShuffle),
            size: .init(width: 300, height: 800)
        )
        self.wait(for: [exp], timeout: 0.3)
    }
    #endif
}
