//
//  SearchVC.swift
//  Movierese
//
//  Created by mohamedSliem on 7/7/22.
//

import UIKit

class SearchVC: UIViewController, UISearchResultsUpdating {
    
    
    var presenter: SearchPresenter!
    
    //MARK:- view variables
    
    private let searchController : UISearchController = {
        let searchVC = UISearchController()
        searchVC.searchBar.placeholder = "Search for movies"
        searchVC.searchBar.barStyle = .black
        searchVC.definesPresentationContext = true
        
        return searchVC
    }()
    
    
    let collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.register(MoviewCollectionViewCell.self, forCellWithReuseIdentifier: MoviewCollectionViewCell.identifier)
        return collectionView
    }()
    
    //MARK:- life cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.largeTitleTextAttributes = attributes
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = SearchPresenter(view: self)
        configureSearchController()
        configureCollectionView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    
    //MARK:- handling view
    private func configureCollectionView(){
        self.view.addSubview(collectionView)
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func configureSearchController(){
        self.navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
        let query = searchController.searchBar.text
        presenter.searchForQuery(query: query)
        
    }
    
    func updateResultsCollection(){
        collectionView.reloadData()
    }
    
    func moveToMovieDetailsVC(movie: Movie){
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let vc = storyboard.instantiateViewController(identifier: "MovieDetailsVC") as! MovieDetailsVC
        
        vc.movie = movie
        
        navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK:- collection view delegates
extension SearchVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.getResultsNumber()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MoviewCollectionViewCell.identifier,
            for: indexPath
        ) as! MoviewCollectionViewCell
        
        
        presenter.configureCell(cell: cell, indexPath: indexPath.row)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let margin: CGFloat = 35
        let size: CGFloat = (collectionView.frame.size.width - margin )/3
        
        return CGSize(width: size , height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(
            top: 5,
            left: 10,
            bottom: 5,
            right: 10
        )
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath)
        
        UIView.animate(withDuration: 0.4,
                       animations: {
                        cell?.alpha = 0.5
                       }) { (completed) in
            UIView.animate(withDuration: 0.4,
                           animations: {
                            cell?.alpha = 1
                            self.presenter.selectMovie(at: indexPath.row)
                           })
        }
        
        
    }
}
