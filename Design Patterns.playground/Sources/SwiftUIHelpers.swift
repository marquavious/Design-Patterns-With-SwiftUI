import Foundation
import SwiftUI

// MARK: - IPHONE VIEW

public struct IPhoneView<Content: View>: View {
    let content: Content
    let multiplier: CGFloat

    public init(multiplier: CGFloat = 2, @ViewBuilder content: () -> Content) {
        self.multiplier = multiplier
        self.content = content()
    }

    public var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 50)
                .frame(width: 250 * multiplier, height: 500 * multiplier)
                .background(Color(red: 64 / 255, green: 64 / 255, blue: 70 / 255))
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.white)
                .frame(width: 220 * multiplier, height: 450 * multiplier)
                .overlay(alignment: .center) {
                    content
                }
        }
    }
}

public func shouldAllowPlaygroundRendering() -> Bool {
    return false
}
