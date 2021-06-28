//
//  ViewController.swift
//  SearchImage
//
//  Created by 박지현 on 2021/06/26.
//

import UIKit
import RxSwift

class MainViewController: UIViewController, UISearchBarDelegate {
    let vm: MainViewModel = MainViewModel.shared
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var search: UISearchBar!
    @IBOutlet weak var collection: UICollectionView!
    
    let spinner = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setSearch()
        setCollection()
    }
    
    func setSearch() {
        search.delegate = self
        search.rx.text.orEmpty
            .debounce(RxTimeInterval.seconds(1),
                      scheduler: MainScheduler.instance) //1초 기다림
            .distinctUntilChanged()
            .subscribe(onNext: { t in
                self.vm.getNewData(search: t.description){ success in
                    if success {
                        self.collection.reloadData()
                        self.collection.scrollToItem(at: IndexPath(row: 0, section: 0), at: UICollectionView.ScrollPosition(), animated: true)
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
                            withReuseIdentifier: "MyFooterView")
        
        (collection.collectionViewLayout as? UICollectionViewFlowLayout)?.footerReferenceSize = CGSize(width: collection.bounds.width, height: 50)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.view.endEditing(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            let vc = segue.destination as? DetailViewController
            if let data = sender as? Document {
                vc!.vm.document = data
            }
        }
    }
    
    func makeAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        var okAction : UIAlertAction
        
        okAction = UIAlertAction(title: "Yes", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: false, completion: nil)
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cnt = indexPath.item
        self.performSegue(withIdentifier: "showDetail", sender: vm.getData(cnt: cnt))
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if vm.countImages() == 0 && vm.getIsEnd() {
            makeAlert(title: "검색결과 없음", message: "검색결과가 없습니다.")
        }
        return vm.countImages()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imgCell", for: indexPath) as?
                MainCell else {
            return UICollectionViewCell()
        }
        
        let data = vm.getData(cnt: indexPath.row)
        cell.image.image = nil
        cell.update(imgUrl: data.thumbnail_url!)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionFooter {
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "MyFooterView", for: indexPath)
            footer.addSubview(spinner)
            spinner.frame = CGRect(x: 0, y: 0, width: collectionView.bounds.width, height: 50)
            return footer
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        if indexPath.item == vm.countImages() - 1 {
            spinner.startAnimating()
            vm.fetchData(){ success in
                self.spinner.stopAnimating()
                if !success{
                    self.makeAlert(title: "마지막 페이지", message: "더이상 데이터를 불러 올 수 없습니다.")
                    return
                }
                self.collection.reloadData()
            }
        }
    }
    
}
