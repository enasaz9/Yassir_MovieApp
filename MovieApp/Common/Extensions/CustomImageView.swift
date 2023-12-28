//
//  CustomImageView.swift
//  MovieApp
//
//  Created by Enas A. Zaki on 26/12/2023.
//

import UIKit
let imageCache = NSCache<AnyObject, AnyObject>()

class CustomImageView: UIImageView {
    var task: URLSessionDataTask!
    let spinner = UIActivityIndicatorView(style: .medium)
    
    func loadImage (from url: URL) {
        // set image to nil not to show previous images (refresh image value)
        image = nil
        
        if let task = task {
            task.cancel()
        }
        
        // get image from cashe if previously stored
        if let imageFromCache = imageCache.object(forKey: url.absoluteString as AnyObject) as? UIImage {
            self.image = imageFromCache
            return
        }
        
        // show spinner while loading the image
        addSpinner()
        task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data,
                  let newImage = UIImage(data: data)
            else {
                print("couldn't load image from url: \(url)")
                return
            }
            
            // save image in cashe with its url as a key
            imageCache.setObject(newImage, forKey: url.absoluteString as AnyObject)
            DispatchQueue.main.async {
                self.image = newImage
                
                // remove spinner after setting the image
                self.removeSpinner()
            }
        }
        task.resume()
    }
    
    func addSpinner() {
        addSubview(spinner)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        spinner.centerXAnchor.constraint(equalTo: centerXAnchor).isActive =
        true
        spinner.startAnimating ()
    }
    
    func removeSpinner() {
        spinner.removeFromSuperview ()
    }
}
