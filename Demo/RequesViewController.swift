//
//  RequesViewController.swift
//  Demo
//
//  Created by ChengGuoTech || CG-005 on 2020/9/2.
//  Copyright © 2020 ChengGuoTech || CG-005. All rights reserved.
//

import UIKit
import Alamofire

class RequesViewController: UIViewController {

    private let baseUrl: String = "https://jsonplaceholder.typicode.com"
    
    let label_one : UILabel = {
       let lab = UILabel()
        lab.translatesAutoresizingMaskIntoConstraints = false
        lab.textAlignment = .center
        lab.text = "网络测试"
        return lab
    }()
    
    lazy var SendButton : UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.backgroundColor = .blue
        btn.setTitle("我是btn", for: UIControl.State.normal)
        btn.addTarget(self, action: #selector(handleSend), for: UIControl.Event.touchDragInside)
        return btn
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .white
    
        setUpView()
    }
    
    func setUpView(){
        view.addSubview(label_one)
        view.addSubview(SendButton)
        label_one.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        SendButton.snp.makeConstraints { (make) in
            make.top.equalTo(label_one.snp.bottom).offset(10)
            make.centerX.equalTo(label_one)
            make.height.equalTo(50)
        }
        
    }
    
    @objc func handleSend(_ btn:UIButton){
        
        let post = Post(postId: 0, title: "Post Title", body: "Post Body", userId: 10)
        //post 请求
        //encoder 参数格式化
        AF.request( self.baseUrl + "/posts",method: .post,parameters: post, encoder: JSONParameterEncoder.default).response{
            response in
            if let responseData = response.data,let responseJson = try? JSONSerialization.jsonObject(with: responseData, options: []){
                print(responseJson)
            }
        }
    }
    

}



