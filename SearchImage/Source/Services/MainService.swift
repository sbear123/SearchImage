//
//  MainService.swift
//  SearchImage
//
//  Created by 박지현 on 2021/06/26.
//

import Foundation
import RxSwift
import RxCocoa

protocol MainServiceProtocol {
    var apiManager: APIManager { get }
    func getDocuments(_ search: String) -> Observable<Search>
    func updateDocuments(_ search: Search, text: String) -> Observable<Search>
}

class MainService: MainServiceProtocol {
    let apiManager: APIManager = APIManager()
    let disposeBag = DisposeBag()
    var page: Int = 1
    
    func getDocuments(_ text: String) -> Observable<Search> {
        page = 1
        let param: [String:Any] = ["query":text, "page":page, "size":30]
        return apiManager.getAPI(param: param)
    }
    
    func updateDocuments(_ search: Search, text: String) -> Observable<Search> {
        var result: Search = search
        page += 1
        let param: [String:Any] = ["query":text, "page":page, "size":30]
        return apiManager.getAPI(param: param).flatMap { data -> Observable<Search> in
            result.document += data.document
            result.meta = data.meta
            return Observable.just(result)
        }
    }
    
    
}
