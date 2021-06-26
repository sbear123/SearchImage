//
//  ImageModel.swift
//  SearchImage
//
//  Created by 박지현 on 2021/06/25.
//

import Foundation

struct Document: Codable {
    var collection: String?
    var thumbnail_url: String?
    var image_url: String?
    var width: Int?
    var height: Int?
    var display_sitename: String?
    var datetime: String?
    var doc_url: String?
}
