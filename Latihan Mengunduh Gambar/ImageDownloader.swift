//
//  ImageDownloader.swift
//  Latihan Mengunduh Gambar
//
//  Created by Erlangga Anugrah Arifin on 14/09/22.
//

import Foundation
import UIKit

// ----------|  File Keempat |----------
class ImageDownloader: Operation {
    private let movie: Movie
    
    init(movie: Movie) {
        self.movie = movie
    }
    
    override func main() {
//        if isCancelled {
//            return
//        }
        
        guard let imageData = try? Data(contentsOf: self.movie.poster) else {
            return
        }
        
        if !imageData.isEmpty {
            self.movie.image = UIImage(data: imageData)
            self.movie.state = .downloaded
        } else {
            self.movie.image = nil
            self.movie.state = .failed
        }
    }
}
