//
//  CacheImageManager.swift
//  testBottleRocket
//
//  Created by roreyesl on 08/09/21.
//

import UIKit.UIImage

public class ImageCacheManager {
    // MARK: - Properties
    
    static let imageCache = NSCache<AnyObject, AnyObject>()
    typealias CachedImages = (image: UIImage?, name: String)
    
    // MARK: - Functions
    
    static public func getImage(name: String, directory: FileManager.SearchPathDirectory = .cachesDirectory) -> UIImage?{
        if let image = imageCache.object(forKey: name as AnyObject) as? UIImage {
            return image
        }
        if let image = imageFromCache(withName: name, directory: directory){
            DispatchQueue.main.async { imageCache.setObject(image, forKey: name as AnyObject) }
            return image
        }
        return nil
    }
    
    static public func save(withName name: String, image: UIImage, directory: FileManager.SearchPathDirectory = .cachesDirectory){
        DispatchQueue.main.async { imageCache.setObject(image, forKey: name as AnyObject) }
        try? saveToDisk(withName: name, image: image, directory: directory)
    }
    
    static public func imageFromCache(withName name: String, directory: FileManager.SearchPathDirectory = .cachesDirectory) -> UIImage?{
        let folderURLs = FileManager.default.urls(
            for: directory,
            in: .userDomainMask
        )
        let fileURL = folderURLs[0].appendingPathComponent(name)
        if FileManager.default.fileExists(atPath: fileURL.path){
            guard let imageData = try? Data(contentsOf: fileURL) else {return nil}
            return UIImage(data: imageData)
        }else{
            return nil
        }
    }
    
    static public func saveToDisk(withName name: String, image: UIImage, directory: FileManager.SearchPathDirectory = .cachesDirectory) throws {
        let folderURLs = FileManager.default.urls(
            for: directory,
            in: .userDomainMask
        )
        let fileURL = folderURLs[0].appendingPathComponent(name)
        if let imageData = image.pngData(){
            try imageData.write(to: fileURL)
        }else{
            guard let imageData = image.jpegData(compressionQuality: 0.5) else {
                return
            }
            try imageData.write(to: fileURL)
        }
    }
    
    static public func cleanCache(){
        let folderURLs = FileManager.default.urls(
            for: .cachesDirectory,
            in: .userDomainMask
        )
        for folder in folderURLs{
            do {
                let directoryContents = try FileManager.default.contentsOfDirectory( at: folder, includingPropertiesForKeys: nil, options: [])
                for file in directoryContents {
                    try FileManager.default.removeItem(at: file)
                }
            } catch { }
        }
    }
    
    static public func removeFromCache(name: String, directory: FileManager.SearchPathDirectory = .cachesDirectory){
        imageCache.removeObject(forKey: name as AnyObject)
        let folderURLs = FileManager.default.urls(
            for: directory,
            in: .userDomainMask
        )
        let nameResouce = name
        for folder in folderURLs{
            do {
                let directoryContents = try FileManager.default.contentsOfDirectory( at: folder, includingPropertiesForKeys: nil, options: [])
                for file in directoryContents {
                    if file.pathComponents.last == nameResouce{
                        try FileManager.default.removeItem(at: file)
                    }
                }
            } catch { }
        }
    }
    
    static public func cleanCacheExcept(names: [String]){
        let cachedImages: [CachedImages] = names.compactMap { (getImage(name: $0), $0 ) }
        cleanCache()
        for element in cachedImages{
            if let image = element.image{
                try? saveToDisk(withName: element.name, image: image)
            }
        }
    }
}
