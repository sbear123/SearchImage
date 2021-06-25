//
//  DetailViewController.swift
//  SearchImage
//
//  Created by 박지현 on 2021/06/24.
//

import UIKit
import SnapKit

class DetailViewController: UIViewController {
    
    @IBOutlet var image: UIImageView!
    @IBOutlet var siteName: UILabel!
    @IBOutlet var dateTime: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let img = UIImage(named: "2")!
        //        let ratio = view.frame.width / img.size.width
        //        let newHeight = img.size.height * ratio
        //        image.frame.size = CGSize(width: view.frame.width, height: newHeight)
        //        image.image = img
        image.image = img
        siteName.text = "출처 : "
        dateTime.text = "작성 시간 : "
    }
    
}

class RDetailViewController: UITableViewController {
    
    @IBOutlet var table: UITableView!
    
    let vm: MainViewModel = MainViewModel()
    var imageH: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let ratio = view.frame.width / CGFloat(vm.list[0].width!)
        let newHeight = CGFloat(vm.list[0].height!) * ratio
        table.rowHeight = newHeight
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "imgCell", for: indexPath) as! ImageCell
            
            cell.update(imgUrl: vm.list[0].image_url!)
            return cell
        }
        else {
            table.rowHeight = 72
            let cell = tableView.dequeueReusableCell(withIdentifier: "labelCell", for: indexPath) as! LabelCell
            
            cell.update(site: vm.list[0].display_sitename, date: vm.list[0].datetime)
            return cell
        }
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
        let ratio = view.frame.width / CGFloat(vm.list[section].width!)
        let newHeight = CGFloat(vm.list[section].height!) * ratio
        print(Int(newHeight))
        return newHeight
    }
    
}
