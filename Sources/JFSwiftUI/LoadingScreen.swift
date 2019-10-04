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
    public var navigationBarTitle: String?
    
    public init(isLoading: Bool, navigationBarTitle: String?, content: () -> Content) {
        self.isLoading = isLoading
        self.content = content()
        self.navigationBarTitle = navigationBarTitle
    }
    
    public var body: some View {
        // Group is required to prevent return type inferrence error
        Group {
            if (isLoading) {
                // Create a loading screen
                if navigationBarTitle != nil {
                    self.loadingScreen
                        .navigationBarTitle(navigationBarTitle!)
                } else {
                    self.loadingScreen
                }
            } else {
                // Show the actual content
                if navigationBarTitle != nil {
                    self.content
                        .navigationBarTitle(navigationBarTitle!)
                } else {
                    self.content
                }
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
