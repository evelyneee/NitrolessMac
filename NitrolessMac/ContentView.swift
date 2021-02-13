//
// ContentView.swift
// NitrolessMac
//
// Created by e b on 12.02.21
//

import SwiftUI

struct CoolButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? CGFloat(0.85) : 1.0)
            .rotationEffect(.degrees(configuration.isPressed ? 0.0 : 0))
            .blur(radius: configuration.isPressed ? CGFloat(0.0) : 0)
            .animation(Animation.spring(response: 0.35, dampingFraction: 1, blendDuration: 0))
            .padding(.bottom, 3)
    }
}

var emotesHardCode: [String: String] = [
    "sad": "https://github.com/TheAlphaStream/nitroless-assets/blob/main/assets/sad.png?raw=true",
    "goshimgay": "https://github.com/TheAlphaStream/nitroless-assets/blob/main/assets/goshimgay.png?raw=true",
    "hug": "https://github.com/TheAlphaStream/nitroless-assets/blob/main/assets/hug.png?raw=true",
    "heart_trans":"https://github.com/TheAlphaStream/nitroless-assets/blob/main/assets/heart_trans.png?raw=true",
    "kekw":"https://github.com/TheAlphaStream/nitroless-assets/blob/main/assets/kekw.png?raw=true",
    "heyurcute":"https://github.com/TheAlphaStream/nitroless-assets/blob/main/assets/heyurcute.png?raw=true",
    "fail":"https://github.com/TheAlphaStream/nitroless-assets/blob/main/assets/02fail.png?raw=true",
    "fr": "https://github.com/TheAlphaStream/nitroless-assets/blob/main/assets/fr.png?raw=true",
    "vibeok": "https://github.com/TheAlphaStream/nitroless-assets/blob/main/assets/vibeok.png?raw=true",
    "where": "https://github.com/TheAlphaStream/nitroless-assets/blob/main/assets/where.png?raw=true",
    "troll": "https://github.com/TheAlphaStream/nitroless-assets/blob/main/assets/troll.png?raw=true",
    "dancinghug": "https://raw.githubusercontent.com/Nitroless/Assets/main/assets/dancingpug.gif?raw=true"
]

struct EmptyView: View {
    var body: some View {
        Text("cock")
    }
}
var emotes: [[String: String]] = parseJSON(filename: "emotes.json")

struct ContentView: View {
    let pasteboard = NSPasteboard.general
    var columns: [GridItem] = [
        GridItem(spacing: 20),
        GridItem(spacing: 20),
        GridItem(spacing: 20)
    ]
    @Environment(\.openURL) var openURL
    @State var currentViewSeen: Int = 0
    @State var title: String = "Nitroless"
    @State var recentsenabled = true
    @State var searchenabled = true
    var body: some View {
        VStack{
            ScrollView {
                HStack {
                    Text(title)
                        .font(.title)
                        .fontWeight(.bold)
                    Spacer()
                    if currentViewSeen != 0 {
                        Button(action: {
                            currentViewSeen = 0
                            title = "Nitroless"
                        }) {
                            Image(systemName: "star.fill")
                                .font(.title)
                                .foregroundColor(.primary)
                        }
                        .buttonStyle(BorderlessButtonStyle())
                    }
                    if currentViewSeen != 1 {
                        Button(action: {
                            print(emotes)
                            currentViewSeen = 1
                            title = "Credits"
                        }) {
                            Image(systemName: "sparkles")
                                .foregroundColor(.primary)
                                .font(.title)
                        }
                        .buttonStyle(BorderlessButtonStyle())
                    }
                    if currentViewSeen != 2 {
                        Button(action: {
                            currentViewSeen = 2
                            title = "Settings"
                        }) {
                            Image(systemName: "gearshape.fill")
                                .foregroundColor(.primary)
                                .font(.title)
                        }
                        .buttonStyle(BorderlessButtonStyle())
                    }
                    if currentViewSeen != 3 && searchenabled == true {
                        Button(action: {
                            currentViewSeen = 3
                            title = "Search"
                        }) {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.primary)
                                .font(.title)
                        }
                        .buttonStyle(BorderlessButtonStyle())
                    }
                }
                
                if currentViewSeen == 0 {
                    LazyVGrid(columns: columns) {
                        ForEach(0..<emotes.count, id: \.self) { emoteDict in
                            Button(action: {
                                pasteboard.clearContents()
                                pasteboard.setString("https://raw.githubusercontent.com/Nitroless/Assets/main/assets/\((emotes[emoteDict])["name"]!)\((emotes[emoteDict])["type"]!)", forType: NSPasteboard.PasteboardType.string)
                            }) {
                                VStack {
                                    ImageWithURL("https://raw.githubusercontent.com/Nitroless/Assets/main/assets/\((emotes[emoteDict])["name"]!)\((emotes[emoteDict])["type"]!)")
                                        .frame(width: 48, height: 48)
                                        .cornerRadius(2)
                                    Text((emotes[emoteDict])["name"]!)
                                        .font(.caption)
                                        .foregroundColor(.primary)
                                }
                            }
                            .buttonStyle(CoolButtonStyle())
                        }
                    }
                    .transition(.opacity)
                }
                if currentViewSeen == 1 {
                    VStack(alignment: .leading) {
                        Button(action: {
                            guard let url = URL(string: "https://twitter.com/Kutarin_") else { return }
                            openURL(url)
                        }) {
                            HStack {
                                Image(systemName: "link")
                                Divider()
                                Text("alpha ~ Site and Assets  ")
                                Spacer()
                            }
                        }
                        .padding(10)
                        .frame(width: 220)
                        .background(Color.secondary.colorInvert())
                        .buttonStyle(BorderlessButtonStyle())
                        .cornerRadius(10)
                    }
                    .transition(.opacity)
                    .padding(.top, 15)
                    VStack(alignment: .leading) {
                        Button(action: {
                            guard let url = URL(string: "https://twitter.com/elihweilrahc13") else { return }
                            openURL(url)
                        }) {
                            HStack {
                               Image(systemName: "link")
                               Divider()
                               Text("Amy ~ iOS App and Parser")
                            }
                        }
                        .padding(10)
                        .frame(width: 220)
                        .background(Color.secondary.colorInvert())
                        .buttonStyle(BorderlessButtonStyle())
                        .cornerRadius(10)
                    }
                    .transition(.opacity)
                    VStack(alignment: .leading) {
                        Button(action: {
                            guard let url = URL(string: "https://twitter.com/a1thio") else { return }
                            openURL(url)
                        }) {
                            HStack {
                                Image(systemName: "link")
                                Divider()
                                Text("althio ~ macOS App        ")
                                Spacer()
                            }
                        }
                        .padding(10)
                        .frame(width: 220)
                        .background(Color.secondary.colorInvert())
                        .buttonStyle(BorderlessButtonStyle())
                        .cornerRadius(10)
                        
                    }
                    .transition(.opacity)
                }
                if currentViewSeen == 2 {
                    VStack {
                        HStack {
                            Text("Recents")
                                .font(.title3)
                                .fontWeight(.bold)
                            Spacer()
                            Toggle(isOn: $recentsenabled) {
                            }
                            .toggleStyle(SwitchToggleStyle())
                        }
                        .padding(.top)
                        HStack {
                            Text("Search")
                                .font(.title3)
                                .fontWeight(.bold)
                            Spacer()
                            Toggle(isOn: $searchenabled) {
                            }
                            .toggleStyle(SwitchToggleStyle())
                        }
                    }
                }
                if currentViewSeen == 3 {
                    
                }
            }

        }.frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
    }
}
