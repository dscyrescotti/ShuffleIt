import XCTest
import Combine
import SwiftUI
import ViewInspector
@testable import ShuffleItForTest

final class ShuffleStackTests: BaseTestCase {
    
    func testShuffleStackEnvironmentValues() throws {
        let view = ShuffleStack(colors, initialIndex: 0) { color in
            ColorView(color: color)
        }
        let exp = view.inspection.inspect { view in
            let sut = try view.actualView()
            XCTAssertEqual(sut.animation, .easeInOut)
            XCTAssertEqual(sut.style, .rotateIn)
            XCTAssertEqual(sut.offset, 20)
            XCTAssertEqual(sut.scale, 0.92)
            XCTAssertEqual(sut.padding, 20)
            #if !os(tvOS)
            XCTAssertEqual(sut.disabled, true)
            #endif
            XCTAssertNotNil(sut.shuffleContext)
            XCTAssertNotNil(sut.translation)
        }
        ViewHosting.host(
            view: view
                .shuffleScale(0.2)
                .shuffleOffset(20)
                .shufflePadding(20)
                #if !os(tvOS)
                .shuffleDisabled(true)
                #endif
                .shuffleStyle(.rotateIn)
                .shuffleAnimation(.easeInOut)
                .onShuffle({ _ in })
                .onShuffleTranslation({ _ in })
        )
        self.wait(for: [exp], timeout: 0.2)
    }
    
    func testShuffleStackEnvironmentValuesByDefault() throws {
        let view = ShuffleStack(colors, initialIndex: 0) { color in
            ColorView(color: color)
        }
        let exp = view.inspection.inspect { view in
            let sut = try view.actualView()
            XCTAssertEqual(sut.animation, .linear)
            XCTAssertEqual(sut.style, .slide)
            XCTAssertEqual(sut.offset, 15)
            XCTAssertEqual(sut.scale, 0.95)
            XCTAssertEqual(sut.padding, 15)
            #if !os(tvOS)
            XCTAssertEqual(sut.disabled, false)
            #endif
            XCTAssertNil(sut.shuffleContext)
            XCTAssertNil(sut.shuffleTranslation)
        }
        ViewHosting.host(view: view)
        self.wait(for: [exp], timeout: 0.2)
    }
    
    func testShuffleStackStates() throws {
        let view = ShuffleStack(colors) { color in
            ColorView(color: color)
        }
        let exp = view.inspection.inspect(after: 0.2) { view in
            let sut = try view.actualView()
            let width = 300 - sut.padding * 2 - sut.offset * 2
            XCTAssertEqual(sut.index, 0)
            XCTAssertEqual(sut.xPosition, 0)
            XCTAssertEqual(sut.direction, .left)
            XCTAssertEqual(sut.isLockedLeft, false)
            XCTAssertEqual(sut.isLockedRight, false)
            XCTAssertEqual(sut.size, .init(width: width, height: 200))
            XCTAssertEqual(sut.autoShuffling, false)
            XCTAssertEqual(sut.isActiveGesture, false)
        }
        ViewHosting.host(view: view, size: .init(width: 300, height: 800))
        self.wait(for: [exp], timeout: 0.5)
    }
    
