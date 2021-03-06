//
//  ViewController.swift
//  SearchImage
//
//  Created by 박지현 on 2021/06/26.
//

import UIKit
import RxSwift
import RxCocoa
import SwiftMessages

class MainViewController: UIViewController, UISearchBarDelegate {
    let vm: MainViewModel = MainViewModel()
    let disposeBag = DisposeBag()
    let coordinator: DetailCoordinator = DetailCoordinator()
    
    @IBOutlet weak var search: UISearchBar!
    @IBOutlet weak var collection: UICollectionView!
    
    let spinner = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        search.delegate = self
        setCollection()
        bindOutlets()
    }
    
    func bindOutlets() {
        search.rx.text
            .orEmpty
            .debounce(.seconds(1), scheduler: MainScheduler.instance) //1초 기다림
            .distinctUntilChanged()
            .filter { !$0.isEmpty }
            .subscribe(onNext: { t in
                self.vm.getNewData(search: t.description){ success in
                    if success {
                        self.collection.scrollToItem(at: IndexPath(row: 0, section: 0), at: UICollectionView.ScrollPosition(), animated: true)
                        self.collection.reloadData()
                    } else {
                        AlertPresenter.instance.ErrorAlert(body: "서버에서 데이터를 받아오지 못하고 있습니다.")
                    }
                }
            }) .disposed(by: disposeBag)
    }
    
    func setCollection(){
        let cellSize = (view.frame.width - 30) / 3
        let flowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        flowLayout.itemSize = CGSize(width: cellSize, height: cellSize)
        collection.collectionViewLayout = flowLayout
        collection.register(LoadCell.self,
                            forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                            withReuseIdentifier: "LoadView")
        
        (collection.collectionViewLayout as? UICollectionViewFlowLayout)?.footerReferenceSize = CGSize(width: collection.bounds.width, height: 50)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.view.endEditing(true)
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cnt = indexPath.item
        coordinator.pushToDetail(self.navigationController, doc: vm.getData(cnt: cnt))
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if vm.countImages() == 0 && vm.getIsEnd() {
            AlertPresenter.instance.WarningAlert(title: "검색결과 없음", body: "검색결과가 없습니다.")
        }
        return vm.countImages()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imgCell", for: indexPath) as?
                MainCell else {
            return UICollectionViewCell()
        }
        
        cell.cellStyle()
        let data = vm.getData(cnt: indexPath.row)
        cell.image.image = nil
        cell.update(imgUrl: data.thumbnail_url!)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionFooter {
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "LoadView", for: indexPath)
            footer.addSubview(spinner)
            spinner.frame = CGRect(x: 0, y: 0, width: collectionView.bounds.width, height: 50)
            return footer
        }
        return UICollectionReusableView()
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if (scrollView.contentOffset.y + 1) >= (scrollView.contentSize.height - scrollView.frame.size.height) {
            spinner.startAnimating()
            vm.fetchData(){ success in
                self.spinner.stopAnimating()
                if !success{
                    AlertPresenter.instance.WarningAlert(title: "마지막 페이지", body: "더이상 데이터를 불러 올 수 없습니다.")
                    return
                }
                self.collection.reloadData()
            }
        }
    }
    
}
