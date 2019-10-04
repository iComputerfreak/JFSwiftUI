//
//  LoadingScreen.swift
//  
//
//  Created by Jonas Frey on 03.10.19.
//

import SwiftUI

@available(iOS 13.0, tvOS 13.0, watchOS 6.0, *)
public struct LoadingScreen<Content: View>: View {
    
    @Binding private var isLoading: Bool
    public var content: Content
    
    public init(isLoading: Binding<Bool>, content: () -> Content) {
        self._isLoading = isLoading
        self.content = content()
    }
    
    public var body: some View {
        // Group is required to prevent return type inferrence error
        Group {
            if (isLoading) {
                // Create a loading screen
                HStack {
                    ActivityIndicator(style: .medium)
                    Text("Loading...")
                        .font(.headline)
                }
            } else {
                // Show the actual content
                self.content
            }
        }
    }
}
