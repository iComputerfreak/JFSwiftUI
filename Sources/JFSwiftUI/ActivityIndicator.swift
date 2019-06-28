//
//  ActivityIndicator.swift
//  
//
//  Created by Jonas Frey on 28.06.19.
//

import SwiftUI
import UIKit

/// Represents a spinning activity indicator view
@available(iOS 13.0, tvOS 13.0, *)
public struct ActivityIndicator: UIViewRepresentable {
    
    public typealias UIViewType = UIActivityIndicatorView
    
    /// The style of the indicator
    public let style: UIActivityIndicatorView.Style
    /// Whether the activity indicator is spinning
    public var animating: Binding<Bool>?
    
    public func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> ActivityIndicator.UIViewType {
        return UIActivityIndicatorView(style: style)
    }
    
    public func updateUIView(_ uiView: ActivityIndicator.UIViewType, context: UIViewRepresentableContext<ActivityIndicator>) {
        // If animating is not set, animate always
        if (animating?.value ?? true) {
            uiView.startAnimating()
        } else {
            uiView.stopAnimating()
        }
    }
}
