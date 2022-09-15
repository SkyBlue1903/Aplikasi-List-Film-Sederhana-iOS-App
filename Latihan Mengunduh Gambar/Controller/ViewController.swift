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
        // Memastikan bahwa indeks TableView dalam pendingOperation memiliki keadaan nil. Ketika proses dalam indeks ternyata masih berlangsung, kode tidak akan dieksekusi
        guard pendingOperations.downloadInProgress[indexPath] == nil else {
            return
        }
        
        // Setelah memastikan indeks dalam keadaan nil, kode memanggil instance operation bernama downloader
        let downloader = ImageDownloader(movie: movie)
        downloader.completionBlock = {
            if downloader.isCancelled { return }
            
            DispatchQueue.main.async {
                self.pendingOperations.downloadInProgress.removeValue(forKey: indexPath)
                
                // Item TableView dimuat ulang sesaat setelah proses unduh berhasil dilakukan
                self.movieTableView.reloadRows(at: [indexPath], with: .automatic)
            }
        }
        
        // Completion Block bisa disebut juga dengan callback untuk menghubungkan satu thread ke thread lainnya (thread dependency). Completion Block sendiri sebenarnya adalah sebuah Closure, yang artinya Anda harus mengirimkan sebuah function sebagai parameter. Dalam kasus ini, yakni saat operation selesai, kode menghapus operation sesuai dengan indeksnya dan memperbarui row/baris pada indeks tersebut
        
//        Dengan begitu, operation downloader bisa dimasukkan dalam antrean
        pendingOperations.downloadInProgress[indexPath] = downloader
        pendingOperations.downloadQueue.addOperation(downloader)
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
