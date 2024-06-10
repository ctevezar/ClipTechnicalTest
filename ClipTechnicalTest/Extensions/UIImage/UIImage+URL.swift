//
//  UIImage+URL.swift
//  ClipTechnicalTest
//
//  Created by Carlos Tevez on 06/06/2024.
//

import UIKit

extension UIImageView {
    func load(url: URL, indexPath: IndexPath) {
        if let cachedImage = ImageCache.shared.object(forKey: url.absoluteString as NSString) {
            self.image = cachedImage
        } else {
            ImageDownloader.download(from: url) { [weak self] image in
                DispatchQueue.main.async {
                    self?.image = image
                }
            }
        }
    }
}


// TODO: Move
class ImageCache {
    static let shared = NSCache<NSString, UIImage>()
    
    private init() { }
}


class ImageDownloader {
    static func download(from url: URL, success: @escaping (UIImage?) -> Void) {
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    ImageCache.shared.setObject(image, forKey: url.absoluteString as NSString)
                    
                    success(image)
                }
            }
        }
    }

}
