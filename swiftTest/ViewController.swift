//
//  ViewController.swift
//  swiftTest
//
//  Created by 朱校明 on 2020/5/16.
//  Copyright © 2020 朱校明. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var pushBtn: UIButton!
    @IBOutlet weak var presentBtn: UIButton!
    @IBOutlet weak var clickBtn: UIButton!
    @IBOutlet weak var countLabel: UILabel!
    
    var count: Int = 0 {
        willSet {
            countLabel.text = "\(newValue)"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        title = "Home"
        
        count = 0
    }


    @IBAction func pushAction(_ sender: Any) {
        
        weak var wSelf = self
        let vc = PushViewController()
        vc.didAdd = { (num: Int) in
            wSelf?.count += num
        }
        vc.didSub = { (num: Int) in
            wSelf?.count -= num
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func presentAction(_ sender: Any) {
        let nv = UINavigationController.init(rootViewController: PresentViewController())
        present(nv, animated: true, completion: {})
    }
    @IBAction func clickAction(_ sender: Any) {
        count += 1
    }
}

