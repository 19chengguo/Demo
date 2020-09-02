//
//  test.swift
//  Demo
//
//  Created by ChengGuoTech || CG-005 on 2020/9/2.
//  Copyright © 2020 ChengGuoTech || CG-005. All rights reserved.
//

import Foundation
import UIKit

var images = ["1","2"]
var test2 : [UIImage]?
//func retrieved(){
//
//    var i = 0
//    while i < images.count {
//        if let checkedUrl = URL(string: images[i]) {
//            downloadImage(url: checkedUrl) { (image) in
//                let indexPath = IndexPath.init(row: i, section: 0)
//                if  let cell = self.colltionView.cellForItem(at: indexPath) as? customCell{
//                    cell.imageView.image = image
//                    self.colltionView.reloadItems(at: [indexPath])
//                    print("更新")
//                }else{
//                    self.colltionView.reloadData()
//                }
//            }
//        }
//        i+=1
//    }
//
//}

func downloadImage(url: URL,completion: @escaping (UIImage)->Void) {
    DispatchQueue.global(qos: .userInitiated).async {
        getDataFromUrl(url: url) { (data, response, error) in
            guard let data = data,error == nil else { return }
            if let image = UIImage(data: data){
                DispatchQueue.main.async {
                    test2?.append(image)
                    completion(image)
                }
            }
        }
    }
}

/**
  @escaping
 fix:Escaping closure captures non-escaping parameter 'completion'
 */
func getDataFromUrl(url:URL,completion: @escaping (_ data: Data?,_ response:URLResponse?,_ error: Error?)->Void){
    
    URLSession.shared.dataTask(with: url) { (data, response, error) in
        completion(data,response,error)
    }.resume()
}
