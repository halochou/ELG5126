//
//  decoder.swift
//  Lz77Codec
//
//  Created by Yang Zhou on 2016-10-26.
//
//

import Foundation

func lz77Decode (_ message: [(Int,Int,Int)], searchBuffer: String, codeword: [Int: String]) -> String {
    var output = searchBuffer
    for (offset, length, code) in message {
        
        var current = output.index(output.endIndex, offsetBy: -offset)
        for _ in 0..<length {
            output += String(output[current])
            current = output.index(after: current)
        }
        output += codeword[code] ?? ""
    }
    return output
}
