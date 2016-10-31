import Foundation

let origin = ["000000000000000000000000",
              "011110011110011110011110",
              "010000010000010000010010",
              "011100011100011100011110",
              "010000010000010000010000",
              "010000011110011110010000",
              "000000000000000000000000"]

//let encoded = onedEncode(origin)
//print(encoded)
//
//let decoded = onedDecode(encoded)
//print(decoded)

let twodEncoded = twodEncode(origin, k: 8)
print(twodEncoded)
//print( twodEncSingleLine(ref: origin[0], line: origin[1]))


////print(onedDecSingleLine(line: "0101000"))
//print(twodDecSingleLine2(ref: "010000010000010000010010",
//                        msg: "1000011100001110000111000111"))

let twodDecoded = twodDecode(twodEncoded)
print(twodDecoded)
