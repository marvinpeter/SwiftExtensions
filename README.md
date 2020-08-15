# SwiftExtensions
This is a library developed for my own projects. It contains a collection commonly used extensions to Swift types.

## Note
This library contains a class for creating sorted list. This was initalily developed by [Ole Begemann](https://github.com/ole/SortedArray).

## Extensions
### Array
``` swift

/// Divide the array into chunks of a given size or less
/// - Parameter size: Chunk size
/// - Returns: Chunked array
func chunked(into size: Int) -> [[Element]]

/// Count elements in the array which meet given criteria
/// - Parameter isIncluded: Determine if an element should be counted
/// - Returns: Number of elements matching the condition
func count(_ isIncluded: (Element) -> Bool) -> Int


/// Get an array which only has unique values according to a given criteria
/// - Parameter by: Criteria to check
/// - Returns: Unique array
func unique<T: Hashable>(by: ((Element) -> (T))) -> [Element]


/// Split off the last element of the array
/// - Returns: Return the rest array and the tail
func splitTail() -> ([Element], Element?)


/// Scan an array
/// - Parameters:
///   - initial: InitialValue
///   - f: Function to accumulative
/// - Returns: Accumulated array
func scan<T>(initial: T, _ f: (T, Element) -> T) -> [T]


/// Get element at a specific index or null if it does not exist
/// - Parameters:
///   - index: Value index
/// - Returns: Optional value
subscript(safeIndex index: Int) -> Element?


/// Get the element before the given element
/// - Parameter elem: Element
/// - Returns: Element
func elementAfter(_ elem: Element) -> Element?


/// Get the element after the given element
/// - Parameter elem: Element
/// - Returns: Element
func elementBefore(_ elem: Element) -> Element?
```

### Codable
``` swift
/// Encode struct to JSON data
/// - Returns: Data
func toJsonData() -> Data?


/// Encode to JSON and write it to storage
/// - Parameter path: Save path
func write(to path: Path) throws


/// Encode struct into dictionary
func toDict() -> [String: Any]?


/// Decode from  JSON data
/// - Parameter data: Data
init?(withJson data: Data)


/// Load decoable object from JSON file
/// - Parameter path: Path path to JSON file
init?(from path: Path)
```

### Data
``` swift
/// Read data from hexadecimal string
/// - Parameter hexString: Hexadecimal string (e.g. 0xff)
init?(hexString: String)
```

### Path (FileKit)
``` swift
/// Exclude path from iCloud backups
/// - Parameter value: true for exclude and false for include
@available(iOS 13.0, *)
func excludeFromBackup(_ value: Bool = true)


/// Get path without file extension
var withoutExtension: Path


/// Get a new path by replace the file extension
/// - Parameter ext: New file extension
func replacingExtension(with ext: String) -> Path
```

### String
``` swift
/// Truncate the string to a given length and add ellipsis mark at the end
/// - Parameter maxLength: Max string length
/// - Returns: Truncated string
func truncate(maxLength: Int) -> String


/// Pad a string from the left
/// - Parameters:
///   - toLength: Target length
///   - character: Pad character
/// - Returns: Padded string
func leftPadding(toLength: Int, withPad character: Character) -> String


/// Match a string against a regular expression
/// - Parameter regex: Regular expression
/// - Returns: Matches
func capture(regex: String) -> [[String]]


/// Remove all unallowed characters from the string to get a valid file name and replace ":" with "- ".
var escapedFileName: String


/// Test if string is either empty or only contains whitespaces
var isBlank: Bool

/// Get character at a give offset
/// - Parameter offset: Character offset
/// - Returns: Character
subscript(offset: Int) -> Character

/// Get character at a give offset or null if it does not exist
/// - Parameter offset: Character offset
/// - Returns: Optional character
subscript(safeOffset offset: Int) -> Element?

/// Split string into lines and return an iterable object
///  (Note: This method in not lazy. The string is split before returning)
/// - Parameter delimiter: Line delimiter (default: "\n")
func lines(delimiter: String = "\n") -> LineReader
```

### URL
``` swift
/// Get parsed query parameters
var queryParameters: [String: String]
```

### URLRequest
``` swift
/// Create a custom URL request object
/// - Parameters:
///   - url: URL
///   - headers: HTTP request headers
///   - method: HTTP Method
///   - body: Request body
init(url: URL, headers: [String: String], method: String, body: Data?)
```