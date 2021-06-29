//
//  AlertPresenterProtocol.swift
//  SearchImage
//
//  Created by 박지현 on 2021/06/28.
//

import Foundation

protocol AlertPresenterProtocol {
    func ErrorAlert(body: String)
    func WarningAlert(title:String, body: String)
}
