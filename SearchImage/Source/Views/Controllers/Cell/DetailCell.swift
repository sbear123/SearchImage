//
//  DetailCell.swift
//  SearchImage
//
//  Created by 박지현 on 2021/06/25.
//

import UIKit

class ImageCell: UITableViewCell {
    @IBOutlet weak var img: UIImageView!
    
    func update(imgUrl: String) {
        URLSession.shared.dataTask(with: URL(string: imgUrl)!) { (data, response, err) in
            DispatchQueue.main.async {
                if let data = data {
                    self.img.image = UIImage(data: data)
                }
            }
        }.resume()
    }
}

class LabelCell: UITableViewCell {
    @IBOutlet weak var siteName: UILabel!
    @IBOutlet weak var date: UILabel!
    
    func update(site: String?, date: String?){
        self.siteName.text = "출처 : " + (site ?? "")
        self.date.text = "작성 시간 : " + (date ?? "")
    }
}
