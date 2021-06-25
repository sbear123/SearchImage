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
    func getAPI(param: Dictionary<String, Any>) -> DataRequest {
        return AF.request(baseUrl,
                          method: .get,
                          parameters: param,
                          encoding: URLEncoding.queryString)
            .validate(statusCode: 200..<400)
    }
    
    func post(param: Dictionary<String, Any>) -> Single<SearchModel> {
        let headers: HTTPHeaders = [
            "Authorization": apiKey
        ]
        return Single<SearchModel>.create { single in
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
                        let meta = try? JSONDecoder().decode(MetaModel.self, from: json["meta"].rawData())
                        var document: [ImageModel] = []
                        for d in json["documents"].array! {
                            let img = try? JSONDecoder().decode(ImageModel.self, from: d.rawData())
                            document.append(img!)
                        }
                        let data = SearchModel(meta: meta!, document: document)
                        single(.success(data))
                    case .failure(let err):
                        single(.failure(err))
                    }
                }
            return Disposables.create()
        }
    }
}
