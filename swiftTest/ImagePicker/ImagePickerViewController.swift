//
//  ImagePickerViewController.swift
//  swiftTest
//
//  Created by 朱校明 on 2021/3/24.
//  Copyright © 2021 朱校明. All rights reserved.
//

import UIKit
import SnapKit

class ImagePickerViewController: UIViewController {

    var imagePickerView: ImagePickerView?
    
    override func viewDidLoad() {
        imagePickerView = R.nib.imagePickerView.firstView(owner: nil)!
        view.addSubview(imagePickerView!)
    }
    
    override func viewDidLayoutSubviews() {
        imagePickerView!.snp.makeConstraints({ (make) in
            make.left.top.right.equalTo(view)
            make.height.equalTo(300)
        })
    }
}
