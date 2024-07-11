import Foundation
import SwiftUI

// MARK: - IPHONE VIEW

public struct IPhoneView<Content: View>: View {

    let content: Content
    let multiplier: CGFloat
    let phoneWidth: CGFloat
    let phoneHeight: CGFloat

    public init(multiplier: CGFloat = 2, phoneWidth: CGFloat = 250, phoneHeight: CGFloat = 500, @ViewBuilder content: () -> Content) {
        self.multiplier = multiplier
        self.content = content()
        self.phoneWidth = phoneWidth
        self.phoneHeight = phoneHeight
    }

    public var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 50)
                .frame(width: phoneWidth * multiplier, height: phoneHeight * multiplier)
                .background(Color(red: 64 / 255, green: 64 / 255, blue: 70 / 255))
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.white)
                .frame(width: (phoneWidth - 30) * multiplier, height: (phoneHeight - 50) * multiplier)
                .overlay(alignment: .center) {
                    content
                }
        }
    }
}

public func shouldAllowPlaygroundRendering() -> Bool {
    return false
}
