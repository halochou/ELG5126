//
//  decoder.swift
//  LzwCodec
//
//  Created by Yang Zhou on 2016-10-25.
//
//

import Foundation

//func updateDictonary

func lzwDecode (message : [Int], dict : [String]) -> (decodedMessage: String, dictonary: [String]) {
    let message = message.map({$0-1})
    var decoded = ""
    var dict = dict
    var leftIndex = decoded.startIndex
    for codeword in message {
        let rightIndex = decoded.endIndex
        print("The next index value $\(codeword)$ corresponds to pattern $\(dict[codeword])$, so we decode $\(dict[codeword])$.")
        decoded += dict[codeword]
        let newSymbol = decoded[leftIndex...decoded.index(after: rightIndex)]
        if !dict.contains(newSymbol) {
            print("$\(newSymbol)$ does \\textbf{not} exist in the dictionary, so add it to the dictionary.\nAnd start a new pattern beginning with $\(newSymbol[newSymbol.index(before: newSymbol.endIndex)])$. ")
            dict.append(newSymbol)
            print("Now the dictionary becomes \n\\[\(dict)\\]")
            leftIndex = decoded.index(after: rightIndex)
        } else {
            print("$\(newSymbol)$ exists in the dictionary, so continue with the decoding process.")
        }
    }
    
    return (decoded, dict)
}
