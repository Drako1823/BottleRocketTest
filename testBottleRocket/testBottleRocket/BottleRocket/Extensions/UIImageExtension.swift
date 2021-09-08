//
//  UIImageExtension.swift
//  testBottleRocket
//
//  Created by roreyesl on 08/09/21.
//

import UIKit

extension UIImage {
    
    //MARK: - Functions
    
    static func cacheImage(from url: URL, name: String, replaceResource: Bool = false, directory: FileManager.SearchPathDirectory = .cachesDirectory, completion: ((UIImage?) -> ())? = nil) {
        
        if replaceResource{
            ImageCacheManager.removeFromCache(name: name, directory: directory)
        }
        
        if let image = ImageCacheManager.getImage(name: name, directory: directory){
            guard let completion = completion else { return }
            completion(image)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                  let data = data, error == nil,
                  let image = UIImage(data: data)
            else {
                guard let completion = completion else { return }
                return  completion(nil)
            }
            ImageCacheManager.save(withName: name, image: image, directory: directory)
            guard let completion = completion else { return }
            completion(image)
        }.resume()
    }
    
    func resized(to newSize: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0)
        draw(in: CGRect(x     : 0,
                        y     : 0,
                        width : newSize.width,
                        height: newSize.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
}
