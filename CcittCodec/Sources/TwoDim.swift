//
//  TwoDim.swift
//  CcittCodec
//
//  Created by Yang Zhou on 2016-10-29.
//
//

import Foundation

let passCode = "0001"
let horizontalCodeHead = "001"
let verticalCode = ["0000011","000011","011","1","010","000010","0000010"]

enum Mode {
    case pass
    case horizontal
    case vertical (Int)
    case error
}

enum Color : String {
    case white = "0"
    case black = "1"
}

extension String {
    func nextChangingElement(after: String.Index, ref: String) -> String.Index {
        guard after != self.endIndex else {
            return after
        }
        for nextIndex in self.characters.indices[self.index(after: after)..<self.endIndex] {
            if (self[nextIndex] != ref[after]) && (self[self.index(before: nextIndex)] == ref[after]) {
                return nextIndex
            }
        }
        return self.endIndex
    }
}


func twodEncSingleLine (ref: String, line: String) -> String {

    var encoded = [endOfLine+"0"]
    let line = "0" + line
    let ref = "0" + ref
    var a0 = line.startIndex
    while a0 < line.endIndex {
        let a1 = line.nextChangingElement(after: a0, ref: line)
        let b1 = ref.nextChangingElement(after: a0, ref: line)
        let b2 = ref.nextChangingElement(after: b1, ref: ref)
        
        if b2 < a1 { //Pass Mode
            encoded.append(passCode)
            a0 = b2
        } else if abs(line.characters.distance(from: a1, to: b1)) <= 3 {
            // Vertical Mode
            let delta = line.characters.distance(from: a1, to: b1)
            let v = verticalCode[delta + 3]
            encoded.append(v)
            a0 = a1
        } else {
            // Horizontal Mode
            let a2 = line.nextChangingElement(after: a1, ref: line)
            
            let a0a1 = (a0 == line.startIndex) ? (line.substring(with: (line.index(after: a0) ..< a1))) : (line.substring(with: a0..<a1))

            
            let mA0a1 = a0a1.hasPrefix("0") ? whiteTermCode[a0a1.characters.count] : blackTermCode[a0a1.characters.count]
            let a1a2 = line.substring(with: a1..<a2)
            let mA1a2 = a1a2.hasPrefix("0") ? whiteTermCode[a1a2.characters.count] : blackTermCode[a1a2.characters.count]
            encoded.append(horizontalCodeHead + mA0a1 + mA1a2)
            a0 = a2
        }
    }
    return encoded.joined()
}

func twodEncode(_ message : [String], k: Int) -> String {
    var encoded = [String]()
    for (order, line) in message.enumerated() {
        if (order % k) == 0 {
            let encodedLine = String(onedEncSingleLine(line: line).characters.dropFirst(endOfLine.characters.count))
            encoded.append(endOfLine + "1" + encodedLine)
        } else {
            encoded.append(twodEncSingleLine(ref: message[order-1], line: message[order]))
        }
    }
//    encoded.append(String(repeating: endOfLine, count: 6))
    return encoded.joined()
}


func twodDecSingleLine2 (ref: String, msg: String) -> String {
    var line = "0"
    let ref = "0" + ref
    var a0 = line.startIndex
    
    var codeword = ""
    var color = "0"
    var index = msg.startIndex
    while index < msg.endIndex {
        let c = msg[index]
        let b1 = ref.nextChangingElement(after: a0, ref: line)
        let b2 = ref.nextChangingElement(after: b1, ref: ref)
        
        codeword += String(c)
        if codeword == passCode {
            codeword = ""
            for _ in ref.characters.indices[a0..<b2] {
                line += color
            }
            a0 = line.index(before: line.endIndex)
        } else if var delta = verticalCode.index(of: codeword) {
            codeword = ""
            delta = 3 - delta
            let b1p = ref.index(b1, offsetBy: delta)
            let n = ref.distance(from: a0, to: b1p)
            line += String(repeating: color, count: n-1)
            color = color == "0" ? "1" : "0"
            if b1p != ref.endIndex {
                line += color
            }
            a0 = line.index(before: line.endIndex)
        } else if codeword == horizontalCodeHead {
            codeword = ""
            let colorOrder = [color, color == "0" ? "1" : "0"]
            var mcode = ""
            
            for col in colorOrder {
                index = msg.index(after: index)
                while index < msg.endIndex {
                    mcode += String(msg[index])
                    if let len = (col == "0") ? whiteTermCode.index(of: mcode) : blackTermCode.index(of: mcode) {
                        mcode = ""
                        line += String(repeating: col, count: len)
                        break
                    }
                    index = msg.index(after: index)
                }
            }
            a0 = line.index(before: line.endIndex)
        }
        index = msg.index(after: index)
    }
    return String(line.characters.dropFirst())
}

func twodDecode (_ message : String) -> [String] {
    var decoded = [String]()
    let lines = message.components(separatedBy: endOfLine).dropFirst()
    for line in lines {
        if line[line.startIndex] == "1" {
            decoded.append(onedDecSingleLine(line: String(line.characters.dropFirst())))
        } else {
            let decodedLine = twodDecSingleLine2(ref: decoded[decoded.count-1], msg: String(line.characters.dropFirst()))
            decoded.append(decodedLine)
        }
    }
    return decoded
}
