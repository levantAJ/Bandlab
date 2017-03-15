//
//  BaseServiceApi.swift
//  Bandlab
//
//  Created by Le Tai on 3/15/17.
//  Copyright © 2017 levantAJ. All rights reserved.
//

import Foundation

enum Response<Value> {
    case success(Value)
    case failure(Error)
}


//List all of API of the app
enum API {
    case songs
    
    var url: URL {
        let link: URL
        switch self {
        case .songs:
            link = URL(string: "https://gist.githubusercontent.com/anonymous/fec47e2418986b7bdb630a1772232f7d/raw/5e3e6f4dc0b94906dca8de415c585b01069af3f7/57eb7cc5e4b0bcac9f7581c8.json")!
        }
        return link
    }
}

final class BaseServiceApi {
    func array<T: Mappable>(api: API, completion: ((Response<[T]>) -> Void)? = nil) {
        request(url: api.url) { (response) in
            switch response {
            case .failure(let error):
                completion?(.failure(error))
            case .success(let json):
                if let objects: [T] = Mapper<T>().map(json: json) {
                    completion?(.success(objects))
                } else {
                    let error = NSError.error(description: Constant.LocalizedString.CannotMappingObject)
                    completion?(.failure(error))
                }
            }
        }
    }
    
    func object<T: Mappable>(api: API, completion: ((Response<T>) -> Void)? = nil) {
        request(url: api.url) { (response) in
            switch response {
            case .failure(let error):
                completion?(.failure(error))
            case .success(let json):
                if let object: T = Mapper<T>().map(json: json) {
                    completion?(.success(object))
                } else {
                    let error = NSError.error(description: Constant.LocalizedString.CannotMappingObject)
                    completion?(.failure(error))
                }
            }
        }
    }
    
    func request(api: API, completion: ((Response<Any>) -> Void)? = nil) {
        request(url: api.url, completion: completion)
    }
}

//MARK: -Privates

extension BaseServiceApi {
    fileprivate func request(url: URL, completion: ((Response<Any>) -> Void)? = nil) {
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                completion?(.failure(error))
            }
            else if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    completion?(.success(json))
                }
                catch let error {
                    completion?(.failure(error))
                }
            }
        }.resume()
    }
}
