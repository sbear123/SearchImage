//
//  MainViewModel.swift
//  SearchImage
//
//  Created by 박지현 on 2021/06/25.
//

import Foundation
import RxSwift
import RxCocoa

class MainViewModel {
    
    private var text = ""
    private var searchData: Search = Search(meta: Meta(), document: [])
    
    let service = MainService()
    var disposeBag = DisposeBag()
    
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
        service.getDocuments(search){ data, success in
            if success {
                self.searchData = data
                handler(true)
            }
            else { handler(false) }
        }
    }
    
    func fetchData(handler: @escaping (Bool) -> Void){
        if searchData.meta!.is_end {
            handler(false)
            return
        }
        service.fetchDocuments(searchData, text: text) { data, success in
            if success {
                self.searchData = data
                handler(true)
            }
            else { handler(false) }
        }
    }
    
}
