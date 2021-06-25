//
//  Image.swift
//  SearchImage
//
//  Created by 박지현 on 2021/06/25.
//

import Foundation

struct SearchModel: Codable {
    var meta: MetaModel
    var document: [ImageModel]
}
