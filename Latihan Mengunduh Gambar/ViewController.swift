//
//  ViewController.swift
//  Latihan Mengunduh Gambar
//
//  Created by Erlangga Anugrah Arifin on 14/09/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var movieTableView: UITableView!
    
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
            cell.indicatorLoading.startAnimating()
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    
}
