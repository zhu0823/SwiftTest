//
//  RxSwiftViewController.swift
//  swiftTest
//
//  Created by 朱校明 on 2020/5/25.
//  Copyright © 2020 朱校明. All rights reserved.
//

import UIKit
import Foundation
import RxSwift
import RxCocoa




struct ApiModel {
    var name: String
    var url: String
    
    
}

class RxSwiftViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var segment: UISegmentedControl!
    @IBOutlet weak var textfield: UITextField!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var `switch`: UISwitch!
    @IBOutlet weak var progress: UIProgressView!
    
    let scrollView = UIScrollView()
    
    
    let disPool = DisposeBag()

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
//        let bind = Observable.combineLatest(searchBar.rx.text.orEmpty, textfield.rx.text.orEmpty)
//        bind.throttle(.milliseconds(100), latest: true, scheduler: MainScheduler.instance)
        
        
//        button.rx.tap
//            .subscribe { (event) in
//                print(event)
//            }.disposed(by: DisposeBag())
        
        button.rx.tap
            .subscribe(onNext: {
                print("button tap")
            }, onDisposed: {
                print("button Disposed")
            })
            .disposed(by: disPool)
        
        scrollView.frame = CGRect(x: 0, y: progress.frame.maxY, width: view.frame.width, height: view.frame.height-progress.frame.maxY)
        scrollView.contentSize = CGSize(width: view.frame.width, height: 2000)
        scrollView.backgroundColor = .gray
        view.addSubview(scrollView)
        
        
        scrollView.rx.contentOffset
            .subscribe { (event) in
                print(event)
            }
            .disposed(by: disPool)
        
        NotificationCenter.default.rx.notification(UIApplication.willEnterForegroundNotification, object: nil)
            .subscribe(onNext: { (notification) in
                print("willEnterForegroundNotification", notification.userInfo as Any)
            })
            .disposed(by: disPool)
        
        Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
            .subscribe(onNext: { (num) in
//                print(num)
            })
            .disposed(by: disPool)
        
        
        let tapGesture = UITapGestureRecognizer()
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(tapGesture)
        
        tapGesture.rx.event
            .subscribe(onNext: { (gesture) in
                print(gesture.view as Any)
            })
            .disposed(by: disPool)
        
        
        Observable<Any>.create { (observer) -> Disposable in
            observer.onNext(123)
            observer.onCompleted()
            return Disposables.create()
        }.subscribe { (event) in
            
        }.disposed(by: disPool)
        
        
        searchBar.rx.text.filter { (text) -> Bool in
            text?.count ?? 0 > 3
        }.throttle(.seconds(3), scheduler: MainScheduler.instance).subscribe { (event) in
            print(event)
        }.disposed(by: disPool)
        
        
    }
    
    func getNews() {
        let apiModel = ApiModel.init(name: "123", url: "456")
        print(apiModel.name)
        
        
        
        
    }
    
    
    
    
}

