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
    func getDocuments(_ search: String, handler: @escaping (Search, Bool) -> Void)
    func fetchDocuments(_ search: Search, text: String, handler: @escaping (Search, Bool) -> Void)
}

class MainService: MainServiceProtocol {
    let apiManager: APIManager = APIManager()
    let disposeBag = DisposeBag()
    var page: Int = 1
    
    func getDocuments(_ text: String, handler: @escaping (Search, Bool) -> Void) {
        var result: Search = Search(meta: Meta(), document: [])
        page = 1
        let param: [String:Any] = ["query":text, "page":page, "size":30]
        apiManager.getAPI(param: param).subscribe(
            onNext: { data in
                result = data
                handler(result, true)
            },
            onError: { err in
                print(err)
                handler(result, false)
            }).disposed(by: disposeBag)
    }
    
    func fetchDocuments(_ search: Search, text: String, handler: @escaping (Search, Bool) -> Void) {
        var result: Search = search
        page += 1
        let param: [String:Any] = ["query":text, "page":page, "size":30]
        apiManager.getAPI(param: param).subscribe(
            onNext: { data in
                result.document += data.document
                result.meta = data.meta
                handler(result, true)
            }, onError: { err in
                print(err)
                handler(search, false)
            }).disposed(by: disposeBag)
    }
    
    
}
