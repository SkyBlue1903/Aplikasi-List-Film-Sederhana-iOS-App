//
//  ViewController.swift
//  Latihan Mengunduh Gambar
//
//  Created by Erlangga Anugrah Arifin on 14/09/22.
//

import UIKit

// ----------|  File Ketiga: Edit semua di controller utama |----------

class ViewController: UIViewController {

    @IBOutlet weak var movieTableView: UITableView!
    
    // digunakan sebagai wadah dari antrean operation
    private let pendingOperations = PendingOperations()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieTableView.dataSource = self
        movieTableView.register(UINib(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: "movieTableViewCell") // MARK: movieTableViewCell adalah identifier dari file XIB MovieTableViewCell
    }

}


// MARK: func tableView auto generate ketika movieTableView.dataSource = self diresolve oleh Xcode
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "movieTableViewCell", for: indexPath) as? MovieTableViewCell {
            // file MovieModel sudah otomatis terdeteksi apabila memasukannya kedalam UITableViewDataSource
            let movie = movies[indexPath.row]
            cell.movieTitle.text = movie.title
            cell.movieImage.image = movie.image
//            cell.indicatorLoading.startAnimating()
            
            if movie.state == .new {
              cell.indicatorLoading.isHidden = false
              cell.indicatorLoading.startAnimating()
              startOperations(movie: movie, indexPath: indexPath)
            } else {
              cell.indicatorLoading.stopAnimating()
              cell.indicatorLoading.isHidden = true
            }
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    
    //  Jika state dalam movie nilainya .new, kode memanggil fungsi startOperations
    fileprivate func startOperations(movie: Movie, indexPath: IndexPath) {
      if movie.state == .new {
        startDownload(movie: movie, indexPath: indexPath)
      }
    }
    
    
    // Ketika kondisi terpenuhi, kode melakukan pemanggilan function startDownload
    fileprivate func startDownload(movie: Movie, indexPath: IndexPath) {
        let imageDownloader = ImageDownloader()
        if movie.state == .new {
            // Task digunakan untuk menjalankan proses asynchronous dalam function synchronous. Ketika ingin menjalankan proses asynchronous secara paksa, terjadilah error
            Task {
                // Gunakan try-catch ketika memanggil imageDownloader karena memicu kesalahan. Ketika proses mengunduh gagal, kode masuk di bagian blok catch
                do {
                    let image = try await imageDownloader.downloadImage(url: movie.poster)
                    movie.state = .downloaded
                    movie.image = image
                    self.movieTableView.reloadRows(at: [indexPath], with: .automatic)
                } catch {
                    movie.state = .failed
                    movie.image = nil
                }
            }
        }
    }

}


// MARK: menghentikan proses atau suspend saat pengguna melakukan scrolling dalam TableView
extension ViewController: UIScrollViewDelegate {
    // Ketika drag di UITableView tidak lag dengan tunda pengunduhan gambar
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        toggleSuspendOperations(isSuspended: true)
    }
    
    // Ketika scroll user berhenti, lanjutkan pengunduhan
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        toggleSuspendOperations(isSuspended: false)
    }
    
    fileprivate func toggleSuspendOperations(isSuspended: Bool) {
        pendingOperations.downloadQueue.isSuspended = isSuspended
    }
    
}
