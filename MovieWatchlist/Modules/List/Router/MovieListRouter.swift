//
//  MovieListRouter.swift
//  MovieWatchlist
//
//  Created by Abhishek Sheth on 3/20/16.
//  Copyright © 2017 Abhishek Sheth. All rights reserved.
//

import UIKit

class MoviesRouter: MovieListWireframe {
    
    weak var viewController: UIViewController?
    
    static func assembleModule() -> UIViewController {
        let view = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MovieListViewController") as! MovieListViewController
        let presenter = MovieListPresenter()
        let interactor = MovieListInteractor()
        let router = MoviesRouter()
        
        let navigation = UINavigationController(rootViewController: view)
        
        view.presenter = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        interactor.output = presenter
        
        router.viewController = view
        
        return navigation
    }
    
    func showFavorites() {
        //let detailsModuleViewController = FavoritesRouter.assembleModule()
        //viewController?.navigationController?.pushViewController(detailsModuleViewController, animated: true)
    }
}
