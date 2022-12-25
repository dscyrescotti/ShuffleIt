import XCTest
import SwiftUI
import Combine
import ViewInspector
@testable import ShuffleItForTest

final class CarouselStackShufflingTests: BaseTestCase {
    func testCarouselStackIncompleteLeftSliding() throws {
        let view = CarouselStack(colors, initialIndex: 6) { color in
            ColorView(color: color)
        }
        let exp1 = view.inspection.inspect(after: 0.2) { view in
            let sut = try view.actualView()
            let width = 300 - sut.padding * 2
            XCTAssertEqual(sut.index, 6)
            XCTAssertEqual(sut.xPosition, 0)
            XCTAssertEqual(sut.size, .init(width: width, height: 200))
            XCTAssertEqual(sut.direction, .left)
            XCTAssertEqual(sut.autoSliding, false)
            XCTAssertEqual(sut.isActiveGesture, false)
            XCTAssertNil(sut.rightDataElement(1))
            sut.performMovingToMiddle()
        }
        let exp2 = view.inspection.inspect(after: 0.4) { view in
            let sut = try view.actualView()
            let width = 300 - sut.padding * 2
            let maxSlideDistance = sut.size.width * 0.6
            XCTAssertEqual(sut.index, 6)
            XCTAssertEqual(sut.xPosition, maxSlideDistance)
            XCTAssertEqual(sut.direction, .left)
            XCTAssertEqual(sut.size, .init(width: width, height: 200))
            XCTAssertEqual(sut.autoSliding, false)
            XCTAssertEqual(sut.isActiveGesture, false)
            sut.xPosition = sut.size.width * 0.2
            XCTAssertTrue(sut.xPosition < maxSlideDistance)
            sut.performRestoring()
        }
        let exp3 = view.inspection.inspect(after: 0.6) { view in
            let sut = try view.actualView()
            let width = 300 - sut.padding * 2
            XCTAssertEqual(sut.index, 6)
            XCTAssertEqual(sut.xPosition, 0)
            XCTAssertEqual(sut.size, .init(width: width, height: 200))
            XCTAssertEqual(sut.direction, .left)
            XCTAssertEqual(sut.autoSliding, false)
            XCTAssertEqual(sut.isActiveGesture, false)
        }
        ViewHosting.host(
            view: view
                .carouselAnimation(.easeIn),
            size: .init(width: 300, height: 800)
        )
        self.wait(for: [exp1, exp2, exp3], timeout: 0.7)
    }
    
    func testCarouselStackIncompleteRightSliding() throws {
        let view = CarouselStack(colors, initialIndex: 0) { color in
            ColorView(color: color)
        }
        let exp1 = view.inspection.inspect(after: 0.2) { view in
            let sut = try view.actualView()
            sut.direction = .right
            let width = 300 - sut.padding * 2
            XCTAssertEqual(sut.index, 0)
            XCTAssertEqual(sut.xPosition, 0)
            XCTAssertEqual(sut.size, .init(width: width, height: 200))
            XCTAssertEqual(sut.direction, .right)
            XCTAssertEqual(sut.autoSliding, false)
            XCTAssertEqual(sut.isActiveGesture, false)
            XCTAssertNil(sut.leftDataElement(1))
            sut.performMovingToMiddle()
        }
        let exp2 = view.inspection.inspect(after: 0.4) { view in
            let sut = try view.actualView()
            let width = 300 - sut.padding * 2
            let maxSlideDistance = sut.size.width * 0.6
            XCTAssertEqual(sut.index, 0)
            XCTAssertEqual(sut.xPosition, -maxSlideDistance)
            XCTAssertEqual(sut.direction, .right)
            XCTAssertEqual(sut.size, .init(width: width, height: 200))
            XCTAssertEqual(sut.autoSliding, false)
            XCTAssertEqual(sut.isActiveGesture, false)
            sut.xPosition = -sut.size.width * 0.2
            XCTAssertTrue(sut.xPosition < maxSlideDistance)
            sut.performRestoring()
        }
        let exp3 = view.inspection.inspect(after: 0.6) { view in
            let sut = try view.actualView()
            let width = 300 - sut.padding * 2
            XCTAssertEqual(sut.index, 0)
            XCTAssertEqual(sut.xPosition, 0)
            XCTAssertEqual(sut.size, .init(width: width, height: 200))
            XCTAssertEqual(sut.direction, .right)
            XCTAssertEqual(sut.autoSliding, false)
            XCTAssertEqual(sut.isActiveGesture, false)
        }
        ViewHosting.host(
            view: view
                .carouselAnimation(.easeInOut),
            size: .init(width: 300, height: 800)
        )
        self.wait(for: [exp1, exp2, exp3], timeout: 0.7)
    }
    
