import SwiftUI

/// An enumeration of carousel style that is used to change sliding behaviour of the carousel stack view.
public enum CarouselStyle {
    /// A carousel style which makes content views scroll in the loop without ending.
    case infiniteScroll
    /// A carousel style which ends content views at both ends so that it cannot be scrolled infinitely.
    case finiteScroll
}

/// An environment key for carousel style.
struct CarouselStyleKey: EnvironmentKey {
    static var defaultValue: CarouselStyle = .finiteScroll
}

extension EnvironmentValues {
    var carouselStyle: CarouselStyle {
        get { self[CarouselStyleKey.self] }
        set { self[CarouselStyleKey.self] = newValue }
    }
}
