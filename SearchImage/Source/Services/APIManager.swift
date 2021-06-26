//
//  APIManager.swift
//  SearchImage
//
//  Created by 박지현 on 2021/06/25.
//

import Foundation
import RxSwift
import RxCocoa
import Alamofire
import SwiftyJSON


class APIManager: BaseAPI {
    func getAPI(param: Dictionary<String, Any>) -> Observable<Search> {
        let headers: HTTPHeaders = [
            "Authorization": apiKey
        ]
        return Observable<Search>.create { observer in
            AF.request(self.baseUrl,
                       method: .get,
                       parameters: param,
                       encoding: URLEncoding.queryString,
                       headers: headers)
                .validate(statusCode: 200..<400)
                .responseJSON{ response in
                    switch response.result {
                    case .success(let value):
                        let json = JSON(value)
                        let meta = try? JSONDecoder().decode(Meta.self, from: json["meta"].rawData())
                        var document: [Document] = []
                        for d in json["documents"].array! {
                            let img = try? JSONDecoder().decode(Document.self, from: d.rawData())
                            document.append(img!)
                        }
                        let data = Search(meta: meta!, document: document)
                        observer.onNext(data)
                    case .failure:
                        observer.onError(CustomError.Custom(title: "API 연결 문제", msg: "API검색이 되지 않습니다."))
                    }
                }
            return Disposables.create()
        }
    }
}
