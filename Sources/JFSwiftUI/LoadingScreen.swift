//
//  LoadingScreen.swift
//  
//
//  Created by Jonas Frey on 03.10.19.
//
#if !os(macOS)
import SwiftUI

/// Shows a loading screen while a given condition is met
@available(iOS 13.0, tvOS 13.0, watchOS 6.0, *)
public struct LoadingScreen<Content: View>: View {
    
    public var isLoading: Bool
    public var content: Content
    
    public init(isLoading: Bool, content: () -> Content) {
        self.isLoading = isLoading
        self.content = content()
    }
    
    public var body: some View {
        // Use a group to erase the type
        Group {
            if (isLoading) {
                // Create a loading screen
                self.loadingScreen
            } else {
                // Show the actual content
                self.content
            }
        }
    }
    
    private var loadingScreen: some View {
        HStack {
            ActivityIndicator(style: .medium)
            Text("Loading...")
                .font(.headline)
        }
    }
}
#endif
