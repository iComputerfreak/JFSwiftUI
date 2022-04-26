//
//  AsyncImage.swift
//  
//
//  Created by Jonas Frey on 26.04.22.
//

import Foundation
import SwiftUI

@available(macOS 12.0, *)
extension AsyncImage {
    init<I, L, F>(
        url: URL?,
        scale: CGFloat = 1,
        transaction: Transaction = Transaction(),
        @ViewBuilder content: @escaping (Image) -> I,
        @ViewBuilder loading: @escaping () -> L,
        @ViewBuilder fallback: @escaping () -> F
    ) where Content == _ConditionalContent<_ConditionalContent<L, F>, _ConditionalContent<I, Never>>,
            I: View, L: View, F: View {
        self.init(url: url, scale: scale, transaction: transaction) { phase in
            switch phase {
            case .empty:
                loading()
            case .failure:
                fallback()
            case .success(let image):
                content(image)
            @unknown default:
                fatalError("Unknown image phase: \(phase)")
            }
        }
    }
}
