//
//  NetworkLayer.swift
//  NetworkLayer_RxSwift
//
//  Created by Abdelrahman Mahmoud on 12/12/19.
//  Copyright © 2019 Abdelrahman Mahmoud. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa


//Main Class For Network Operations.

class NetworkLayer: NSObject, URLSessionDelegate {
    
    
    //Shared Instance For Universal Use.
    
    static let shared: NetworkLayer = NetworkLayer()
    
    
    //Delegate Queue.
    
    private let delegateQueue: OperationQueue
    
    
    //Private Initializer.
    
    private override init(){
        delegateQueue = OperationQueue()
    }
    
    
    //Main Function For Calling Data Services.
    
    func callDataService<T: Decodable>(urlPath: String, method: HTTPMethod, timeOutInterval: TimeInterval, headers: [String: String]? = nil, postData: NetworkLayerEncodable? = nil, responseClass: T.Type) -> Observable<T>? {
        
        
        //URL Encoding.
        
        guard let encodedURL = urlPath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            print("Failure URL Encoding")
            return nil }
        guard let url = URL(string: encodedURL) else {
            print("Failure Creating URL Object")
            return nil }
        
        
        //Constructing URL Request.
        
        var urlRequest = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: timeOutInterval)
        urlRequest.httpMethod = method.rawValue
        if let httpHeaders = headers {
            urlRequest.allHTTPHeaderFields = httpHeaders
        }
        if let body = postData {
            do{
                let jsonObj = try body.toJSONData()
                urlRequest.httpBody = jsonObj
            } catch {
                print(error.localizedDescription)
                return nil
            }
        }
        
        
        //Constrcuting URL Session.
        
        let urlSesssion = URLSession.init(configuration: .default, delegate: self, delegateQueue: delegateQueue)
        
        
        //Constructing Data Task.
        
        return urlSesssion.rx.data(request: urlRequest).map({data -> T in
           try JSONDecoder().decode(T.self, from: data)
        })
    }
}
