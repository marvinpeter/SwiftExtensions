//
//  URL.swift
//
//
//  Created by Marvin Peter on 8/2/20.
//

import Foundation

extension URL {

	/// Get parsed query parameters
	public var queryParameters: [String: String] {
		guard let components = URLComponents(url: self, resolvingAgainstBaseURL: true),
              let queryItems = components.queryItems else {
            return [:]
        }
		return queryItems.reduce(into: [String: String]()) { (result, item) in
			result[item.name] = item.value
		}
	}
}
