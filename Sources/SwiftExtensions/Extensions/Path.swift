//
//  Path.swift
//
//
//  Created by Marvin Peter on 8/2/20.
//

import Foundation
import FileKit

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
        self.parent + self.url.deletingPathExtension().lastPathComponent
	}


	/// Get a new path by replace the file extension
	/// - Parameter ext: New file extension
	public func replacingExtension(with ext: String) -> Path {
        self.parent + "\(self.url.deletingPathExtension().lastPathComponent).\(ext)"
	}

    
    /// Get file name without extension
    public var fileBaseName: String {
        self.url.deletingPathExtension().lastPathComponent
    }
}

extension Path {
    
    /// Get iCloud Drive document path
    public static var cloudDocuments: Path {
        Path(FileManager.default.url(forUbiquityContainerIdentifier: nil)!.path) + "Documents"
    }
}
