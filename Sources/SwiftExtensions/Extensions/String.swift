//
//  String.swift
//
//
//  Created by Marvin Peter on 8/2/20.
//

import Foundation

public final class LineReader: Sequence {
    public let lines: [String]
    private var index: Int

    init(string str: String, delimiter: String = "\n") {
        self.lines = str.components(separatedBy: delimiter)
        self.index = 0
    }

    
    /// Get the next line in string if it exists
    public func nextLine() -> String? {
        if index >= lines.count {
            return nil
        }
        let line = self.lines[index]
        self.index += 1
        return line
    }
    
    
    /// Restart sequence with first line
    public func rewind() {
        index = 0
    }
    
    public func makeIterator() -> AnyIterator<String> {
        AnyIterator { self.nextLine() }
    }
}

extension String {

	/// Truncate the string to a given length and add ellipsis mark at the end
	/// - Parameter maxLength: Max string length
	/// - Returns: Truncated string
	public func truncate(maxLength: Int) -> String {
		if count < maxLength {
			return self
		}
		return String(self.prefix(maxLength - 3)) + "..."
	}


	/// Pad a string from the left
	/// - Parameters:
	///   - toLength: Target length
	///   - character: Pad character
	/// - Returns: Padded string
	public func leftPadding(toLength: Int, withPad character: Character) -> String {
		let stringLength = self.count
		if stringLength < toLength {
			return String(repeatElement(character, count: toLength - stringLength)) + self
		} else {
			return String(self.suffix(toLength))
		}
	}


	/// Match a string against a regular expression
	/// - Parameter regex: Regular expression
	/// - Returns: Matches
	public func capture(regex: String) -> [[String]] {
		guard let regex = try? NSRegularExpression(pattern: regex, options: []) else { return [] }
		let nsString = self as NSString
		let results = regex.matches(in: self, options: [], range: NSMakeRange(0, nsString.length))
		return results.map { result in
			(0..<result.numberOfRanges).map {
				result.range(at: $0).location != NSNotFound
					? nsString.substring(with: result.range(at: $0))
				: ""
			}
		}
	}


    /// Remove all unallowed characters from the string to get a valid file name and replace ":" with "- ".
	public var escapedFileName: String {
		return self.trimmingCharacters(in: .whitespacesAndNewlines)
			.replacingOccurrences(of: ":", with: " -")
			.components(separatedBy: .init(charactersIn: "/\\:?%*|\"<>")).joined()
	}


	/// Test if string is either empty or only contains whitespaces
	public var isBlank: Bool {
		let trimmed = self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
		return trimmed.isEmpty
	}

	/// Get character at a give offset
	/// - Parameter offset: Character offset
	/// - Returns: Character
	public subscript(offset: Int) -> Character {
		self[index(startIndex, offsetBy: offset)]
	}

	/// Get character at a give offset or null if it does not exist
	/// - Parameter offset: Character offset
	/// - Returns: Optional character
	public subscript(safeOffset offset: Int) -> Element? {
		guard offset >= 0, offset < count else {
			return nil
		}

		return self[index(startIndex, offsetBy: offset)]
	}
    
    /// Split string into lines and return an iterable object
    ///  (Note: This method in not lazy. The string is split before returning)
    /// - Parameter delimiter: Line delimiter (default: "\n")
    public func lines(delimiter: String = "\n") -> LineReader {
        return LineReader(string: self, delimiter: delimiter)
    }
}
