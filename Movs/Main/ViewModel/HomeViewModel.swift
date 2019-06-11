//
//  HomeViewModel.swift
//  Movs
//
//  Created by BRQ on 18/03/19.
//  Copyright © 2019 BRQ. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol HomeViewModelDelegate {
    func setupTvShowVisibility()
    func setupAnimationVisibility(animationMode: String, message: String)
}

final class HomeViewModel {
    
    var items = BehaviorRelay(value: TvViewDataModel())
    var allItems = TvViewDataModel()
    var paginationControl: Pagination = Pagination(page: 1, totalAmountShows: 0, totalPages: 0, isLoading: false)
    private var db: FavoriteManager!
    private let tvService = TvService()
    private let genresService = GenreService()
    private var delegate: HomeViewModelDelegate?
    let bag = DisposeBag()
    
    
    init(delegate: HomeViewModelDelegate) {
        self.delegate = delegate
        self.db = FavoriteManager()
        
        do {
            
            try CheckInternetConnection().connectionOk()
            
            self.delegate?.setupAnimationVisibility(animationMode: Constants.LottieAnimation.loading, message: Constants.LottieAnimation.Message.loadingMessage)
            fetchTvShowsConfigurations()
            
        } catch {
            self.delegate?.setupAnimationVisibility(animationMode: Constants.LottieAnimation.offline, message: Constants.LottieAnimation.Message.offlineMessage)
        }
    }
    
    func fetchFavoriteShows() {
        self.db.findAll().forEach { (currentFavorite) in
            self.allItems.forEach({ (element) in
                if currentFavorite.titleTvShow == element.titleTvShow {
                    element.isFavorite = currentFavorite.isFavorite
                }
            })
        }
        self.items.accept(self.allItems)
    }
    
    func requestNewPage() {
        self.paginationControl.isLoading = true
        self.fetchTvShows()
    }
}


// MARK: - SERVICE
extension HomeViewModel {
    private func fetchTvShowsConfigurations() {
        #if TESTING
        if let models = mockService().loadFromMock(),
            models.count > 0 {
            self.db.deleteAll()
            self.delegate?.setupTvShowVisibility()
            self.allItems = models
            self.items.accept(self.allItems)
            return
        }
        self.items.accept(TvViewDataModel())
        #elseif DEBUG
        fetchTvShows()
        #endif
    }
    
    private func fetchTvShows() {
        self.tvService.provideTVShows(page: self.paginationControl.page).subscribe {
            switch $0 {
            case .success(let element):
                self.acceptItems(element: element)
                self.delegate?.setupTvShowVisibility()
            case .error(let error):
                print(error)
                self.paginationControl.isLoading = false
                self.delegate?.setupAnimationVisibility(animationMode: Constants.LottieAnimation.error, message: Constants.LottieAnimation.Message.errorMessage)
            }
            }.disposed(by: self.bag)
    }
    
    private func fetchGenres(tvShowModel: TvViewDataModel, genresIDS: [String: [Int]]) {
        self.genresService.provideGenres().subscribe {
            switch $0 {
            case .success(let genresModel):
                let tvShows = Genre.setGenresForEachTvShows(tvShows: tvShowModel, genres: genresModel, genreIDS: genresIDS)
                self.allItems += tvShows
                self.fetchFavoriteShows()
            case .error(let error):
                print(error)
                self.paginationControl.isLoading = false
                self.delegate?.setupAnimationVisibility(animationMode: Constants.LottieAnimation.error, message: Constants.LottieAnimation.Message.errorMessage)
            }
            }.disposed(by: self.bag)
    }
}


// MARK: - HELPER FUNCTIONS
extension HomeViewModel {
    
    private func acceptItems(element: TvModel) {
        self.paginationControl = Pagination(page: element.page, totalAmountShows: element.totalResults, totalPages: element.totalResults, isLoading: false)
        self.parseToViewData(results: element.results)
    }
    
    private func parseToViewData(results: [Result]) {
        var model: TvViewDataModel = TvViewDataModel()
        var ids = [String: [Int]]()
        
        results.forEach { (result) in
            
            if TvViewDataElement.propertyOfShowIsValid(showJsonObject: result),
                let element = TvViewDataElement.newInstanceViewDataElement(element: result) {
                
                ids[element.titleTvShow] = [Int]()
                ids[element.titleTvShow]!.append(contentsOf: result.genreIDS!)
                model.append(element)
            }
        }
        self.fetchGenres(tvShowModel: model, genresIDS: ids)
    }
}
