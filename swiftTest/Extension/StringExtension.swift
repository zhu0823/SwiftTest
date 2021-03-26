//
//  StringExtension.swift
//  swiftTest
//
//  Created by 朱校明 on 2021/3/25.
//  Copyright © 2021 朱校明. All rights reserved.
//

import Foundation

extension String {
    
    public func classType<T>(_ type: T.Type) -> T.Type? {

        guard let nameSpace = Bundle.main.infoDictionary!["CFBundleExecutable"] as? String else {
            return nil
        }
        guard let nameSpaceClass = NSClassFromString(nameSpace + "." + self) else {
            return nil
        }
        guard let classType = nameSpaceClass as? T.Type else {
            return nil
        }
        return classType
    }
}
