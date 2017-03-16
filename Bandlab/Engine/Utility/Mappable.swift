//
//  Mappable.swift
//  Bandlab
//
//  Created by Le Tai on 3/15/17.
//  Copyright © 2017 levantAJ. All rights reserved.
//

import UIKit

//Convert json value to specific value for Mappable object
final class Map {
    fileprivate var json: [String: Any]
    
    init(json: [String: Any]) {
        self.json = json
    }
    
    subscript(key: String) -> Any? {
        return json[key]
    }
    
    subscript(key: String) -> [String: Any]? {
        return json[key] as? [String : Any]
    }
    
    func string(_ key: String) -> String? {
        return json[key] as? String
    }
    
    func url(_ key: String) -> URL? {
        guard let string: String = json[key] as? String else { return nil }
        return URL(string: string)
    }
    
    func int(_ key: String) -> Int? {
        if let string = json[key] as? String {
            return Int(string)
        }
        return json[key] as? Int
    }
    
    func double(_ key: String) -> Double? {
        if let string = json[key] as? String {
            return Double(string)
        }
        return json[key] as? Double
    }
    
    func date(_ key: String, format: String) -> Date? {
        return (json[key] as? String)?.date(format: format)
    }
    
    func object<T: Mappable>(_ key: String) -> T? {
        guard let json = json[key] else { return nil }
        return Mapper<T>().map(json: json)
    }
}


//Protocol to let object can convert from JSON to itself
protocol Mappable {
    init()
    mutating func mapping(map: Map)
}


//Map a JSON to an object
final class Mapper<T: Mappable> {
    func map(json: [String: Any]) -> T? {
        var object: T = T()
        let map: Map = Map(json: json)
        object.mapping(map: map)
        return object
    }
    
    func map(json: Any) -> T? {
        guard let json = json as? [String: Any] else { return nil }
        return map(json: json)
    }
    
    func map(jsonArray: [[String: Any]]) -> [T] {
        return jsonArray.flatMap { map(json: $0) }
    }
    
    func map(jsonObject: Any) -> [T]? {
        guard let json = jsonObject as? [[String: Any]] else { return nil }
        return map(jsonArray: json)
    }
}
