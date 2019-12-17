//
//  NetworkLayerEncodable.swift
//  NetworkLayer_RxSwift
//
//  Created by Abdelrahman Mahmoud on 12/12/19.
//  Copyright © 2019 Abdelrahman Mahmoud. All rights reserved.
//

import Foundation


//Custom protocol for objects encoding.

protocol NetworkLayerEncodable: Encodable {
    func toJSONData() throws ->  Data
}

extension NetworkLayerEncodable {
    func toJSONData() throws -> Data {
        return try JSONEncoder().encode(self)
    }
}
