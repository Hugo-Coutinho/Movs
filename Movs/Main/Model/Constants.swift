//
//  Constants.swift
//  Movs
//
//  Created by BRQ on 02/04/19.
//  Copyright © 2019 BRQ. All rights reserved.
//

import Foundation

enum Constants {
    
    static let token: String = "8294d9700f85e20265086a49235ffbed"
    
    enum Router {
        static let tvBaseURL: String = "https://api.themoviedb.org/3/tv/"
        static let genreBaseUrl: String = "https://api.themoviedb.org/3/genre/tv/"
        static let getPopularPath: String = "popular"
        static let getGenrePath: String = "list"
        static let api_key: String = "api_key"
    }
    
    enum cellIdentifier {
        static let tvShowCell: String = "TvShowCell"
    }
    
    enum viewImage {
        static let favorite: String = "favorite_full_icon"
        static let notFavorite: String = "favorite_gray_icon"
        static let defaultImage: String = "Splash"
    }
    
    enum LottieAnimation {
        static let loading = "loading"
        static let error = "connection-error"
        static let offline = "network_error"
        
        enum Message {
            static let loadingMessage = "searching Tv Shows ..."
            static let errorMessage = "An error has ocurred. Tap here to try again"
            static let offlineMessage = "No connection. Tap here to try again"
        }
    }
}
