//
//  ObjectUnicode.swift
//  swiftTest
//
//  Created by 朱校明 on 2020/5/21.
//  Copyright © 2020 朱校明. All rights reserved.
//

import UIKit

public extension Array{

    var unicodeDescription : String {
        
        return self.description.stringByReplaceUnicode
    }
}

public extension Dictionary {

   var unicodeDescription : String{
    
        return self.description.stringByReplaceUnicode
    }
}

public extension String {
    
    var unicodeDescription : String{
    
        return self.stringByReplaceUnicode
    }
    
    var stringByReplaceUnicode : String{

        let tempStr1 = self.replacingOccurrences(of: "\\u", with: "\\U")
        let tempStr2 = tempStr1.replacingOccurrences(of: "\"", with: "\\\"")
        let tempStr3 = "\"".appending(tempStr2).appending("\"")
        let tempData = tempStr3.data(using: String.Encoding.utf8)
        var returnStr:String = ""
        do {
            returnStr = try PropertyListSerialization.propertyList(from: tempData!, options: [.mutableContainers], format: nil) as! String
        } catch {
            print(error)
        }
        return returnStr.replacingOccurrences(of: "\\n", with: "\n")
    }
}
