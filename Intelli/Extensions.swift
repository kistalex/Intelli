//
//
// Intelli
// Extensions.swift
// 
// Created by Alexander Kist on 06.08.2023.
//


import UIKit

extension UIImageView {
    func loadFrom(URLAddress: String) {
        guard let url = URL(string: URLAddress) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            if let error = error {
                print("Error loading image: \(error.localizedDescription)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, 200...299 ~= httpResponse.statusCode else {
                print("Invalid response")
                return
            }
            
            guard let imageData = data, let loadedImage = UIImage(data: imageData) else {
                print("Invalid image data")
                return
            }
            
            DispatchQueue.main.async {
                self?.image = loadedImage
            }
        }
        
        task.resume()
    }
}
