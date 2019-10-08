//
//  LoadingScreen.swift
//  
//
//  Created by Jonas Frey on 03.10.19.
//

import SwiftUI

@available(iOS 13.0, tvOS 13.0, watchOS 6.0, *)
public struct LoadingScreen<Content: View>: View {
    
    public var isLoading: Bool
    public var content: Content
    
    public init(isLoading: Bool, content: @convention(block) () -> Content) {
        self.isLoading = isLoading
        self.content = content()
    }
    
    public var body: some View {
        if (isLoading) {
            // Create a loading screen
            return AnyView(self.loadingScreen)
        } else {
            // Show the actual content
            return AnyView(self.content)
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
