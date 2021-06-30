//
//  DetailCoordinator.swift
//  SearchImage
//
//  Created by 박지현 on 2021/06/30.
//

import UIKit

protocol Coordinator: AnyObject {
    func pushToDetail(_ navigationController: UINavigationController?, doc: Document)
}

class DetailCoordinator: Coordinator {
    func pushToDetail(_ navigationController: UINavigationController?, doc: Document) {
        let storyboard = UIStoryboard(name: "Detail", bundle: nil)
        let detailVC = (storyboard.instantiateViewController(identifier: "DetailViewController") as? DetailViewController)!
        detailVC.vm.document = doc
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
