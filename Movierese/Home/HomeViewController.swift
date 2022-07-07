//
//  HomeViewController.swift
//  Movierese
//
//  Created by mohamedSliem on 7/7/22.
//

import UIKit


class HomeViewController: UIViewController {
    
    var presenter: HomePresenter!
    
    // MARK:- View Variables
    let collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.register(MoviewCollectionViewCell.self, forCellWithReuseIdentifier: MoviewCollectionViewCell.identifier)
        return collectionView
    }()

    let refreshControl = UIRefreshControl()

    //MARK:- Life cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.largeTitleTextAttributes = attributes
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        configureCollectionView()
        presenter = HomePresenter(view: self)
        presenter.viewDidLoad()
        
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
        
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        collectionView.addSubview(refreshControl)
    }
    
    func reloadData(){
        collectionView.reloadData()
    }
    
    func moveToMovieDetailsVC(movie: Movie){
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let vc = storyboard.instantiateViewController(identifier: "MovieDetailsVC") as! MovieDetailsVC
        
        vc.movie = movie
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func refresh(_ sender: AnyObject) {
        
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { (timer) in
            
            self.presenter.viewDidLoad()
            self.refreshControl.endRefreshing()
        
        }
        
    }
}


//MARK:- collection view delegates 
extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfMovies()
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
        let size: CGFloat = (collectionView.frame.size.width - margin )/2
        
        return CGSize(width: size , height: 300)
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
