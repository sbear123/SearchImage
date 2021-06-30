//
//  AlertPresenter.swift
//  SearchImage
//
//  Created by 박지현 on 2021/06/28.
//

import Foundation
import SwiftMessages

final class AlertPresenter: AlertPresenterProtocol {
    
    public static let instance: AlertPresenter = AlertPresenter()
    
    func ErrorAlert(body: String) {
        let view = MessageView.viewFromNib(layout: .cardView)
        view.configureTheme(.warning)
        view.configureDropShadow()
        view.button?.isHidden = true
        view.configureContent(title: "error", body: body)
        var warningConfig = SwiftMessages.defaultConfig
        warningConfig.presentationStyle = .center
        SwiftMessages.show(config: warningConfig, view: view)

    }
    
    func WarningAlert(title: String, body: String) {
        let view = MessageView.viewFromNib(layout: .cardView)
        view.configureTheme(.error)
        view.configureDropShadow()
        view.button?.isHidden = true
        view.configureContent(title: title, body: body)
        SwiftMessages.show(view: view)
    }
    
}
