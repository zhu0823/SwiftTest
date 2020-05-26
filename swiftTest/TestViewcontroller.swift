//
//  TestViewcontroller.swift
//  swiftTest
//
//  Created by 朱校明 on 2020/5/25.
//  Copyright © 2020 朱校明. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

extension ViewController {
    
    func testViewModel() {
        
        let disposeBag = DisposeBag()
        
        let one = 10
        let two = 20
        
        let obs1 = Observable.just(one, scheduler: MainScheduler.instance)
        
        let obs2 = Observable.of(one, two)
        
        let obs3 = Observable.of([one, two])
        
        let obs4 = Observable.from([one, two])
        
        let obs5 = Observable.range(start: 1, count: 10)
        
        let obs6 = Observable<Void>.empty()
        
        obs1.subscribe({ event in
            print("obs1",event)
        })
        
        obs2.subscribe { (event) in
            print("obs2", event)
        }.dispose()
        
        obs3.subscribe { temp in
            print("obs3", temp)
        }.disposed(by: disposeBag)
        
        
        obs6.subscribe(onNext: { (element) in
            print("obs6", element)
        }, onError: { (error) in
            print(error)
        }, onCompleted: {
            print("obs6 Completed")
        }) {
            print("obs6 dispose")
        }.dispose()
        
        
        
        print("end")
    }
    
    
    
}

enum RxError: Error {
    case myError
}

extension ViewController {
    
    func testCreateRX() {
        
        Observable<String>.create { (observer) -> Disposable in
            observer.onNext("1")
            observer.onError(RxError.myError)
            observer.onCompleted()
            observer.onNext("2")
            return Disposables.create()
        }.subscribe(onNext: { event in
            print("onNext")
        }, onError: { event in
            print("onError")
        }, onCompleted: {
            print("onCompleted")
        }, onDisposed: {
            print("onDisposed")
        }).disposed(by: DisposeBag())
    }
    
}
