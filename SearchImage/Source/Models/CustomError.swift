//
//  CustomError.swift
//  SearchImage
//
//  Created by 박지현 on 2021/06/26.
//

import Foundation

enum CustomError: Error {
    case Custom(title: String, msg: String)
}
