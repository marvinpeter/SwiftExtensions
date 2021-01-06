//
//  Array.swift
//
//
//  Created by Marvin Peter on 8/2/20.
//

import Foundation

extension Array {

	/// Divide the array into chunks of a given size or less
	/// - Parameter size: Chunk size
	/// - Returns: Chunked array
	public func chunked(into size: Int) -> [[Element]] {
		return stride(from: 0, to: count, by: size).map {
			Array(self[$0 ..< Swift.min($0 + size, count)])
		}
	}


	/// Count elements in the array which meet given critiria
	/// - Parameter isIncluded: Determine if an element should be counted
	/// - Returns: Number of elements matching the condition
	public func count(_ isIncluded: (Element) -> Bool) -> Int {
		return self.filter(isIncluded).count
	}


	/// Get an array which only has unique values according to a given criteria
	/// - Parameter by: Criteria to check
	/// - Returns: Unique array
	public func unique<T: Hashable>(by: ((Element) -> (T))) -> [Element] {
		var set = Set<T>()
		var arrayOrdered: [Element] = []
		for value in self {
			if !set.contains(by(value)) {
				set.insert(by(value))
				arrayOrdered.append(value)
			}
		}

		return arrayOrdered
	}


	/// Split off the last element of the array
	/// - Returns: Return the rest array and the tail
	public func splitTail() -> ([Element], Element?) {
		if count < 2 {
			return (self, nil)
		}
		let first = Array(self[0..<(self.count - 1)])
		let last = self.last!
		return (first, last)
	}
    

    /// Scan an array
    /// - Parameters:
    ///   - initial: InitialValue
    ///   - f: Function to accumulative
    /// - Returns: Accumulated array
	public func scan<T>(initial: T, _ f: (T, Element) -> T) -> [T] {
        self.reduce([initial], { (listSoFar: [T], next: Element) -> [T] in
            let lastElement = listSoFar.last!
            return listSoFar + [f(lastElement, next)]
        })
	}
    
    
    /// Seperate elements in two array based on if the predicate matches
    /// - Parameter predicate: Predicate
    /// - Returns: (matching elements, non-matching elements)
    public func separate(predicate: (Element) -> Bool) -> (matching: [Element], notMatching: [Element]) {
        var groups: ([Element],[Element]) = ([],[])
        for element in self {
            if predicate(element) {
                groups.0.append(element)
            } else {
                groups.1.append(element)
            }
        }
        return groups
    }

    
	/// Get element at a specific index or null if it does not exist
	/// - Parameters:
	///   - index: Value index
	/// - Returns: Optional value
	public subscript(safeIndex index: Int) -> Element? {
		guard index >= 0, index < endIndex else {
			return nil
		}

		return self[index]
	}
}

extension Array where Element: Equatable {

	/// Get the element before the given element
	/// - Parameter elem: Element
	/// - Returns: Element
	public func elementAfter(_ elem: Element) -> Element? {
		guard let index = self.firstIndex(of: elem)
			else { return nil }
		return index < self.count - 1 ? self[index + 1] : nil
	}


	/// Get the element after the given element
	/// - Parameter elem: Element
	/// - Returns: Element
	public func elementBefore(_ elem: Element) -> Element? {
		guard let index = self.firstIndex(of: elem)
			else { return nil }
		return index > 0 ? self[index - 1] : nil
	}
}
