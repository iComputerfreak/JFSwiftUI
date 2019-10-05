//
//  CollectionView.swift
//
//
//  Created by Jonas Frey on 23.06.19.
//

import SwiftUI

/// Represents a collection view that displays multiple cells with a given spacing and cell size
@available(iOS 13.0, tvOS 13.0, watchOS 6.0, *)
public struct CollectionView<Data, Content> : View where Data: Hashable, Content: View {
    public var data: [Data]
    public var content: (Data) -> Content
    
    public var spacing: CGFloat = 10
    public var cellSize: CGFloat = 300
    
    /// Returns the number of items that fit in one row, given the specified spacing and itemSize
    var itemsPerRow: Int {
        let screenWidth = UIScreen.main.bounds.width
        let itemsPerRow = Int(screenWidth / (cellSize + spacing))
        // There should be placed at least one item per row
        return itemsPerRow > 0 ? itemsPerRow : 1
    }
    
    public var body: some View {
        // A VStack for all the rows
        VStack(spacing: spacing) {
            // For each row
            ForEach(data.chunked(into: itemsPerRow), id: \.self) { (rowObjects: [Data]) in
                // Create a HStack with the rowObjects
                HStack(spacing: self.spacing) {
                    ForEach(rowObjects, id: \.self) { (object: Data) in
                        // Display the items as specified by the content closure
                        self.content(object)
                    }
                    // Make items left-aligned
                    //Spacer()
                }
            }
            // Make rows top-aligned
            Spacer()
            }
            .padding(self.spacing)
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
