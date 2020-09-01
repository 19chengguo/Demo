//
//  DemoTabBarController.swift
//  Demo
//
//  Created by ChengGuoTech || CG-005 on 2020/8/21.
//  Copyright © 2020 ChengGuoTech || CG-005. All rights reserved.
//

import UIKit

class DemoTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setUpTabBar(HomeViewController(),"首页", "home", "home_high")
        setUpTabBar(LiveViewController(), "Live", "live", "live_height")

        setUpTabBar(MyViewController(), "我的","my", "my_high")
        
        /* 还原icon原色方法：*/
        // 方法一：the code 修改图片和字体颜色
         self.tabBar.tintColor = UIColor.init(red: 218 / 255, green: 71 / 255, blue: 80 / 255, alpha: 1.0)
        // 方法二：当然 你可以去Assets 文件夹中选中图片 在详情中 修改 render as 属性为原图
        // 方法三: controller.tabBarItem.image = UIImage(named: nor)?.withRenderingMode(. alwaysoriginal)
    }
    
    
    
    //
    func setUpTabBar(_ controller:UIViewController,_ title:String,_ nor:String , _ sele:String ){
        
        let controller = DemoNavigationController(rootViewController: controller)
        controller.tabBarItem.image = UIImage(named: nor);
        controller.tabBarItem.selectedImage = UIImage(named: sele);
        controller.tabBarItem.title = title
        self.addChild(controller)
        
    }

}
