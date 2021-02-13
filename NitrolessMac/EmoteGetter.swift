//
// EmoteGetter.swift
// NitrolessMac
//
// Created by e b on 12.02.21
//

import Foundation
import SwiftUI

struct ImageWithURL: View {
    
    @ObservedObject var imageLoader: ImageLoaderAndCache

    init(_ url: String) {
        imageLoader = ImageLoaderAndCache(imageURL: url)
    }

    var body: some View {
        Image(nsImage: (NSImage(data: self.imageLoader.imageData) ?? NSImage(named: "sad")) ?? NSImage())
              .resizable()
              .clipped()
    }
}

class ImageLoaderAndCache: ObservableObject {
    
    @Published var imageData = Data()
    
    init(imageURL: String) {
        let cache = URLCache.shared
        let request = URLRequest(url: URL(string: imageURL)!, cachePolicy: URLRequest.CachePolicy.returnCacheDataElseLoad, timeoutInterval: 60.0)
        if let data = cache.cachedResponse(for: request)?.data {
            self.imageData = data
        } else {
            URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                if let data = data, let response = response {
                let cachedData = CachedURLResponse(response: response, data: data)
                                    cache.storeCachedResponse(cachedData, for: request)
                    DispatchQueue.main.async {
                        self.imageData = data
                    }
                }
            }).resume()
        }
    }
}

func getJSON(urlToRequest: String) -> Data {
    do {
        let JSONData: Data = try Data(contentsOf: URL(string: urlToRequest)!)
        print("Got Wifi! JSON available")
        return JSONData
    } catch {
        print("No wifi, fallback to local JSON")
        let JSONData = try! Data(contentsOf: Bundle.main.url(forResource: "emotes.json", withExtension: nil)!)
        return JSONData
    }
}

func parseJSON(filename: String) -> [[String:String]] {
    do {
        let arr = try JSONSerialization.jsonObject(with: getJSON(urlToRequest: "https://raw.githubusercontent.com/Nitroless/Assets/main/emotes.json") as Data, options: .mutableContainers) as? [[String : String]] ?? [[String : String]]()
        return arr
    } catch {
        return [["error": "could not parse"]]
    }
}
