//
//  encoder.swift
//  Lz77Codec
//
//  Created by Yang Zhou on 2016-10-26.
//
//

import Foundation

func lz77enc (message: String, searchBufferSize: Int) -> (offset: Int, length: Int) {
    let currentIndex = message.index(message.startIndex, offsetBy: searchBufferSize)
    let lookaheadBufferSize = message.characters.count - searchBufferSize
    
    func commonLength (left: String.Index, right: String.Index) -> Int {
        var counter = 0
        var left = left, right = right
        for _ in 0..<lookaheadBufferSize {
            if message[left] == message[right] {
                counter += 1
                left = message.index(after: left)
                right = message.index(after: right)
            } else {
                break
            }
        }
        return counter
    }
    
    var result = (offset:0, length:0)
    
    for offset in 1...searchBufferSize {
        let searchIndex = message.index(currentIndex, offsetBy: -offset)
        let currentLength = commonLength(left: searchIndex, right: currentIndex)
        if currentLength > result.length {
            result = (offset, currentLength)
        }
    }
    
    return result
}

func lz77Encode (_ message: String, windowSize: Int, lookaheadBufferSize: Int, codeword: [String: Int]) -> [(Int,Int,Int)] {
    let searchBufferSize = windowSize - lookaheadBufferSize
    var output = [(Int,Int,Int)]()
    
    var current = message.index(message.startIndex, offsetBy: searchBufferSize)
    while current < message.endIndex {
        let left = message.index(current, offsetBy: -searchBufferSize)
        let right = message.index(current, offsetBy: lookaheadBufferSize, limitedBy: message.endIndex) ?? message.endIndex
        
        print("\(message[message.startIndex..<left])|\(message[left..<current])|\(message[current..<right])|\(message[right..<message.endIndex])")
        
        let (offset, length) = lz77enc(message: message[left..<right], searchBufferSize: searchBufferSize)

        current = message.index(current, offsetBy: length+1)
        let symbol = String(message[message.index(before: current)])
        
        output.append((offset,length,codeword[symbol]!))
        
        print((offset,length,codeword[symbol]!))
    }
    return output
}
