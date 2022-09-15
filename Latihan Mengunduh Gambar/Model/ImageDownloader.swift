//
//  ImageDownloader.swift
//  Latihan Mengunduh Gambar
//
//  Created by Erlangga Anugrah Arifin on 14/09/22.
//

import UIKit

// ----------|  File Keempat: Untuk mengunduh gambar secara online |----------
// MARK: mengunduh gambar dari alamat URL dan memperbarui setelah data berhasil diunduh
class ImageDownloader: Operation {
    private let movie: Movie
    
    init(movie: Movie) {
        self.movie = movie
    }
    
    override func main() {
        if isCancelled {
            return
        }
        
        // Untuk mengunduh gambar
        guard let imageData = try? Data(contentsOf: self.movie.poster) else {
            return
        }
        
        if isCancelled {
            return
        }
        
        // Ketika aplikasi berhasil mengunduh, ImageDownloader menetapkan nilai image dan mengubah nilai state menjadi .downloaded. Ketika aplikasi tidak dapat memuat gambar, nilai image menjadi nil dan nilai state akan berubah menjadi .failed
        if !imageData.isEmpty {
            // Ubah data menjadi gambar dengan bantuan UIImage dan menetapkannya dalam properti movie
            self.movie.image = UIImage(data: imageData)
            self.movie.state = .downloaded
        } else {
            self.movie.image = nil
            self.movie.state = .failed
        }
    }
}

// MARK: Menangani request dan mengantrekan proses pengunduhan gambar
class PendingOperations {
    lazy var downloadInProgress: [IndexPath: Operation] = [:]

    // Pending Operation hanya mengizinkan antrean sebanyak 2. Jika lebih dari itu, akan mengantre untuk diproses
    var downloadQueue: OperationQueue = {
        var queue = OperationQueue()
        queue.name = "com.anugrahangga.Latihan-Mengunduh-Gambar"
        queue.maxConcurrentOperationCount = 2
        return queue
    }()
}

