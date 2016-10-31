//
//  main.swift
//  lzwCodec
//
//  Created by Yang Zhou on 2016-10-24.
//  Copyright © 2016 Yang Zhou. All rights reserved.
//

import Foundation

let encodingTestDict1 = [" ", "a", "b", "o", "w"]
let encodingTestInput1 = "wabba wabba wabba wabba woo woo woo"

let decodingTestDict1 = [" ", "a", "b", "o", "w"]
let decodingTestInput1 = [5,2,3,3,2,1,6,8,10,12,9,11,7,16,5,4,4,11,21,23,4]


let encodingTestDict2 = ["a", "b", "c","d"]
let encodingTestInput2 = "acbabacbaacbaadaaa"

let decodingTestDict2 = ["a", "b", "c", "d"]
let decodingTestInput2 = [1, 3, 2, 1, 7, 6, 1, 5, 7, 1, 4, 11, 1]

//let (encoded,encodeDict) = lzwEncode(message: encodingTestInput2, dict: encodingTestDict2)
//print("The final result is \(encoded)\nThe final dictionary is \(encodeDict)")


let (decoded,decodeDict) = lzwDecode(message: decodingTestInput2, dict: decodingTestDict2)
print("The final result is \(decoded)\nThe final dictionary is \(decodeDict)")
