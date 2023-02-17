//
//  LoadingScreen.swift
//  
//
//  Created by Jonas Frey on 03.10.19.
//
import SwiftUI
#if !os(macOS)
/// Shows a loading screen while a given condition is met
@available(iOS 14.0, tvOS 14.0, watchOS 7.0, *)
public struct LoadingView<Content>: View where Content: View {
    
    public let text: String
    @Binding public var isShowing: Bool
    public var content: () -> Content
    
    public init(isShowing: Binding<Bool>, text: String? = nil, content: @escaping () -> Content) {
        self.text = text ?? "Loading..."
        self._isShowing = isShowing
        self.content = content
    }
    
    public var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .center) {
                
                self.content()
                    .disabled(self.isShowing)
                    .blur(radius: self.isShowing ? 3 : 0)
                
                ProgressView() {
                    Text(text)
                        .multilineTextAlignment(.center)
                }
                .frame(width: geometry.size.width / 2,
                       height: geometry.size.height / 5)
                .background(Color.secondary.colorInvert())
                .foregroundColor(Color.primary)
                .cornerRadius(20)
                .opacity(self.isShowing ? 1 : 0)
                
            }
        }
    }
}
#endif
