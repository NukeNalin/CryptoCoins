//
//  LocalFileManager.swift
//  CryptoCoins
//
//  Created by Nalin Porwal on 10/06/21.
//

import Foundation
import SwiftUI

class LocalFileManager {
    
    static let shared = LocalFileManager()
    private init() {}
    
    func savedImage(image: UIImage, imageName: String, folderName: String) {
        // createFolder
        createFolderIfNeeded(folderName: folderName)
        
        // get path for image
        guard let data = image.pngData(), let url = getURLForImage(imageName: imageName, folderName: folderName) else { return }
        
        // save Image to Folder path
        
        do {
            try data.write(to: url)
        } catch {
            print("Error saving image. ImageName \(imageName) \(error.localizedDescription)")
        }
    }
    
    func getImage(imageName: String, folderName: String) -> UIImage? {
        guard let url = getURLForImage(imageName: imageName, folderName: folderName), FileManager.default.fileExists(atPath: url.path) else { return nil }
        return UIImage(contentsOfFile: url.path)
    }
    
    private func createFolderIfNeeded(folderName: String) {
        guard let url = getURLFolder(folderName: folderName) else { return }
        if !FileManager.default.fileExists(atPath: url.path) {
            do {
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
            } catch {
                print("Error creating directory \(error)")
            }
        }
    }
    
    private func getURLFolder(folderName: String) -> URL? {
        guard let url = FileManager.default.urls(for: .cachesDirectory, in: .allDomainsMask).first else { return nil }
        return url.appendingPathComponent(folderName)
    }
    
    private func getURLForImage(imageName: String, folderName: String) -> URL? {
        guard let folderURL = getURLFolder(folderName: folderName) else { return nil }
        return folderURL.appendingPathComponent(imageName + ".png")
    }
}
