//
//  NetworkManager.swift
//  NitrolessiOS
//
//  Created by Amy While on 10/02/2021.
//

import Foundation

/// The completion handler used by every request in the library
/// - Parameters:
///   - success: If the API request was succesful
///   - error: The error code returned from EduLink
public typealias completionHandler = (_ success: Bool, _ error: String?) -> ()

internal class NetworkManager {

    internal typealias rdc = (_ success: Bool, _ array: [[String : String]], _ data: Data?) -> ()
    internal typealias dcr = (_ success: Bool, _ data: Data?) -> ()

    class internal func request(url: URL, completion: @escaping rdc) {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) -> Void in
            if let data = data {
                do {
                    let arr = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [[String : String]] ?? [[String : String]]()
                    completion(true, arr, data)
                } catch {
                    completion(false, [[String : String]](), nil)
                }
            } else { completion(false, [[String : String]](), nil)}
        }
        NotificationCenter.default.addObserver(forName: .ReloadEmotes, object: nil, queue: nil) {_ in
            task.cancel()
        }
        task.resume()
    }
    
    class internal func getData(url: URL, completion: @escaping dcr) {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) -> Void in
            if let data = data {
                completion(true, data)
            } else {
                completion(true, nil)
            }
        }
        NotificationCenter.default.addObserver(forName: .ReloadEmotes, object: nil, queue: nil) {_ in
            task.cancel()
        }
        task.resume()
    }
}