    func testShuffleStackSlideStyleLayout() throws {
        let view = ShuffleStack(colors, initialIndex: 0) { color in
            ColorView(color: color)
        }
        let exp1 = view.inspection.inspect(after: 0.1) { view in
            let sut = try view.actualView()
            XCTAssertEqual(sut.style, .slide)
            let zStack = try sut.inspect().find(ViewType.ZStack.self)
            XCTAssertEqual(try zStack.padding().leading, 30)
            XCTAssertEqual(try zStack.padding().trailing, 30)
            XCTAssertEqual(try zStack.padding().top, 0)
            XCTAssertEqual(try zStack.padding().bottom, 0)
            XCTAssertEqual(try zStack.flexFrame().minHeight, 200)
            XCTAssertEqual(try zStack.flexFrame().maxWidth, .infinity)
            
            let leftContent = try zStack.view(ColorView.self, 0)
            let rightContent = try zStack.view(ColorView.self, 1)
            let mainContent = try zStack.view(ColorView.self, 2)

            let geometryReader = try mainContent.background().find(ViewType.GeometryReader.self)
            XCTAssertEqual(try geometryReader.find(ViewType.Color.self).value(), .clear)
            
            XCTAssertEqual(try leftContent.offset().width, -15)
            XCTAssertEqual(try leftContent.scaleEffect().width, 0.95)
            XCTAssertEqual(try leftContent.scaleEffectAnchor(), .leading)
            XCTAssertEqual(try leftContent.zIndex(), 3)
            
            XCTAssertEqual(try rightContent.offset().width, 15)
            XCTAssertEqual(try rightContent.scaleEffect().width, 0.95)
            XCTAssertEqual(try rightContent.scaleEffectAnchor(), .trailing)
            XCTAssertEqual(try rightContent.zIndex(), 1)
            
            XCTAssertEqual(try mainContent.offset().width, 0)
            XCTAssertEqual(try mainContent.zIndex(), 4)
            sut.performSpreadingOut()
        }
        let exp2 = view.inspection.inspect(after: 0.4) { view in
            let sut = try view.actualView()
            let width = 300 - sut.padding * 2 - sut.offset * 2
            let maxSwipeDistance = width * 0.25
            XCTAssertEqual(sut.style, .slide)
            XCTAssertEqual(sut.xPosition, maxSwipeDistance)
            let group = try sut.inspect().find(ViewType.ZStack.self)
            let leftContent = try group.view(ColorView.self, 0)
            let rightContent = try group.view(ColorView.self, 1)
            let mainContent = try group.view(ColorView.self, 2)
            
            XCTAssertEqual(try leftContent.offset().width, -15 - maxSwipeDistance)
            XCTAssertEqual(try leftContent.scaleEffect().width, 0.95 + (maxSwipeDistance / width * 0.01))
            XCTAssertEqual(try leftContent.scaleEffectAnchor(), .leading)
            XCTAssertEqual(try leftContent.zIndex(), 3)
            
            XCTAssertEqual(try rightContent.offset().width, 15)
            XCTAssertEqual(try rightContent.scaleEffect().width, 0.95)
            XCTAssertEqual(try rightContent.scaleEffectAnchor(), .trailing)
            XCTAssertEqual(try rightContent.zIndex(), 1)
            
            XCTAssertEqual(try mainContent.offset().width, maxSwipeDistance)
            XCTAssertEqual(try mainContent.zIndex(), 4)
        }
        ViewHosting.host(
            view: view
                .shuffleStyle(.slide),
            size: .init(width: 300, height: 800)
        )
        self.wait(for: [exp1, exp2], timeout: 0.8)
    }
    
