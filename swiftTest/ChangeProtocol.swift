//
//  ChangeProtocal.swift
//  swiftTest
//
//  Created by 朱校明 on 2020/5/17.
//  Copyright © 2020 朱校明. All rights reserved.
//

import Foundation

enum NumChangeType: Int {
    case changeAdd
    case changeSub
}

protocol ChangeProtocol {
    func didChange(changeType: NumChangeType, num: Int)
}
