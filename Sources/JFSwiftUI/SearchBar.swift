//
//  SearchBar.swift
//  
//
//  Created by Jonas Frey on 28.06.19.
//

import SwiftUI
import UIKit

/// Represents a search bar view
@available(iOS 13.0, tvOS 13.0, watchOS 6.0, *)
public struct SearchBar: UIViewRepresentable {
    
    /// Gets called when the keyboard search button is pressed
    public var onSearchButtonClicked: (() -> Void)?
    /// Gets called when the search text field stopped receiving input for 500 ms
    public var onSearchEditingChanged: (() -> Void)?
    /// The text in the search text field
    @Binding public var text: String
    
    public init(text: Binding<String>, onSearchButtonClicked: (() -> Void)? = nil, onSearchEditingChanged: (() -> Void)? = nil) {
        self._text = text
        self.onSearchButtonClicked = onSearchButtonClicked
        self.onSearchEditingChanged = onSearchEditingChanged
    }
    
    public class Coordinator: NSObject, UISearchBarDelegate {
        
        @Binding var text: String
        var onSearchButtonClicked: (() -> Void)?
        
        init(text: Binding<String>, onSearchBarButtonClicked: (() -> Void)?) {
            self._text = text
            self.onSearchButtonClicked = onSearchBarButtonClicked
        }
        
        public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
        }
        
        public func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            onSearchButtonClicked?()
            searchBar.resignFirstResponder()
        }
    }
    
    public func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text, onSearchBarButtonClicked: onSearchButtonClicked)
    }
    
    public func makeUIView(context: UIViewRepresentableContext<SearchBar>) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        searchBar.placeholder = "Search"
        
        // Create a publisher for the textDidChange notification of the search text field
        let publisher = NotificationCenter.default.publisher(for: UISearchTextField.textDidChangeNotification, object: searchBar.searchTextField)
        // Create an action for the text of the text field
        _ = publisher.map( {
            ($0.object as! UISearchTextField).text
        })
            // Delay the action for 500 ms
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            // Remove duplicate calls
            .removeDuplicates()
            // Call the closure
            .sink(receiveValue: { _ in
                self.onSearchEditingChanged?()
            })
        
        return searchBar
    }
    
    public func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<SearchBar>) {
        uiView.text = text
        
        // Change appearance according to color scheme
        if context.environment.colorScheme == .dark {
            uiView.barTintColor = UIColor.black
        } else {
            uiView.barTintColor = UIColor.white
        }
    }
    
}
