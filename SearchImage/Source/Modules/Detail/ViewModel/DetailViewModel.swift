//
//  DetailViewModel.swift
//  SearchImage
//
//  Created by 박지현 on 2021/06/27.
//

import Foundation
import UIKit

class DetailViewModel {
    
    var document: Document?
    
    func getNewHeight(_ vWidth: CGFloat) -> CGFloat {
        let ratio = vWidth / CGFloat(document!.width!)
        let newHeight = CGFloat(document!.height!) * ratio
        return newHeight
    }
    
    func stringConvertToDateTime() -> String {
        let stringFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        let formatter = DateFormatter()
        formatter.dateFormat = stringFormat
        formatter.locale = Locale(identifier: "ko")
        
        guard let tempDate = formatter.date(from: (document?.datetime)!)
        else { return "" }
        formatter.dateFormat = "yyyy년 MM월 dd일 eeee"
        
        return formatter.string(from: tempDate)
    }
}
