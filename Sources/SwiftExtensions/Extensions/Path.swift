//
//  Path.swift
//
//
//  Created by Marvin Peter on 8/2/20.
//

import Foundation
import FileKit

private func stripFileExtension(_ filename: String) -> String {
	var components = filename.components(separatedBy: ".")
	guard components.count > 1 else { return filename }
	components.removeLast()
	return components.joined(separator: ".")
}

extension Path {

	/// Exclude path from iCloud backups
	/// - Parameter value: true for exclude and false for include
	@available(iOS 13.0, *)
	public func excludeFromBackup(_ value: Bool = true) {
		var resourceValues = URLResourceValues()
		resourceValues.isExcludedFromBackup = value
		var url = self.url
		try? url.setResourceValues(resourceValues)
	}


	/// Get path without file extension
	public var withoutExtension: Path {
		self.parent + stripFileExtension(self.fileName)
	}


	/// Get a new path by replace the file extension
	/// - Parameter ext: New file extension
	public func replacingExtension(with ext: String) -> Path {
		self.parent + (stripFileExtension(self.fileName) + "." + ext)
	}
}
