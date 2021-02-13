//
//  NitrolessParser.swift
//  NitrolessiOS
//
//  Created by Amy While on 10/02/2021.
//
/*
 
import UIKit

class NitrolessParser {
    static let shared = NitrolessParser()
    var lastUsed: Data?
    
    var emotes = [Emote]() {
        didSet {
            DispatchQueue.main.async {
                NotificationCenter.default.post(name: .EmoteReload, object: nil)
            }
        }
    }
    
    private func saveToCache(data: Data, fileName: String) {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        if !FileManager.default.fileExists(atPath: fileURL.path) {
            do {
                try data.write(to: fileURL)
            } catch {
                fatalError("Well this is dumb")
            }
        }
    }
    
    private func attemptRetrieve(fileName: String) -> Data? {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        do {
            return try Data(contentsOf: fileURL)
        } catch {
            return nil
        }
    }
    
    private func initialGenerate(emote: [String : String]) -> Emote {
        var e = Emote()
        e.name = emote["name"] ?? "Error"
        switch emote["type"] {
            case ".png": do {
                e.type = .png
                e.fullPath = e.name + ".png"
                guard let url = URL(string: "https://raw.githubusercontent.com/TheAlphaStream/nitroless-assets/main/assets/\(e.name ?? "Error").png") else { fatalError("Fucking Alpha") }
                e.url = url
            }
            case ".gif": do {
                e.type = .gif
                e.fullPath = e.name + ".gif"
                guard let url = URL(string: "https://raw.githubusercontent.com/TheAlphaStream/nitroless-assets/main/assets/\(e.name ?? "Error").gif") else { fatalError("Fucking Alpha") }
                e.url = url
            }
            default: break
        }
        return e
    }
    
    private func imageGenerate(emote: Emote, data: Data) -> Emote {
        var e = emote
        switch e.type {
            case.png: do {
                if let image = UIImage(data: data) {
                    e.image = image
                }
            }
            case .gif: do {
                if let gif = UIImage.gifImageWithData(data) {
                    e.image = gif
                }
            }
            default: fatalError("It's impossible to call this")
        }
        return e
    }
    
    private func generateFromArray(array: [[String : String]]) {
        var arrayICanUse = array
        var localArray = [Emote]()
        var buffer = 0
        for (index, emote) in arrayICanUse.enumerated() {
            var e = self.initialGenerate(emote: emote)
            if let data = self.attemptRetrieve(fileName: e.fullPath) {
                e = self.imageGenerate(emote: e, data: data)
                arrayICanUse.remove(at: index - buffer)
                buffer += 1
                if !localArray.contains(where: {$0.name == e.name}) {
                    localArray.append(e)
                }
            }
        }
        self.emotes = localArray
        for emote in arrayICanUse {
            var e = self.initialGenerate(emote: emote)
            NetworkManager.getData(url: e.url, completion: { (success, data) -> Void in
                if let data = data {
                    if success {
                        switch e.type {
                        case.png: do {
                            if let image = UIImage(data: data) {
                                e.image = image
                                if !self.emotes.contains(where: {$0.name == e.name}) {
                                    self.saveToCache(data: data, fileName: e.fullPath)
                                    self.emotes.append(e)
                                }
                            }
                        }
                        case .gif: do {
                            if let gif = UIImage.gifImageWithData(data) {
                                e.image = gif
                                if !self.emotes.contains(where: {$0.name == e.name}) {
                                    self.saveToCache(data: data, fileName: e.fullPath)
                                    self.emotes.append(e)
                                }
                            }
                        }
                        default: break
                        }
                    }
                }
            })
        }
    }
    
    public func getEmotes(sender: Sender) {
        if let cachedData = self.attemptRetrieve(fileName: "emotes.json") {
            if cachedData != self.lastUsed || sender == .keyboard {
                do {
                    let arr = try JSONSerialization.jsonObject(with: cachedData, options: .mutableContainers) as? [[String : String]] ?? [[String : String]]()
                    self.generateFromArray(array: arr)
                    self.lastUsed = cachedData
                } catch {}
            }
        }
        NetworkManager.request(url: URL(string: "https://raw.githubusercontent.com/TheAlphaStream/nitroless-assets/main/emotes.json")!, completion: { (success, array, data) -> Void in
            if success {
                if let cachedData = self.attemptRetrieve(fileName: "emotes.json") {
                    if cachedData == data {
                        return
                    } else {
                        if let data = data {
                            self.saveToCache(data: data, fileName: "emotes.json")
                            self.lastUsed = data
                        }
                        self.generateFromArray(array: array)
                    }
                } else {
                    if let data = data {
                        self.saveToCache(data: data, fileName: "emotes.json")
                        self.lastUsed = data
                        self.generateFromArray(array: array)
                    }
                }
            }
        })
    }
}

enum EmoteType {
    case png
    case gif
}

enum Sender {
    case app
    case keyboard
}

struct Emote {
    var type: EmoteType!
    var name: String!
    var url: URL!
    var image: UIImage?
    var fullPath: String!
}
