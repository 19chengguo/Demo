//
//  Photos.swift
//  Demo
//
//  Created by ChengGuoTech || CG-005 on 2020/9/2.
//  Copyright © 2020 ChengGuoTech || CG-005. All rights reserved.
//

import Foundation

struct Photo: Decodable {
    var title :String
    var url :String
    var albumId: Int
    var id : Int
    var thumbnailUrl : String
}
