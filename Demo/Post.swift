//
//  Post.swift
//  Demo
//
//  Created by ChengGuoTech || CG-005 on 2020/9/2.
//  Copyright © 2020 ChengGuoTech || CG-005. All rights reserved.
//

import Foundation
/**
    一遍用来发送请求参数
 */
struct Post: Codable {
    let postId: Int
    let title: String
    let body : String
    let userId: Int
    
    //重写model key，需要Codable
    //因为 属性名和响应的不相同
    enum CodingKeys: String, CodingKey {
        case postId = "id"
        case title
        case body
        case userId
    }
}
