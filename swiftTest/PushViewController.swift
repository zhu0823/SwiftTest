//
//  PushViewController.swift
//  swiftTest
//
//  Created by 朱校明 on 2020/5/17.
//  Copyright © 2020 朱校明. All rights reserved.
//

import UIKit
import SnapKit

class PushViewController: UIViewController {
    
    
    var didAdd: ((Int) -> Void)?
    var didSub: ((Int) -> ())?
    
    let textField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Push"
        view.backgroundColor = .white
        
        initBtn()
    }
    
    func initBtn() {
        
        let addBtn1 = UIButton.init(type: .custom)
        addBtn1.frame = CGRect.init(x: 30, y: 100, width: 100, height: 40)
        addBtn1.setTitle("+10", for: .normal)
        addBtn1.setTitleColor(.black, for: .normal)
        addBtn1.addTarget(self, action: #selector(addBtn1Action), for: .touchUpInside)
        view.addSubview(addBtn1)
        
        let addBtn2 = UIButton.init(type: .custom)
        addBtn2.frame = CGRect.init(x: 30, y: 150, width: 100, height: 40)
        addBtn2.setTitle("+20", for: .normal)
        addBtn2.setTitleColor(.black, for: .normal)
        addBtn2.addTarget(self, action: #selector(addBtn2Action), for: .touchUpInside)
        view.addSubview(addBtn2)
        
        let addBtn3 = UIButton.init(type: .custom)
        addBtn3.frame = CGRect.init(x: 30, y: 200, width: 100, height: 40)
        addBtn3.setTitle("+30", for: .normal)
        addBtn3.setTitleColor(.black, for: .normal)
        addBtn3.addTarget(self, action: #selector(addBtn3Action), for: .touchUpInside)
        view.addSubview(addBtn3)
        
        let subBtn1 = UIButton.init(type: .custom)
        subBtn1.frame = CGRect.init(x: 150, y: 100, width: 100, height: 40)
        subBtn1.setTitle("-10", for: .normal)
        subBtn1.setTitleColor(.black, for: .normal)
        subBtn1.addTarget(self, action: #selector(subBtn1Action), for: .touchUpInside)
        view.addSubview(subBtn1)
        
        let subBtn2 = UIButton.init(type: .custom)
        subBtn2.frame = CGRect.init(x: 150, y: 150, width: 100, height: 40)
        subBtn2.setTitle("-20", for: .normal)
        subBtn2.setTitleColor(.black, for: .normal)
        subBtn2.addTarget(self, action: #selector(subBtn2Action), for: .touchUpInside)
        view.addSubview(subBtn2)
        
        let subBtn3 = UIButton.init(type: .custom)
        subBtn3.frame = CGRect.init(x: 150, y: 200, width: 100, height: 40)
        subBtn3.setTitle("-30", for: .normal)
        subBtn3.setTitleColor(.black, for: .normal)
        subBtn3.addTarget(self, action: #selector(subBtn3Action), for: .touchUpInside)
        view.addSubview(subBtn3)
        
        textField.placeholder = "输入用户名"
        textField.borderStyle = .roundedRect
        view.addSubview(textField)
        textField.snp_makeConstraints { (make) in
            make.left.equalTo(10)
            make.top.equalTo(subBtn3.snp_bottom)
            make.width.equalTo(200)
            make.height.equalTo(40)
        }
    }
    
    //MARK: - Selector
    @objc func addBtn1Action(_ sender: UIButton) {
        didAddNum(num: 10)
    }
    @objc func addBtn2Action(_ sender: UIButton) {
        didAddNum(num: 20)
    }
    
    @objc func addBtn3Action(_ sender: UIButton) {
        didAddNum(num: 30)
    }
    @objc func subBtn1Action(_ sender: UIButton) {
        didSubNum(num: 10)
    }
    @objc func subBtn2Action(_ sender: UIButton) {
        didSubNum(num: 20)
    }
    @objc func subBtn3Action(_ sender: UIButton) {
        didSubNum(num: 30)
    }
    
    //MARK: - Logic
    func didAddNum(num: Int) {
        if didAdd != nil {
            didAdd!(num)
        }
        navigationController?.popViewController(animated: true)
    }
    func didSubNum(num: Int) {
        if didSub != nil {
            didSub!(num)
        }
        navigationController?.popViewController(animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        textField.resignFirstResponder()
    }
}
