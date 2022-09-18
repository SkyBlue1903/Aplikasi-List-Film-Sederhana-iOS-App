//
//  MovieModel.swift
//  Latihan Mengunduh Gambar
//
//  Created by Erlangga Anugrah Arifin on 14/09/22.
//

import Foundation
import UIKit

//----------| File Kedua |----------

// MARK: sebagai data model untuk menampung informasi movie
// Konstanta title dan poster akan ditetapkan saat model Movie diinisialisasi, sedangkan variabel image secara default berupa variabel opsional dan untuk state memiliki nilai default berupa .new
class Movie {
  let id: Int
  let overview: String

  let title: String
  let poster: URL

  var image: UIImage?
  var state: DownloadState = .new

  init(id: Int, title: String, overview: String, poster: URL) {
    self.id = id
    self.title = title
    self.overview = overview
    self.poster = poster
  }
}


// MARK: Beberapa state untuk proses unduh gambar dalam aplikasi
enum DownloadState {
    case new, downloaded, failed
//new: merupakan state default dari movie model;
//downloaded: merupakan state ketika proses mengunduh sedang dilakukan; dan
//failed: merupakan state yang menunjukkan bahwa proses mengunduh gagal dilakukan.
}

