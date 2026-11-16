#if canImport(SwiftUI)
import SwiftUI

/// The one filled button style of the app.
public struct PrimaryButtonStyle: ButtonStyle {
    public init() {}

    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline)
            .padding(.horizontal, Spacing.large)
            .padding(.vertical, Spacing.small)
            .background(.tint, in: .rect(cornerRadius: Spacing.small))
            .foregroundStyle(.white)
            .opacity(configuration.isPressed ? 0.7 : 1)
    }
}
#endif
