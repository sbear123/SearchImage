//
//  MainViewModel.swift
//  SearchImage
//
//  Created by 박지현 on 2021/06/25.
//

import Foundation
import RxSwift
import RxCocoa
import Alamofire

class MainViewModel {
    
    static let shared = MainViewModel()
    
    var text = ""
    var searchData: Search = Search(meta: Meta(), document: [])
    
    let network = APIManager()
    let service = MainService()
    let disposeBag = DisposeBag()
    
    func countImages() -> Int {
        return searchData.document.count
    }
    
    func getData(cnt: Int) -> Document {
        return searchData.document[cnt]
    }
    
    func getIsEnd() -> Bool {
        return searchData.meta!.is_end
    }
    
    func getNewData(search: String, handler: @escaping (Bool) -> Void){
        text = search
        service.getDocuments(search).bind(
            onNext: { data in
                self.searchData = data
            }).disposed(by: disposeBag)
    }
    
    func fetchData(handler: @escaping (Bool) -> Void){
        if text == "" || searchData.meta!.is_end {
            handler(false)
            return
        }
        service.updateDocuments(searchData, text: text).bind(onNext: { data in
            self.searchData = data
            handler(true)
        }).disposed(by: disposeBag)
    }
    
}
