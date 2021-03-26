//
//  ViewModel.swift
//  swiftTest
//
//  Created by 朱校明 on 2021/3/25.
//  Copyright © 2021 朱校明. All rights reserved.
//

import Foundation
import NSObject_Rx

protocol ViewModelable {
    
    associatedtype Input
    associatedtype Output
    
    func transform(_ input: Input) -> Output
}

class ViewModel {
    
    required init() {}
}

extension ViewModel: HasDisposeBag {
    
}
