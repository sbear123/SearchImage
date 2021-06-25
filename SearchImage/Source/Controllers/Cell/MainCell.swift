//
//  ImageCell.swift
//  SearchImage
//
//  Created by 박지현 on 2021/06/24.
//

import UIKit

class MainCell: UICollectionViewCell {
    @IBOutlet weak var image: UIImageView!
    
    func update(imgUrl: String) {
        URLSession.shared.dataTask(with: URL(string: imgUrl)!) { (data, response, err) in
            DispatchQueue.main.async {
                if let data = data {
                    self.image.image = UIImage(data: data)
                }
            }
        }.resume()
    }
}
