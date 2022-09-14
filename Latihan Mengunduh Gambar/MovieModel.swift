//
//  MovieModel.swift
//  Latihan Mengunduh Gambar
//
//  Created by Erlangga Anugrah Arifin on 14/09/22.
//

import Foundation

class Movie {
    let title: String
    let poster: URL
    
    init(judul: String, gambar: URL) {
        self.title = judul
        self.poster = gambar
    }
}

let movies = [
    Movie(
        judul: "Thor: Love and Thunder",
        gambar: URL(string: "https://image.tmdb.org/t/p/w500/pIkRyD18kl4FhoCNQuWxWu5cBLM.jpg")!
      ), Movie(
        judul: "Minions: The Rise of Gru",
        gambar: URL(string: "https://image.tmdb.org/t/p/w500/wKiOkZTN9lUUUNZLmtnwubZYONg.jpg")!
      ), Movie(
        judul: "Jurassic World Dominion",
        gambar: URL(string: "https://image.tmdb.org/t/p/w500/kAVRgw7GgK1CfYEJq8ME6EvRIgU.jpg")!
      ), Movie(
        judul: "Top Gun: Maverick",
        gambar: URL(string: "https://image.tmdb.org/t/p/w500/62HCnUTziyWcpDaBO2i1DX17ljH.jpg")!
      ), Movie(
        judul: "The Gray Man",
        gambar: URL(string: "https://image.tmdb.org/t/p/w500/8cXbitsS6dWQ5gfMTZdorpAAzEH.jpg")!
      ), Movie(
        judul: "The Black Phone",
        gambar: URL(string: "https://image.tmdb.org/t/p/w500/p9ZUzCyy9wRTDuuQexkQ78R2BgF.jpg")!
      ), Movie(
        judul: "Lightyear",
        gambar: URL(string: "https://image.tmdb.org/t/p/w500/ox4goZd956BxqJH6iLwhWPL9ct4.jpg")!
      ), Movie(
        judul: "Doctor Strange in the Multiverse of Madness",
        gambar: URL(string: "https://image.tmdb.org/t/p/w500/9Gtg2DzBhmYamXBS1hKAhiwbBKS.jpg")!
      ), Movie(
        judul: "Indemnity",
        gambar: URL(string: "https://image.tmdb.org/t/p/w500/tVbO8EAbegVtVkrl8wNhzoxS84N.jpg")!
      ), Movie(
        judul: "Borrego",
        gambar: URL(string: "https://image.tmdb.org/t/p/w500/kPzQtr5LTheO0mBodIeAXHgthYX.jpg")!
      )
]
