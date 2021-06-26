//
//  MetaModel.swift
//  SearchImage
//
//  Created by 박지현 on 2021/06/25.
//

import Foundation

struct Meta: Codable {
    var total_count: Int
    var pageable_count: Int
    var is_end: Bool
    
    init() {
        total_count = 0
        pageable_count = 0
        is_end = false
    }
}
