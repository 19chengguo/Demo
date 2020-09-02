//
//  UIImageViewExtension.swift
//  Demo
//
//  Created by ChengGuoTech || CG-005 on 2020/9/2.
//  Copyright © 2020 ChengGuoTech || CG-005. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

extension UIImageView{
    func setImage(imageUrl: String){
        self.kf.setImage(with: URL(string: imageUrl))
    }
}
