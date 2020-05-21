//
//  LoginViewController.swift
//  swiftTest
//
//  Created by 朱校明 on 2020/5/21.
//  Copyright © 2020 朱校明. All rights reserved.
//

import RxSwift
import Alamofire

class LoginViewController: UIViewController {
    
    var tableView: UITableView!
    
    let dataArr = ["djakj", "dsadq", "asdad"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView = UITableView.init(frame: CGRect.init(origin: CGPoint.init(x: 0, y: 0), size: UIScreen.main.bounds.size), style: .plain);
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: NSStringFromClass(UITableViewCell.self))
        tableView.delegate = self;
        tableView.dataSource = self
        view.addSubview(tableView)
        
        getNewsData()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let index = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: index, animated: true)
        }
    }
}


extension LoginViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(UITableViewCell.self), for: indexPath)
        cell.textLabel?.text = dataArr[indexPath.row]
        return cell
    }
}

extension LoginViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIViewController()
        vc.view.backgroundColor = .white
        vc.title = dataArr[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension LoginViewController {

    func getNewsData() {
        
        request("https://tianqiapi.com/api", method: .get, parameters: ["appid": "29787174", "appsecret": "nkAVU7de"], encoding: URLEncoding.default, headers: nil).response { (response) in
            
            do {
                let respJson = try JSONSerialization.jsonObject(with: response.data!, options: .mutableContainers)
                
                let respDic = respJson as! Dictionary<String, Any>
                
                print(respDic.unicodeDescription)
            }catch {
                print(error)
            }
        }
    }
}
