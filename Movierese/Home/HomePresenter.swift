//
//  HomePresenter.swift
//  Movierese
//
//  Created by mohamedSliem on 7/7/22.
//

import Foundation

class HomePresenter {
    
    weak var view: HomeViewController!
    var movies = [Movie]()
    
    init(view: HomeViewController) {
        self.view = view
    }
    
    func viewDidLoad(){
        view.showLoader()
        fetchData()
    
    }
    
    private func fetchData()
    {
        movies.removeAll()
        let group = DispatchGroup()
        group.enter()
        group.enter()
        
        APICaller.shared.getPopular(completion: { (result) in
            defer {
                group.leave()
            }
            switch result{
            case.success(let model) :
                self.movies.append(contentsOf: model)
                
            case .failure(let error) :
                print(error.localizedDescription)
            }
        }
        )
        
        
        
        APICaller.shared.getTrendingMovies(completion: { (result) in
            defer {
                group.leave()
            }
            switch result{
            case.success(let model) :
                self.movies.append(contentsOf: model)
                
                
            case .failure(let error) :
                print(error.localizedDescription)
            }
        }
        )
        
        group.notify(queue: .main){
            self.movies = self.movies.shuffled()
            DispatchQueue.main.async {
                self.view.reloadData()
                self.view.removeLoader()
            }
            
        }
    }
    
    
    func numberOfMovies() -> Int {
        return movies.count
    }
    
    func configureCell(cell: MoviewCollectionViewCell? , indexPath: Int){
        
        let imageUrlString = movies[indexPath].poster_path
        guard let imageURL = imageUrlString else { return }
        let urlString = "https://image.tmdb.org/t/p/w500/" + imageURL
        let url = URL(string: urlString)!
        cell?.configure(with: url)
        
    }
    
    func selectMovie(at indexPath: Int){
        
        view.moveToMovieDetailsVC(movie: movies[indexPath])
        
    }
    
}
