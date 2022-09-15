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
    private let pendingOperations = PendingOperations()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieTableView.dataSource = self
        movieTableView.register(UINib(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: "movieTableViewCell") // MARK: movieTableViewCell adalah identifier dari file XIB MovieTableViewCell
    }

}

// file MovieModel sudah otomatis terdeteksi apabila memasukannya kedalam UITableViewDataSource
// MARK: func tableView auto generate ketika movieTableView.dataSource = self diresolve oleh Xcode
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "movieTableViewCell", for: indexPath) as? MovieTableViewCell {
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
    
    fileprivate func startDownload(movie: Movie, indexPath: IndexPath) {
        guard pendingOperations.downloadInProgress[indexPath] == nil else {
            return
        }
        
        let downloader = ImageDownloader(movie: movie)
        downloader.completionBlock = {
            if downloader.isCancelled { return }
            
            DispatchQueue.main.async {
                self.pendingOperations.downloadInProgress.removeValue(forKey: indexPath)
                self.movieTableView.reloadRows(at: [indexPath], with: .automatic)
            }
        }
        
        pendingOperations.downloadInProgress[indexPath] = downloader
        pendingOperations.downloadQueue.addOperation(downloader)
    }
    
    fileprivate func startOperations(movie: Movie, indexPath: IndexPath) {
      if movie.state == .new {
        startDownload(movie: movie, indexPath: indexPath)
      }
    }

}


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
