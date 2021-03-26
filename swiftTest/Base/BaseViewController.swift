//
//  BaseViewController.swift
//  swiftTest
//
//  Created by 朱校明 on 2021/3/25.
//  Copyright © 2021 朱校明. All rights reserved.
//

import UIKit

class BaseViewController<VM: ViewModel>: UIViewController {

    //懒加载VM
    lazy var viewModel: VM = {
        guard let classType = "\(VM.self)".classType(VM.self) else {
            return VM()
        }
        let viewModel = classType.init()
        return viewModel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeUI()
        bindViewModel()
    }
    
    public func makeUI() {
        view.backgroundColor = .white
    }
    
    public func bindViewModel() {
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