    func testCarouselStackCompleteLeftSliding() throws {
        let view = CarouselStack(colors, initialIndex: 6) { color in
            ColorView(color: color)
        }
        let exp1 = view.inspection.inspect(after: 0.2) { view in
            let sut = try view.actualView()
            let width = 300 - sut.padding * 2
            XCTAssertEqual(sut.index, 6)
            XCTAssertEqual(sut.xPosition, 0)
            XCTAssertEqual(sut.size, .init(width: width, height: 200))
            XCTAssertEqual(sut.direction, .left)
            XCTAssertEqual(sut.autoSliding, false)
            XCTAssertEqual(sut.isActiveGesture, false)
            XCTAssertNil(sut.rightDataElement(1))
            sut.performMovingToMiddle()
        }
        let exp2 = view.inspection.inspect(after: 0.4) { view in
            let sut = try view.actualView()
            let width = 300 - sut.padding * 2
            let maxSlideDistance = sut.size.width * 0.6
            XCTAssertEqual(sut.index, 6)
            XCTAssertEqual(sut.xPosition, maxSlideDistance)
            XCTAssertEqual(sut.direction, .left)
            XCTAssertEqual(sut.size, .init(width: width, height: 200))
            XCTAssertEqual(sut.autoSliding, false)
            XCTAssertEqual(sut.isActiveGesture, false)
            sut.performRestoring()
        }
        let exp3 = view.inspection.inspect(after: 0.7) { view in
            let sut = try view.actualView()
            let width = 300 - sut.padding * 2
            XCTAssertEqual(sut.index, 5)
            XCTAssertEqual(sut.xPosition, 0)
            XCTAssertEqual(sut.size, .init(width: width, height: 200))
            XCTAssertEqual(sut.direction, .right)
            XCTAssertEqual(sut.autoSliding, false)
            XCTAssertEqual(sut.isActiveGesture, false)
        }
        ViewHosting.host(
            view: view
                .carouselAnimation(.easeIn),
            size: .init(width: 300, height: 800)
        )
        self.wait(for: [exp1, exp2, exp3], timeout: 0.8)
    }
    
    func testCarouselStackCompleteRightSliding() throws {
        let view = CarouselStack(colors, initialIndex: 0) { color in
            ColorView(color: color)
        }
        let exp1 = view.inspection.inspect(after: 0.2) { view in
            let sut = try view.actualView()
            let width = 300 - sut.padding * 2
            sut.direction = .right
            XCTAssertEqual(sut.index, 0)
            XCTAssertEqual(sut.xPosition, 0)
            XCTAssertEqual(sut.size, .init(width: width, height: 200))
            XCTAssertEqual(sut.direction, .right)
            XCTAssertEqual(sut.autoSliding, false)
            XCTAssertEqual(sut.isActiveGesture, false)
            XCTAssertNil(sut.leftDataElement(1))
            sut.performMovingToMiddle()
        }
        let exp2 = view.inspection.inspect(after: 0.4) { view in
            let sut = try view.actualView()
            let width = 300 - sut.padding * 2
            let maxSlideDistance = sut.size.width * 0.6
            XCTAssertEqual(sut.index, 0)
            XCTAssertEqual(sut.xPosition, -maxSlideDistance)
            XCTAssertEqual(sut.direction, .right)
            XCTAssertEqual(sut.size, .init(width: width, height: 200))
            XCTAssertEqual(sut.autoSliding, false)
            XCTAssertEqual(sut.isActiveGesture, false)
            sut.performRestoring()
        }
        let exp3 = view.inspection.inspect(after: 0.7) { view in
            let sut = try view.actualView()
            let width = 300 - sut.padding * 2
            XCTAssertEqual(sut.index, 1)
            XCTAssertEqual(sut.xPosition, 0)
            XCTAssertEqual(sut.size, .init(width: width, height: 200))
            XCTAssertEqual(sut.direction, .left)
            XCTAssertEqual(sut.autoSliding, false)
            XCTAssertEqual(sut.isActiveGesture, false)
        }
        ViewHosting.host(
            view: view
                .carouselAnimation(.linear),
            size: .init(width: 300, height: 800)
        )
        self.wait(for: [exp1, exp2, exp3], timeout: 0.8)
    }
    
