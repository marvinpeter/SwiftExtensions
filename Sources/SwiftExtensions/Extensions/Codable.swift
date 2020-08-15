//
//  Codable.swift
//
//
//  Created by Marvin Peter on 8/2/20.
//

import Foundation
import FileKit

extension Encodable {

	/// Encode struct to JSON data
	/// - Returns: Data
	public func toJsonData() -> Data? {
		return try? JSONEncoder().encode(self)
	}


	/// Encode to JSON and write it to storage
	/// - Parameter path: Save path
	public func write(to path: Path) throws {
		guard let data = self.toJsonData() else {
			return
		}
		return try File(path: path).write(data)
	}


	/// Encode struct into dictionary
	public func toDict() -> [String: Any]? {
		guard let data = try? JSONEncoder().encode(self) else {
            return nil
        }
		return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments))
            .flatMap { $0 as? [String: Any] }
	}
}

extension Decodable {

	/// Decode from  JSON data
	/// - Parameter data: Data
	public init?(withJson data: Data) {
		guard let res = try? JSONDecoder().decode(Self.self, from: data) else {
			return nil
		}
		self = res
	}
    

	/// Load decoable object from JSON file
	/// - Parameter path: Path path to JSON file
	public init?(from path: Path) {
		guard let data = try? File<Data>(path: path).read() else {
			return nil
		}

		guard let res = try? JSONDecoder().decode(Self.self, from: data) else {
			return nil
		}

		self = res
	}
}
