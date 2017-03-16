//
//  SongServiceApi.swift
//  Bandlab
//
//  Created by Le Tai on 3/16/17.
//  Copyright © 2017 levantAJ. All rights reserved.
//

import Foundation

final class SongServiceApi {
    func retrieveSongs(completion: @escaping (Response<[Song]>) -> Void) {
        BaseServiceApi().request(api: .songs) { (response) in
            switch response {
            case .failure(let error):
                completion(.failure(error))
            case .success(let json):
                if let json: [String: Any] = json as? [String: Any],
                    let data: Any = json["data"],
                    let songs: [Song] = Mapper<Song>().map(jsonObject: data) {
                    completion(.success(songs))
                } else {
                    let error = NSError.error(description: Constant.LocalizedString.Unspecified)
                    completion(.failure(error))
                }
            }
        }
    }
}
