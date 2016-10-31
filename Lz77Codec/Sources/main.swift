import Foundation

let encodingTestCodewords1 = ["a":1, "b":2, "c":3, "d":4]
let encodingTestInput1 = "acbaacbabacbaacbaadaaa"

let encodingTestCodewords2 = ["a":1, "b":2, "c":3, "d":4, "r":5]
let encodingTestInput2 = "cabracadabrarrarrad"

let decodingTestCodewords1 = [1:"a", 2:"b", 3:"c", 4:"d"]
let decodingTestInput1 = [(4, 4, 2), (2, 1, 3), (3, 2, 1), (4, 4, 4), (3, 2, 1)]

let decodingTestCodewords2 = [1:"a", 2:"b", 3:"c", 4:"d", 5:"r"]
let decodingTestInput2 = [(0, 0, 4), (7, 4, 5), (3, 5, 4)]


let encoded = lz77Encode(encodingTestInput1, windowSize: 8, lookaheadBufferSize: 4, codeword: encodingTestCodewords1)
print(encoded)

let decoded = lz77Decode(decodingTestInput1, searchBuffer: "acba", codeword: decodingTestCodewords1)
print(decoded)
