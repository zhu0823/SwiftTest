//
//  ImagePickerViewModel.swift
//  swiftTest
//
//  Created by 朱校明 on 2021/3/24.
//  Copyright © 2021 朱校明. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Photos

class ImagePickerViewModel: ViewModel {
    
    struct Input {
//        let imageTap: ControlEvent<Void>
//        let videoTap: ControlEvent<Void>
        
        
        let image: Driver<UIImage>
        let video: Driver<UIImage>
        let transformTap: ControlEvent<Void>
    }
    struct Output {
        let livePhoto: Driver<PHLivePhoto>
    }
}

extension ImagePickerViewModel {
    
    func transform(_ input: Input) -> Output {
        
//        input.imageTap.subscribe { (event) in
//            print("ImageTap")
//        }.disposed(by: disposeBag)
//
//        let image = R.image.image()!
//        let image1 = R.image.image1()!
//
        return Output(livePhoto: Driver<PHLivePhoto>.empty())
        
        
    }
}
