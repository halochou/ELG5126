//
//  encoder.swift
//  lzwCodec
//
//  Created by Yang Zhou on 2016-10-24.
//  Copyright © 2016 Yang Zhou. All rights reserved.
//

import Foundation

func findCodeword(_ message: String, inDictionary dict: [String]) -> (Int, String) {
    var codeword = -1
    for index in message.characters.indices {
        let symbol = message[message.startIndex..<message.index(after: index)]
        print("\nThen we encounter $\(symbol)$. ")
        if let newCodeword = dict.index(of: symbol) {
            print("This pattern is already \\textbf{in} the dictionary, so concatenate the next letter.")
            codeword = newCodeword
        } else {
            print("This pattern is \\textbf{not in} the dictionary, so we encode $\(symbol.substring(to: symbol.index(before: symbol.endIndex)))$ with its index $\(codeword+1)$, add new pattern $\(symbol)$ to dictionary.")
            return (codeword, symbol)
        }
    }
    return (codeword, "")
}

func lzwEncode(message: String, dict: [String]) -> (encodedMessage: [Int], dictonary: [String]) {
    var msg = message
    var dict = dict
    var result : [Int] = []
    while msg != "" {
        print("\nNow the dictionary becomes \n\\[\(dict)\\]")
        print("\n\\smallskip\n")
        let (codeword, symbol) = findCodeword(msg, inDictionary: dict)
        result.append(codeword)
        if symbol == "" {
            break
        }
        dict.append(symbol)
        msg = String(msg.characters.dropFirst(symbol.characters.count - 1))
    }
    return (result.map({$0+1}), dict)
}
