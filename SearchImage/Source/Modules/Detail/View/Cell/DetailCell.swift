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
            if let data = data {
                DispatchQueue.main.async {
                    self.transition(toImage: UIImage(data: data))
                }
            }
        }.resume()
    }
    
    func transition(toImage image: UIImage?) {
        UIView.transition(with: self, duration: 0.3,
                          options: [.transitionCrossDissolve],
                          animations: {
                            self.img.image = image
                          },
                          completion: nil)
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
