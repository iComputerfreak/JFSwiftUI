//
//  UserDefault.swift
//  
//
//  Created by Jonas Frey on 04.07.19.
//

import Foundation
import SwiftUI

/// Represents a property wrapper that provides read/write access to a value stored in UserDefaults
@propertyWrapper
public struct UserDefault<T> where T: Codable {
    
    public let key: String
    public let defaultValue: T
    public let encoded: Bool
    
    /// Creates a new UserDefaults Wrapper
    /// - Parameters:
    ///   - key: The key to use for the UserDefaults
    ///   - defaultValue: The default value to return, when no value is set in the UserDefaults
    ///   - encoded: Whether to automatically encode the value with a PropertyListEncoder before saving it in the UserDefaults
    public init(_ key: String, defaultValue: T, encoded: Bool = false) {
        self.key = key
        self.defaultValue = defaultValue
        self.encoded = encoded
    }
    
    public var wrappedValue: T {
        get {
            if encoded {
                if let data = UserDefaults.standard.data(forKey: key) {
                    if let value = try? PropertyListDecoder().decode(T.self, from: data) {
                        return value
                    }
                }
                return defaultValue
            } else {
                return UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
            }
        }
        set {
            if encoded {
                UserDefaults.standard.set(try? PropertyListEncoder().encode(newValue), forKey: key)
            } else {
                UserDefaults.standard.set(newValue, forKey: key)
            }
        }
    }
}

