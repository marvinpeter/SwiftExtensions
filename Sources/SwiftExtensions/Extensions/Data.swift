//
//  File.swift
//  
//
//  Created by Marvin Peter on 8/15/20.
//

import Foundation

extension Data {
    
    /// Read data from hexadecimal string
    /// - Parameter hexString: Hexadecimal string (e.g. 0xff)
    public init?(hexString: String) {
        let split = hexString.split(separator: "x")
        let hex = split.count == 1 ? split[0] : split[1]
        let len = hex.count / 2
        var data = Data(capacity: len)
        for i in 0..<len {
            let j = hex.index(hex.startIndex, offsetBy: i * 2)
            let k = hex.index(j, offsetBy: 2)
            let bytes = hex[j..<k]
            if var num = UInt8(bytes, radix: 16) {
                data.append(&num, count: 1)
            } else {
                return nil
            }
        }
        self = data
    }
}
