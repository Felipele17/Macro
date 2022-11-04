//
//  String + transfomToMoney.swift
//  Macro
//
//  Created by Vitor Cheung on 02/11/22.
//

import Foundation
extension String {
    func transformToMoney() -> String? {
        
        if self.isEmpty {  return nil }
        let numOfVirgula = self.filter({ $0 == "," }).count
        if  numOfVirgula > 1 { return nil }
        
        var number = self
        
        let subStrings = number.split { $0 == "," }
        if let subStringFirt = subStrings.first {
            let numPoint = Int(floor(Double(subStringFirt.count / 4)))
            var stringFirt = String(subStringFirt).replacingOccurrences(of: ".", with: "")
            let countStringFirt = stringFirt.count
            for pos in stride(from: 1, through: numPoint, by: 1) {
                let index = countStringFirt-(3*pos)
                let strInd = stringFirt.index(stringFirt.startIndex, offsetBy: index)
                if index != 0 {
                    stringFirt.insert(".", at: strInd)
                }
            }
            if let subStringLast = subStrings.last {
                if subStrings.count == 2 {
                    number = String(stringFirt + String(",") + subStringLast)
                } else {
                    number = String(stringFirt)
                    if numOfVirgula == 1 {
                        number.append(",")
                    }
                }
            }
        }
        return number
    }
}
