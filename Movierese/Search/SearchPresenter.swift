//
//  SearchPresenter.swift
//  Movierese
//
//  Created by mohamedSliem on 7/7/22.
//

import Foundation

class SearchPresenter {
    
    weak var view: SearchVC!
    var searchResult = [Movie]()
    
    init(view: SearchVC) {
        self.view = view
        
    }
    
    func getResultsNumber() -> Int {
        return searchResult.count
    }
    
    func searchForQuery(query: String?){
        guard let query = query ,
              !query.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }

        APICaller.shared.search(with: query) { (result) in
            
            switch result {
            
            case .success(let results):
                self.searchResult = results
                DispatchQueue.main.async {
                    self.view.updateResultsCollection()
                }
                
            case .failure(let error):
                self.view.showAlertWithOk(alertTitle: "Error", message: error.localizedDescription, actionTitle: "OK")
            }
        }
    }
    
    func configureCell(cell: MoviewCollectionViewCell? , indexPath: Int){
        
        let imageUrlString = searchResult[indexPath].poster_path
        guard let imageURL = imageUrlString else { return }
        let urlString = "https://image.tmdb.org/t/p/w500/" + imageURL
        let url = URL(string: urlString)!
        cell?.configure(with: url)
        
    }
    
    func selectMovie(at indexPath: Int){
        view.moveToMovieDetailsVC(movie: searchResult[indexPath])
    }
    
}
