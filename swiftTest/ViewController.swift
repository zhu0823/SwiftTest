//
//  ViewController.swift
//  swiftTest
//
//  Created by 朱校明 on 2020/5/16.
//  Copyright © 2020 朱校明. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol TableViewSelectedProrocol {
    
    var controller: UIViewController {get}
}

enum TableViewSelectedType {
    case push
    case present
    case rxSwift
    case login
    case imagePicker
}

extension TableViewSelectedType: TableViewSelectedProrocol {
    
    var controller: UIViewController {
        switch self {
        case .push:
            return PushViewController()
        case .present:
            return PresentViewController()
        case .rxSwift:
            return RxSwiftViewController()
        case .login:
            return LoginViewController()
        case .imagePicker:
            return ImagePickerViewController()
        }
    }
}

struct DataModel {
    let name: String
    let vc: UIViewController
}

struct DataList {
    let data = Observable.just([
        DataModel(name: "PushViewController", vc: TableViewSelectedType.push.controller),
        DataModel(name: "PresentViewController", vc: TableViewSelectedType.present.controller),
        DataModel(name: "RxSwiftViewController", vc: TableViewSelectedType.rxSwift.controller),
        DataModel(name: "LoginViewController", vc: TableViewSelectedType.login.controller),
        DataModel(name: "ImagePickerViewController", vc: TableViewSelectedType.imagePicker.controller),
    ])
}

class ViewController: UIViewController {

    @IBOutlet weak var pushBtn: UIButton!
    @IBOutlet weak var presentBtn: UIButton!
    @IBOutlet weak var clickBtn: UIButton!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var swiftBtn: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    let dataList = DataList()
    
    let disposeBag = DisposeBag()
    
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
        
//        let com = add(5) >>> mut(10) >>> div(3) >>> sub(2)
        
//        print(com(12))
//
//        print(add2(10)(20)(30))
        
        testViewModel()
        
        testCreateRX()
        
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        
        dataList.data.bind(to: tableView.rx.items(cellIdentifier: "UITableViewCell")) { row, model, cell in
            cell.textLabel?.text = model.name
        }.disposed(by: disposeBag)
        
        tableView.rx.modelSelected(DataModel.self).subscribe({ (event) in
            if let vc = event.element?.vc {
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }).disposed(by: disposeBag)

    }

    
    
    func add(_ num: Int) -> (Int) -> Int { {$0 + num} }
    func sub(_ num: Int) -> (Int) -> Int { {$0 - num} }
    func mut(_ num: Int) -> (Int) -> Int { {$0 * num} }
    func div(_ num: Int) -> (Int) -> Int { {$0 / num} }
    
    
    func add1(_ v1: Int, _ v2: Int, _ v3: Int) -> Int {
        v1 + v2 + v3
    }
    
    func add2(_ v1: Int) -> ((Int) -> (Int) -> Int) {
        return { a in
            return { b in
                return v1 + b + a
            }
        }
    }
    
}

// MARK: - IBAction
extension ViewController {
    
    @IBAction func rxSwiftAction(_ sender: Any) {
        navigationController?.pushViewController(RxSwiftViewController.init(), animated: true)
    }
    
    @IBAction func loginAction(_ sender: Any) {
        navigationController?.pushViewController(LoginViewController(), animated: true)
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

infix operator >>> : AdditionPrecedence
func >>><A, B, C>(_ f1: @escaping (A) -> B, _ f2: @escaping (B) -> C) -> (A) -> C {
    return {
        f2(f1($0))
    }
}
