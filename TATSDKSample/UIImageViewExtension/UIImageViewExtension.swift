//
//  UIImageViewExtension.swift
//  TATSDKSample
//
//  Created by Rattanatut Pluwungkan on 16/5/2562 BE.
//  Copyright © 2562 Koson Tuangtee. All rights reserved.
//

import UIKit

extension UIImageView {
    func downloaded(from url: URL?, placeholderImage: UIImage?) {
        guard let url = url else { setImage(image: placeholderImage); return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            self.setImage(image: image)
            }.resume()
    }
    
    func downloaded(from link: String, placeholderImage: UIImage?) {
        guard let url = URL(string: link) else { setImage(image: placeholderImage); return }
        downloaded(from: url, placeholderImage: placeholderImage)
    }
    
    private func setImage(image: UIImage?) {
        DispatchQueue.main.async() {
            self.image = image
        }
    }
}
