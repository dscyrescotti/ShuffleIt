import XCTest
import SwiftUI
import ViewInspector
@testable import ShuffleItForTest

final class CarouselStackTests: BaseTestCase {
    func testCarouselStackEnvironmentValues() throws {
        let view = CarouselStack(colors, initialIndex: 0) { color in
            ColorView(color: color)
        }
        let exp = view.inspection.inspect { view in
            let sut = try view.actualView()
            XCTAssertEqual(sut.animation, .easeInOut)
            XCTAssertEqual(sut.style, .infiniteScroll)
            XCTAssertEqual(sut.spacing, 20)
            XCTAssertEqual(sut.scale, 0.9)
            XCTAssertEqual(sut.padding, 20)
            #if !os(tvOS)
            XCTAssertEqual(sut.disabled, true)
            #endif
            XCTAssertNotNil(sut.carouselContext)
            XCTAssertNotNil(sut.translation)
        }
        ViewHosting.host(
            view: view
                .carouselScale(0.9)
                .carouselSpacing(20)
                .carouselPadding(20)
                #if !os(tvOS)
                .carouselDisabled(true)
                #endif
                .carouselStyle(.infiniteScroll)
                .carouselAnimation(.easeInOut)
                .onCarousel({ _ in })
                .onCarouselTranslation({ _ in })
        )
        self.wait(for: [exp], timeout: 0.2)
    }
    
    func testCarouselStackEnvironmentValuesByDefault() throws {
        let view = CarouselStack(colors, initialIndex: 0) { color in
            ColorView(color: color)
        }
        let exp = view.inspection.inspect { view in
            let sut = try view.actualView()
            XCTAssertEqual(sut.animation, .linear)
            XCTAssertEqual(sut.style, .finiteScroll)
            XCTAssertEqual(sut.spacing, 10)
            XCTAssertEqual(sut.scale, 1)
            XCTAssertEqual(sut.padding, 20)
            #if !os(tvOS)
            XCTAssertEqual(sut.disabled, false)
            #endif
            XCTAssertNil(sut.carouselContext)
            XCTAssertNil(sut.carouselTranslation)
        }
        ViewHosting.host(view: view)
        self.wait(for: [exp], timeout: 0.2)
    }
    
    func testCarouselStackStates() throws {
        let view = CarouselStack(colors) { color in
            ColorView(color: color)
        }
        let exp = view.inspection.inspect(after: 0.2) { view in
            let sut = try view.actualView()
            let width = 300 - sut.padding * 2
            XCTAssertEqual(sut.index, 0)
            XCTAssertEqual(sut.xPosition, 0)
            XCTAssertEqual(sut.direction, .left)
            XCTAssertEqual(sut.size, .init(width: width, height: 200))
            XCTAssertEqual(sut.autoSliding, false)
            XCTAssertEqual(sut.isActiveGesture, false)
        }
        ViewHosting.host(view: view, size: .init(width: 300, height: 800))
        self.wait(for: [exp], timeout: 0.5)
    }
    
    #if !os(tvOS)
    func testCarouselStackDisabled() throws {
        let view = CarouselStack(colors, initialIndex: 0) { color, _ in
            ColorView(color: color)
        }
        let exp = view.inspection.inspect(after: 0.1) { view in
            let sut = try view.actualView()
            XCTAssertEqual(sut.style, .finiteScroll)
            let content = try sut.inspect().find(ViewType.Group.self).find(ViewType.ZStack.self)
            XCTAssertThrowsError(try content.gesture(DragGesture.self))
        }
        ViewHosting.host(
            view: view
                .carouselDisabled(true)
                .carouselStyle(.finiteScroll),
            size: .init(width: 300, height: 800)
        )
        self.wait(for: [exp], timeout: 0.2)
    }
    #endif
}
