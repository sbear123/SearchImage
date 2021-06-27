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
                            self.image.image = image
                          },
                          completion: nil)
    }
}