    func testShuffleStackRotateInStyleLayout() throws {
        let view = ShuffleStack(colors, initialIndex: 0) { color in
            ColorView(color: color)
        }
        let exp1 = view.inspection.inspect(after: 0.1) { view in
            let sut = try view.actualView()
            XCTAssertEqual(sut.style, .rotateIn)
            let zStack = try sut.inspect().find(ViewType.ZStack.self)
            XCTAssertEqual(try zStack.padding().leading, 30)
            XCTAssertEqual(try zStack.padding().trailing, 30)
            XCTAssertEqual(try zStack.padding().top, 0)
            XCTAssertEqual(try zStack.padding().bottom, 0)
            XCTAssertEqual(try zStack.flexFrame().minHeight, 200)
            XCTAssertEqual(try zStack.flexFrame().maxWidth, .infinity)
            
            let leftContent = try zStack.view(ColorView.self, 0)
            let rightContent = try zStack.view(ColorView.self, 1)
            let mainContent = try zStack.view(ColorView.self, 2)

            let geometryReader = try mainContent.background().find(ViewType.GeometryReader.self)
            XCTAssertEqual(try geometryReader.find(ViewType.Color.self).value(), .clear)
            
            XCTAssertEqual(try leftContent.offset().width, -15)
            XCTAssertEqual(try leftContent.scaleEffect().width, 0.95)
            XCTAssertEqual(try leftContent.scaleEffectAnchor(), .leading)
            XCTAssertEqual(try leftContent.rotation3D().axis.y, 1)
            XCTAssertEqual(try leftContent.rotation3D().angle, .zero)
            XCTAssertEqual(try leftContent.zIndex(), 3)
            
            XCTAssertEqual(try rightContent.offset().width, 15)
            XCTAssertEqual(try rightContent.scaleEffect().width, 0.95)
            XCTAssertEqual(try rightContent.scaleEffectAnchor(), .trailing)
            XCTAssertEqual(try rightContent.rotation3D().axis.y, 1)
            XCTAssertEqual(try rightContent.rotation3D().angle, .zero)
            XCTAssertEqual(try rightContent.zIndex(), 1)
            
            XCTAssertEqual(try mainContent.offset().width, 0)
            XCTAssertEqual(try mainContent.zIndex(), 4)
            XCTAssertEqual(try mainContent.rotation3D().axis.y, 1)
            XCTAssertEqual(try mainContent.rotation3D().angle, .zero)
            sut.direction = .right
            sut.performSpreadingOut()
        }
        let exp2 = view.inspection.inspect(after: 0.4) { view in
            let sut = try view.actualView()
            let width = 300 - sut.padding * 2 - sut.offset * 2
            let maxSwipeDistance = -width * 0.25
            XCTAssertEqual(sut.style, .rotateIn)
            XCTAssertEqual(sut.xPosition, maxSwipeDistance)
            let zStack = try sut.inspect().find(ViewType.ZStack.self)
            let leftContent = try zStack.view(ColorView.self, 0)
            let rightContent = try zStack.view(ColorView.self, 1)
            let mainContent = try zStack.view(ColorView.self, 2)
            
            XCTAssertEqual(try leftContent.offset().width, -15)
            XCTAssertEqual(try leftContent.scaleEffect().width, 0.95)
            XCTAssertEqual(try leftContent.scaleEffectAnchor(), .leading)
            XCTAssertEqual(try leftContent.rotation3D().axis.y, 1)
            XCTAssertEqual(try leftContent.rotation3D().angle, .zero)
            XCTAssertEqual(try leftContent.zIndex(), 1)
            
            XCTAssertEqual(try rightContent.offset().width, 15 - maxSwipeDistance)
            XCTAssertEqual(try rightContent.scaleEffect().width, 1)
            XCTAssertEqual(try rightContent.scaleEffectAnchor(), .trailing)
            XCTAssertEqual(try rightContent.rotation3D().axis.y, 1)
            XCTAssertEqual(try rightContent.rotation3D().angle, .degrees(Double(maxSwipeDistance) / 15))
            XCTAssertEqual(try rightContent.zIndex(), 3)
            
            XCTAssertEqual(try mainContent.offset().width, maxSwipeDistance)
            XCTAssertEqual(try mainContent.zIndex(), 4)
            XCTAssertEqual(try mainContent.rotation3D().axis.y, 1)
            XCTAssertEqual(try mainContent.rotation3D().angle, .degrees(Double(-maxSwipeDistance) / 15))
        }
        ViewHosting.host(
            view: view
                .shuffleStyle(.rotateIn),
            size: .init(width: 300, height: 800)
        )
        self.wait(for: [exp1, exp2], timeout: 0.8)
    }
    
