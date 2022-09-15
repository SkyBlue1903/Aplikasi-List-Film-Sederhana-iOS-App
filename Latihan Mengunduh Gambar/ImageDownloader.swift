//
//  ImageDownloader.swift
//  Latihan Mengunduh Gambar
//
//  Created by Erlangga Anugrah Arifin on 14/09/22.
//

import UIKit

// ----------|  File Keempat: Untuk mengunduh gambar secara online |----------
class ImageDownloader: Operation {
    private let movie: Movie
    
    init(movie: Movie) {
        self.movie = movie
    }
    
    override func main() {
        if isCancelled {
            return
        }
        
        guard let imageData = try? Data(contentsOf: self.movie.poster) else {
            return
        }
        
        if isCancelled {
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

// MARK: Menangani request
class PendingOperations {
    lazy var downloadInProgress: [IndexPath: Operation] = [:]

    // maksimum 2 antrean sekaligus
    var downloadQueue: OperationQueue = {
        var queue = OperationQueue()
        queue.name = "com.anugrahangga.Latihan-Mengunduh-Gambar"
        queue.maxConcurrentOperationCount = 2
        return queue
    }()
}

