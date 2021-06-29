//
//  DetailViewController.swift
//  SearchImage
//
//  Created by 박지현 on 2021/06/24.
//

import UIKit

class DetailViewController: UITableViewController {
    
    @IBOutlet var table: UITableView!
    
    let vm: DetailViewModel = DetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.rowHeight = vm.getNewHeight(view.frame.width)
    }
}

extension DetailViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "imgCell", for: indexPath) as! ImageCell
            
            cell.selectionStyle = .none
            cell.update(imgUrl: vm.document!.image_url!)
            return cell
        }
        else {
            table.rowHeight = 72
            let cell = tableView.dequeueReusableCell(withIdentifier: "labelCell", for: indexPath) as! LabelCell
            
            cell.selectionStyle = .none
            let data = vm.document!
            let date = vm.stringConvertToDateTime()
            cell.update(site: data.display_sitename, date: date)
            
            return cell
        }
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
}