    func testShuffleStackRotateOutStyleLayout() throws {
        let view = ShuffleStack(colors, initialIndex: 0) { color in
            ColorView(color: color)
        }
        let exp1 = view.inspection.inspect(after: 0.1) { view in
            let sut = try view.actualView()
            XCTAssertEqual(sut.style, .rotateOut)
            let zStack = try sut.inspect().find(ViewType.ZStack.self)
            XCTAssertEqual(try zStack.padding().leading, 30)
            XCTAssertEqual(try zStack.padding().trailing, 30)
            XCTAssertEqual(try zStack.padding().top, 0)
            XCTAssertEqual(try zStack.padding().bottom, 0)
            XCTAssertEqual(try zStack.flexFrame().minHeight, 200)
            XCTAssertEqual(try zStack.flexFrame().maxWidth, .infinity)
            
            let leftContent = try zStack.view(ColorView.self, 0)
            let rightContent = try zStack.view(ColorView.self, 1)
            let mainContent = try zStack.view(ColorView.self, 2)

            let geometryReader = try mainContent.background().find(ViewType.GeometryReader.self)
            XCTAssertEqual(try geometryReader.find(ViewType.Color.self).value(), .clear)
            
            XCTAssertEqual(try leftContent.offset().width, -15)
            XCTAssertEqual(try leftContent.scaleEffect().width, 0.95)
            XCTAssertEqual(try leftContent.scaleEffectAnchor(), .leading)
            XCTAssertEqual(try leftContent.rotation3D().axis.y, 1)
            XCTAssertEqual(try leftContent.rotation3D().angle, .zero)
            XCTAssertEqual(try leftContent.zIndex(), 3)
            
            XCTAssertEqual(try rightContent.offset().width, 15)
            XCTAssertEqual(try rightContent.scaleEffect().width, 0.95)
            XCTAssertEqual(try rightContent.scaleEffectAnchor(), .trailing)
            XCTAssertEqual(try rightContent.rotation3D().axis.y, 1)
            XCTAssertEqual(try rightContent.rotation3D().angle, .zero)
            XCTAssertEqual(try rightContent.zIndex(), 1)
            
            XCTAssertEqual(try mainContent.offset().width, 0)
            XCTAssertEqual(try mainContent.zIndex(), 4)
            XCTAssertEqual(try mainContent.rotation3D().axis.y, 1)
            XCTAssertEqual(try mainContent.rotation3D().angle, .zero)
            sut.direction = .right
            sut.performSpreadingOut()
        }
        let exp2 = view.inspection.inspect(after: 0.4) { view in
            let sut = try view.actualView()
            let width = 300 - sut.padding * 2 - sut.offset * 2
            let maxSwipeDistance = -width * 0.25
            XCTAssertEqual(sut.style, .rotateOut)
            XCTAssertEqual(sut.xPosition, maxSwipeDistance)
            let group = try sut.inspect().find(ViewType.ZStack.self)
            let leftContent = try group.view(ColorView.self, 0)
            let rightContent = try group.view(ColorView.self, 1)
            let mainContent = try group.view(ColorView.self, 2)
            
            XCTAssertEqual(try leftContent.offset().width, -15)
            XCTAssertEqual(try leftContent.scaleEffect().width, 0.95)
            XCTAssertEqual(try leftContent.scaleEffectAnchor(), .leading)
            XCTAssertEqual(try leftContent.rotation3D().axis.y, 1)
            XCTAssertEqual(try leftContent.rotation3D().angle, .zero)
            XCTAssertEqual(try leftContent.zIndex(), 1)
            
            XCTAssertEqual(try rightContent.offset().width, 15 - maxSwipeDistance)
            XCTAssertEqual(try rightContent.scaleEffect().width, 1)
            XCTAssertEqual(try rightContent.scaleEffectAnchor(), .trailing)
            XCTAssertEqual(try rightContent.rotation3D().axis.y, 1)
            XCTAssertEqual(try rightContent.rotation3D().angle, .degrees(-Double(maxSwipeDistance) / 15))
            XCTAssertEqual(try rightContent.zIndex(), 3)
            
            XCTAssertEqual(try mainContent.offset().width, maxSwipeDistance)
            XCTAssertEqual(try mainContent.zIndex(), 4)
            XCTAssertEqual(try mainContent.rotation3D().axis.y, 1)
            XCTAssertEqual(try mainContent.rotation3D().angle, .degrees(-Double(-maxSwipeDistance) / 15))
        }
        ViewHosting.host(
            view: view
                .shuffleStyle(.rotateOut),
            size: .init(width: 300, height: 800)
        )
        self.wait(for: [exp1, exp2], timeout: 0.8)
    }
    
    #if !os(tvOS)
    func testShuffleStackDisabled() throws {
        let view = ShuffleStack(colors, initialIndex: 0) { color in
            ColorView(color: color)
        }
        let exp = view.inspection.inspect(after: 0.1) { view in
            let sut = try view.actualView()
            XCTAssertEqual(sut.style, .rotateOut)
            let group = try sut.inspect().find(ViewType.ZStack.self)
            let mainContent = try group.view(ColorView.self, 2)
            XCTAssertThrowsError(try mainContent.gesture(DragGesture.self))
        }
        ViewHosting.host(
            view: view
                .shuffleDisabled(true)
                .shuffleStyle(.rotateOut),
            size: .init(width: 300, height: 800)
        )
        self.wait(for: [exp], timeout: 0.3)
    }
    #endif
}
