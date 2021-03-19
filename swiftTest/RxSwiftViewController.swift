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
            if let length = text?.length {
                return length > 3
            }else {
                return false
            }
        }.throttle(.seconds(3), scheduler: MainScheduler.instance).subscribe { (event) in
            print(event)
        }.disposed(by: disPool)
        
        textfield.rx.text.orEmpty
            .map { text  in
                text.count > 3
            }
            .bind(to: `switch`.rx.isHidden)
            .disposed(by: disPool)
        
        getNews()
        
        getUserInfo()
        
        
        let taps: Observable<Void> = button.rx.tap.asObservable()
        taps.subscribe { (onNext) in
                print("tap")
            }
            .disposed(by: disPool)
        
        
        
        textfield.rx.text.orEmpty.bind(to: label.rx.text).disposed(by: disPool)
        
        
        //自定义可监听序列
        let numbers: Observable<Int> = Observable.create { (observer) -> Disposable in
            observer.onNext(0)
            observer.onNext(1)
            observer.onNext(2)
            observer.onNext(3)
            observer.onCompleted()
            
            return Disposables.create {
                
            }
        }
        numbers.subscribe().disposed(by: disPool)
        
        textRxSwift()
        
        let ob1 = Observable<Int>.of(1, 2, 3)
        ob1.subscribe { (event) in
            print(event)
        } onError: { (error) in
            print(error)
        } onCompleted: {
            print("Completed")
        } onDisposed: {
            print("Disposed")
        }.disposed(by: disPool)

        
        
    }
    
    
}

extension RxSwiftViewController {
    
    func getNews() {
        let apiModel = ApiModel.init(name: "123", url: "456")
        print(apiModel.name.count)
        
        
        guard let url = URL(string: "https://www.baidu.com") else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url), completionHandler: { data, response, error in
            
            guard error == nil else {return}
            print("error", error)
                        
            guard let data = data else {return}
            print("data", data)
            
            guard let response = response else {return}
            print("response", response)
            
            
        }).resume()
        
        
        let block: (Data, URLResponse, Error?) -> Void = { data, response, error in
            print(data, response, error ?? "error", separator: "\n")
            
        }
        
        block(Data(), URLResponse(), nil)
    }
    
    
    struct UserInfo {
        var name: String
        var password: String
        var token: String
    }

    enum API {
        
        static func getToken(name: String, password: String, success: (String) -> Void, failure: (Error) -> Void) {
            
            success("z123k9a81j23a")
             
        }
        static func getUserInfo(token: String, success: (UserInfo) -> Void, failure: (Error) -> Void) {
            
            success(UserInfo(name: "xiaoming", password: "123456", token: token))
        }
        
        
    }
    
    func getUserInfo() -> Void {
        
        
        API.getToken(name: "zhu", password: "123", success: { (token) in
            
            API.getUserInfo(token: token, success: { (userInfo) in
                print(userInfo)
            }, failure: { (error) in
                print(error)
            })
            
        }, failure: { (error) in
            print(error)
        })
        
    }
}

extension String {
    
    var length: Int {
        get {
            self.count
        }
    }
    
}

enum DataError: Swift.Error {
    case cantParseJSON
}

enum CacheError: Swift.Error {
    case failedCaching
}


//网络请求
extension RxSwiftViewController {
    
    func textRxSwift() {
        
        getAPIDate(url: "ReactiveX/RxSwift")
        
        cacheData()
        
        parseString()
    }
    
    // Single
    func getRepo(_ repo: String) -> Single<[String: Any]> {
        
        return Single<[String: Any]>.create { (single) -> Disposable in
            
            let url = URL(string: "https://api.github.com/repos/\(repo)")!
            
            let task = URLSession.shared.dataTask(with: url) { (data, _, error) in
                
                if let error = error {
                    single(.error(error))
                    return
                }
                guard let data = data,
                      let json = try? JSONSerialization.jsonObject(with: data, options: .mutableLeaves),
                      let result = json as? [String: Any] else {
                        single(.error(DataError.cantParseJSON))
                        return
                }
                
                single(.success(result))
                
            }
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
    
    func getAPIDate(url: String) {
        
        getRepo(url).subscribe(onSuccess: { json in
            print("JSON:", json)
        }, onError: { error in
            print("Error:", error)
        }).disposed(by: disPool)
    }
    
    
    // Completable
    func cacheLocally() -> Completable {
        
        return Completable.create { (completable) -> Disposable in
            // Store some data locally
            
            var success = Bool()
            success = true
            
            guard success else {
                completable(.error(CacheError.failedCaching))
                return Disposables.create()
            }
            
            completable(.completed)
            return Disposables.create()
        }
    }
    
    func cacheData() {
        
        cacheLocally()
            .subscribe(onCompleted: {
            
            }, onError: { error in
            
            })
            .disposed(by: disPool)
    }
    
    // Maybe
    func generateString() -> Maybe<String> {
        
        return Maybe<String>.create { maybe -> Disposable in
            
            //只会执行一次，只执行success,completed和error不执行
            maybe(.success("RxSwift"))
            maybe(.completed)
            maybe(.error(CacheError.failedCaching))
            
            return Disposables.create()
        }
    }
    
    func parseString() {
        
        generateString()
            .subscribe(onSuccess: { (string) in
                print(string)
            }, onError: { (error) in
                print(error)
            }, onCompleted: {
                print("Completed")
            })
            .disposed(by: disPool)
    }
    
}
