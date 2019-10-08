//
//  CollectionView.swift
//
//
//  Created by Jonas Frey on 23.06.19.
//

import SwiftUI

/// Represents a collection view that displays multiple cells with a given spacing and cell size
@available(iOS 13.0, tvOS 13.0, watchOS 6.0, *)
public struct CollectionView<Data, Content> : View where Data: Hashable, Data: Identifiable, Content: View {
    public var data: [Data]
    public var content: (Data) -> Content
    
    public var spacing: CGFloat
    public var itemsPerRow: Int
    public var itemsPerRowInLandscape: Int
    
    public init(_ data: [Data], spacing: CGFloat = 10, itemsPerRow: Int = 3, itemsPerRowInLandscape: Int = 5, content: @escaping (Data) -> Content) {
        self.data = data
        self.content = content
        self.spacing = spacing
        self.itemsPerRow = itemsPerRow
        self.itemsPerRowInLandscape = itemsPerRowInLandscape
    }
    
    public var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            // A VStack for all the rows
            VStack(spacing: spacing) {
                // For each row
                ForEach(data.chunked(into: itemsPerRow), id: \.self) { (rowObjects: [Data]) in
                    // Create a HStack with the rowObjects
                    HStack(spacing: self.spacing) {
                        ForEach(rowObjects) { (object: Data) in
                            // Display the items as specified by the content closure
                            self.content(object)
                        }
                        // Make items left-aligned
                        ForEach(0..<(self.itemsPerRow - rowObjects.count)) { _ in
                            // Add a Spacer for every missing cell in that row
                            Spacer()
                        }
                    }
                }
                // Make rows top-aligned
                //Spacer()
            }
            .padding(self.spacing)
        }
    }
}

public extension RandomAccessCollection {
    /// Splits an array into chunks of fixed size.
    /// - Parameters:
    ///   - into: The chunk size of the return arrays
    /// - Returns: An array containing arrays of at most `into` elements.
    func chunked(into size: Int) -> [[Element]] {
        // Counts from 0 to count in step size `size`
        return stride(from: 0, to: count, by: size).map { i in
            // i is a multiple of `size`
            let indexI = self.index(self.startIndex, offsetBy: i)
            let indexMin = self.index(self.startIndex, offsetBy: Swift.min(i + size, count))
            return Array(self[indexI..<indexMin])
        }
    }
}