    func testCarouselStackAutoSlidingToLeftWithContext() throws {
        let slideTrigger = PassthroughSubject<CarouselDirection, Never>()
        let collector = PassthroughSubject<CarouselContext, Never>()
        let valueSpy = ValueSpy<CarouselContext>(collector.eraseToAnyPublisher())
        let view = CarouselStack(colors, initialIndex: 0) { color in
            ColorView(color: color)
        }
        let exp1 = view.inspection.inspect(after: 0.15) { view in
            let sut = try view.actualView()
            XCTAssertTrue(sut.autoSliding)
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
                .carouselStyle(.infiniteScroll)
                .carouselTrigger(on: slideTrigger)
                .carouselAnimation(.easeOut)
                .onCarousel({ [collector] context in
                    collector.send(context)
                }),
            size: .init(width: 300, height: 800)
        )
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
            slideTrigger.send(.left)
        }
        self.wait(for: [exp1, exp2], timeout: 0.8)
    }
    
    func testCarouselStackAutoSlidingToRightWithContext() throws {
        let slideTrigger = PassthroughSubject<CarouselDirection, Never>()
        let collector = PassthroughSubject<CarouselContext, Never>()
        let valueSpy = ValueSpy<CarouselContext>(collector.eraseToAnyPublisher())
        let view = CarouselStack(colors, initialIndex: 0) { color in
            ColorView(color: color)
        }
        let exp1 = view.inspection.inspect(after: 0.15) { view in
            let sut = try view.actualView()
            XCTAssertTrue(sut.autoSliding)
            XCTAssertTrue(valueSpy.values.isEmpty)
        }
        let exp2 = view.inspection.inspect(after: 0.7) { view in
            let sut = try view.actualView()
            XCTAssertEqual(sut.direction, .left)
            XCTAssertEqual(sut.index, 1)
            let context = valueSpy.values[0]
            XCTAssertEqual(context.direction, .right)
            XCTAssertEqual(context.index, 1)
            XCTAssertEqual(context.previousIndex, 0)
        }
        ViewHosting.host(
            view: view
                .carouselStyle(.infiniteScroll)
                .carouselTrigger(on: slideTrigger)
                .carouselAnimation(.easeOut)
                .onCarousel({ [collector] context in
                    collector.send(context)
                }),
            size: .init(width: 300, height: 800)
        )
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
            slideTrigger.send(.right)
        }
        self.wait(for: [exp1, exp2], timeout: 0.8)
    }
    
    func testInfiniteCarouselStackAutoSlidingCancelled() throws {
        let slideTrigger = PassthroughSubject<CarouselDirection, Never>()
        let collector = PassthroughSubject<CarouselContext, Never>()
        let valueSpy = ValueSpy<CarouselContext>(collector.eraseToAnyPublisher())
        let view = CarouselStack(colors.dropLast(6), initialIndex: 0) { color in
            ColorView(color: color)
        }
        let exp = view.inspection.inspect(after: 0.15) { view in
            let sut = try view.actualView()
            XCTAssertFalse(sut.autoSliding)
            XCTAssertTrue(valueSpy.values.isEmpty)
            XCTAssertEqual(sut.xPosition, 0)
            XCTAssertEqual(sut.index, 0)
        }
        ViewHosting.host(
            view: view
                .carouselStyle(.infiniteScroll)
                .carouselTrigger(on: slideTrigger)
                .carouselAnimation(.easeOut)
                .onCarousel({ [collector] context in
                    collector.send(context)
                }),
            size: .init(width: 300, height: 800)
        )
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
            slideTrigger.send(.left)
            slideTrigger.send(.left)
        }
        self.wait(for: [exp], timeout: 0.8)
    }
    
    func testFiniteCarouselStackAutoSlidingCancelled() throws {
        let slideTrigger = PassthroughSubject<CarouselDirection, Never>()
        let collector = PassthroughSubject<CarouselContext, Never>()
        let valueSpy = ValueSpy<CarouselContext>(collector.eraseToAnyPublisher())
        let view = CarouselStack(colors.dropLast(6), initialIndex: 0) { color in
            ColorView(color: color)
        }
        let exp = view.inspection.inspect(after: 0.15) { view in
            let sut = try view.actualView()
            XCTAssertFalse(sut.autoSliding)
            XCTAssertTrue(valueSpy.values.isEmpty)
            XCTAssertEqual(sut.xPosition, 0)
            XCTAssertEqual(sut.index, 0)
        }
        ViewHosting.host(
            view: view
                .carouselStyle(.finiteScroll)
                .carouselTrigger(on: slideTrigger)
                .carouselAnimation(.easeOut)
                .onCarousel({ [collector] context in
                    collector.send(context)
                }),
            size: .init(width: 300, height: 800)
        )
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
            slideTrigger.send(.left)
            slideTrigger.send(.right)
        }
        self.wait(for: [exp], timeout: 0.8)
    }
}
