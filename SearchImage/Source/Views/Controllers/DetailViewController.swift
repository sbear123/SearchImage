//
//  DetailViewController.swift
//  SearchImage
//
//  Created by 박지현 on 2021/06/24.
//

import UIKit

class DetailViewController: UITableViewController {
    
    @IBOutlet var table: UITableView!
    
    let vm: MainViewModel = MainViewModel.shared
    var productId: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let ratio = view.frame.width / CGFloat(vm.getData(cnt: productId).width!)
        let newHeight = CGFloat(vm.getData(cnt: productId).height!) * ratio
        table.rowHeight = newHeight
    }
}

extension DetailViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "imgCell", for: indexPath) as! ImageCell
            
            cell.update(imgUrl: vm.getData(cnt: productId).image_url!)
            return cell
        }
        else {
            table.rowHeight = 72
            let cell = tableView.dequeueReusableCell(withIdentifier: "labelCell", for: indexPath) as! LabelCell
            
            let data = vm.getData(cnt: productId)
            cell.update(site: data.display_sitename, date: data.datetime)
            
            return cell
        }
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
        let ratio = view.frame.width / CGFloat(vm.getData(cnt: productId).width!)
        let newHeight = CGFloat(vm.getData(cnt: productId).height!) * ratio
        return newHeight
    }
}
