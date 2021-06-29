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
}
