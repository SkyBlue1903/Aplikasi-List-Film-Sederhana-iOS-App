//
//  ImageDownloader.swift
//  Latihan Mengunduh Gambar
//
//  Created by Erlangga Anugrah Arifin on 14/09/22.
//

import UIKit

// ----------|  File yang diedit: Mengubah kode GCD |----------
// MARK: mengunduh gambar dari alamat URL dan memperbarui setelah data berhasil diunduh
class ImageDownloader {
    // Ketika ingin mengubah sebuah function biasa menjadi asynchronous function dibutuhkan kata kunci async. Selain itu bisa menambahkan kata kunci throws jika kode memicu error
    func downloadImage(url: URL) async throws -> UIImage {
        
        // Gunakan Async-let untuk menandai sebuah variabel yang awalnya berjalan secara synchronous menjadi asynchronous. Mengapa perlu melakukan ini? Sebenarnya boleh-boleh saja jika ingin melakukan proses mengunduh gambar atau proses yang berat di main thread. Namun, hal tersebut dapat menyebabkan masalah jika proses yang dilakukan biasanya membutuhkan waktu lebih lama. Contohnya adalah tampilan pengguna menjadi lag, stuck, bahkan bisa saja menyebabkan error. Oleh karena itu, kita dapat membuat agar variabel tersebut berjalan secara asynchronous
        async let imageData: Data = try Data(contentsOf: url)
        // Oleh karena proses sebelumnya memicu kesalahan, perlu kata kunci try. Kemudian await digunakan untuk menunggu proses imageData mendapatkan data yang dibutuhkan.
        return UIImage(data: try await imageData)!
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

