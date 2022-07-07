//
//  MovieDetailsVC.swift
//  Movierese
//
//  Created by mohamedSliem on 7/7/22.
//

import UIKit
import SDWebImage


class MovieDetailsVC: UIViewController {
    
    
    var movie: Movie?
    var presenter: MovieDetailsPresenter!
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var overviewTextView: UITextView!
    @IBOutlet weak var realseDateLabel: UILabel!
    @IBOutlet weak var imdbImageView: UIImageView!
    @IBOutlet weak var averageVoteLabel: UILabel!
    @IBOutlet weak var numberOfVotes: UILabel!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    
    
    //MARK:- Life cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isHidden = true

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter = MovieDetailsPresenter(view: self)
        presenter.setMovieObject(movie: movie)
        presenter.viewDidLoad()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(true)
        self.navigationController?.navigationBar.isHidden = false
  
    }
    
//MARK:- handling view
    func setupView(){
        // Back button
        backButton.clipsToBounds = true
        backButton.layer.cornerRadius = 15
        
        // overview textView
        overviewTextView.isEditable = false
        overviewTextView.isSelectable = false
        overviewTextView.isScrollEnabled = false
        
        // imdb logo
        imdbImageView.clipsToBounds = true
        imdbImageView.layer.cornerRadius = 10
        
    }
    
    @IBAction func didTapBackButton(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    //MARK:- Setting data functions
    
    func setMoviePoster(url: URL){
        posterImageView.sd_setImage(with: url, completed: nil)
    }
    
    func setMovieName(name: String){
        movieTitleLabel.text = name
    }
    
    func setMovieRealseDate(date: String){
        realseDateLabel.text = date
    }
    
    func setMovieOverview(overview: String){
        overviewTextView.text = overview
    }
    
    func setAvgVote(avgVote: Double){
        averageVoteLabel.text = String(avgVote) + " / 10"
    }
    
    func setVotesNumber(votesNumber: Int){
        numberOfVotes.text = String(votesNumber) + " votes"
    }
    
}
