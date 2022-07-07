//
//  MovieDetailsPresenter.swift
//  Movierese
//
//  Created by mohamedSliem on 7/7/22.
//

import Foundation

class MovieDetailsPresenter {
    
    weak var view: MovieDetailsVC!
    var movie: Movie?
    
    init(view: MovieDetailsVC) {
        self.view = view
    }
    
    func viewDidLoad(){
        setMovieDetailsToView()
    }
    
    func setMovieObject(movie: Movie?){
        self.movie = movie
    }
    
    func setMovieDetailsToView(){
      
        setMovieName()
        setMoviePosterURL()
        setOverview()
        setAvgVote()
        setVotesNum()
        setReleaseDate()
        
    }
    
    func alertWithError(){
        
        view.showAlertWithOk(alertTitle: "Error",
                             message: "There is a problem with getting the movie 's information",
                             actionTitle: "Return")
    }
    
    func setMovieName(){
        
        guard let movieName = movie?.original_title else {
            alertWithError()
            return
        }
        
        view.setMovieName(name: movieName)

    }
    
    func setMoviePosterURL(){
        
        guard let urlString = movie?.poster_path else {
            alertWithError()
            return
        }
        
        let fullUrlString = "https://image.tmdb.org/t/p/w500/" + urlString
        
        guard let url = URL(string: fullUrlString) else {
            alertWithError()
            return
            
        }
        
        view.setMoviePoster(url: url)
       
    }
    
    func setReleaseDate(){
        guard let releaseDate = movie?.release_date else {
            alertWithError()
            return
        }
        
        view.setMovieRealseDate(date: releaseDate)
    }
    
    func setAvgVote(){
        
        guard let avgVote = movie?.vote_average else {
            alertWithError()
            return
        }
        view.setAvgVote(avgVote: avgVote)
    }
    
    func setVotesNum(){
        
        guard let voteNum = movie?.vote_count else {
            alertWithError()
            return
        }
        view.setVotesNumber(votesNumber: voteNum)
    }
    
    func setOverview(){
        guard let overview = movie?.overview else {
            alertWithError()
            return
        }
        view.setMovieOverview(overview: overview)
    }
    

}
