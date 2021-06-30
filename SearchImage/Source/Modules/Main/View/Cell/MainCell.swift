//
//  ImageCell.swift
//  SearchImage
//
//  Created by 박지현 on 2021/06/24.
//

import UIKit

class MainCell: UICollectionViewCell {
    @IBOutlet var image: UIImageView!
    
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
    
    func cellStyle() {
        self.contentView.layer.cornerRadius = 10
        self.contentView.layer.borderWidth = 1.0
        self.contentView.layer.borderColor = UIColor.clear.cgColor
        self.contentView.layer.masksToBounds = true
        
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        self.layer.shadowRadius = 2.0
        self.layer.shadowOpacity = 1.0
        self.layer.masksToBounds = false
        self.layer.shadowPath = UIBezierPath(roundedRect:self.bounds, cornerRadius:self.contentView.layer.cornerRadius).cgPath
    }
}
