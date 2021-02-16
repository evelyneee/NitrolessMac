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

// empty view for popup

struct EmptyView: View {
    var body: some View {
        Text("cock")
    }
}

// emotes array
var emotes: [[String: String]] = parseJSON(filename: "emotes.json")

// actual view  

struct ContentView: View {
    @State var recents: [[String:String]] = []
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
                    VStack {
                        if recents.count != 0 && recentsenabled {
                            LazyVGrid(columns: columns) {
                                ForEach(0..<recents.count, id: \.self) { recentEmote in
                                    Button(action: {
                                        pasteboard.clearContents()
                                        pasteboard.setString("https://nitroless.quiprr.dev/\((recents[recentEmote])["name"]!)\((recents[recentEmote])["type"]!)", forType: NSPasteboard.PasteboardType.string)
                                    }) {
                                        VStack {
                                            ImageWithURL("https://nitroless.quiprr.dev/\((recents[recentEmote])["name"]!)\((recents[recentEmote])["type"]!)")
                                                .frame(maxWidth: 48, maxHeight: 48)
                                                .scaledToFit()
                                                .cornerRadius(2)
                                            Text((recents[recentEmote])["name"]!)
                                                .font(.caption)
                                                .foregroundColor(.primary)
                                        }
                                    }
                                    .buttonStyle(CoolButtonStyle())
                                }
                            }
                            Divider()
                        }
                        LazyVGrid(columns: columns) {
                            ForEach(0..<emotes.count, id: \.self) { emoteDict in
                                Button(action: {
                                    pasteboard.clearContents()
                                    pasteboard.setString("https://nitroless.quiprr.dev/\((emotes[emoteDict])["name"]!)\((emotes[emoteDict])["type"]!)", forType: NSPasteboard.PasteboardType.string)
                                    if recents.count == 3 {
                                        recents.remove(at: 2)
                                    }
                                    recents.insert((emotes[emoteDict]), at: 0)
                                    print(recents)
                                }) {
                                    VStack {
                                        ImageWithURL("https://nitroless.quiprr.dev/\((emotes[emoteDict])["name"]!)\((emotes[emoteDict])["type"]!)")
                                            .frame(maxWidth: 48, maxHeight: 48)
                                            .scaledToFit()
                                            .cornerRadius(2)
                                        Text((emotes[emoteDict])["name"]!)
                                            .font(.caption)
                                            .foregroundColor(.primary)
                                    }
                                }
                                .buttonStyle(CoolButtonStyle())
                            }
                        }
                        .padding(.top)
                        .transition(.opacity)
                    }
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
