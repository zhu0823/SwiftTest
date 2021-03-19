//
//  LoginViewController.swift
//  swiftTest
//
//  Created by 朱校明 on 2020/5/21.
//  Copyright © 2020 朱校明. All rights reserved.
//

import RxSwift
import Alamofire
import HandyJSON

class LoginViewController: UIViewController {
    
    var tableView: UITableView!
    
    let dataArr = ["djakj", "dsadq", "asdad"]
    
    let block: (UIView?) -> Bool = { view in
        guard let v = view else {
            return false
        }
        print(view!)
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView = UITableView.init(frame: CGRect.init(origin: CGPoint.init(x: 0, y: 0), size: UIScreen.main.bounds.size), style: .plain);
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: NSStringFromClass(UITableViewCell.self))
        tableView.delegate = self;
        tableView.dataSource = self
        view.addSubview(tableView)
        
        getNewsData(model: WeatherModel())
        
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

    func getNewsData<T: HandyJSON>(model: T) {
        
        let apiDay = "https://tianqiapi.com/free/day"
        let _ = "https://tianqiapi.com/free/week"
        
        request(apiDay, method: .get, parameters: ["appid": "29787174", "appsecret": "nkAVU7de"], encoding: URLEncoding.default, headers: nil).response { (response) in
            
            do {
                let respJson = try JSONSerialization.jsonObject(with: response.data!, options: .mutableContainers) as! Dictionary<String, Any>
                
                print(respJson)
                
                let model = T.deserialize(from: respJson)

                print(model, self.block(self.view))
                 
            }catch {
                
                print(error)
            }
        }
    }
}

///
class WeatherModel: HandyJSON {
    
    var win_meter: String?
    
    var update_time: String?
    
    var wea_img: String?
    
    var tem: String?
    
    var cityid: String?
    
    var tem_night: String?
    
    var air: String?
    
    var win: String?
    
    var tem_day: String?
    
    var win_speed: String?
    
    var city: String?
    
    var wea: String?
    
    required init() {}
}

