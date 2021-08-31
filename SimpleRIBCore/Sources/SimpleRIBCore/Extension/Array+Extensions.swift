//
//  Array+Extensions.swift
//  
//
//  Created by Prabin Kumar Datta on 31/08/21.
//

import Foundation

public extension Array {
    
    /// Subscript to get Element in an array safely.
    /// If Element is not found, returns nil
    subscript(safeIndex index: Int) -> Element? {
        guard index >= 0, index < endIndex else {
            return nil
        }
        return self[index]
    }
    
    /// Function to lookup for objects conforming to Equatable protocol
    /// - Parameter obj: Object conforming to Equatable
    /// - Returns: Bool status for if found == true
    func contains<T>(obj: T) -> Bool where T: Equatable {
        return filter({ $0 as? T == obj }).count > 0
    }
}

public extension Array {
        
    /// Function to concurrently perform iterated items
    /// - Parameter body: Closure that takes an element of the sequence as a parameter.
    func concurrentPerform(_ body: (Element) -> Void) {
        DispatchQueue.concurrentPerform(iterations: self.count - 1) { index in
            body(self[index])
        }
    }
}
