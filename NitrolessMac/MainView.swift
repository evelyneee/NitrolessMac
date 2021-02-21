//
// Views.swift
// NitrolessMac
//
// Created by e b on 12.02.21
//

import SwiftUI

struct SpringyButton: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? CGFloat(0.85) : 1.0)
            .rotationEffect(.degrees(configuration.isPressed ? 0.0 : 0))
            .blur(radius: configuration.isPressed ? CGFloat(0.0) : 0)
            .animation(Animation.spring(response: 0.35, dampingFraction: 1, blendDuration: 0))
            .padding(.bottom, 3)
    }
}

// actual view
struct ContentView: View {
    @State var recents = [Emote]()
    @State var SearchText: String = ""
    let pasteboard = NSPasteboard.general
    var columns: [GridItem] = [
        GridItem(spacing: 10),
        GridItem(spacing: 10),
        GridItem(spacing: 10),
        GridItem(spacing: 10)
    ]
    var fiverowcolumns: [GridItem] = [
        GridItem(spacing: 10),
        GridItem(spacing: 10),
        GridItem(spacing: 10),
        GridItem(spacing: 10),
        GridItem(spacing: 10)
    ]
    @State var minimumWidth = 275
    @State var recentMax = 4
    @State var searchContents: [[String:String]] = []
    @Environment(\.openURL) var openURL
    @State var currentViewSeen: Int = 0
    @State var title: String = "Nitroless"
    @State var recentsenabled = true
    @State var searchenabled = true
    @State var fiverowenabled = false
    var body: some View {
        VStack {
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
                    .buttonStyle(SpringyButton())
                }

                if currentViewSeen != 1 {
                    Button(action: {
                        currentViewSeen = 1
                        title = "Settings"
                    }) {
                        Image(systemName: "gearshape.fill")
                            .foregroundColor(.primary)
                            .font(.title)
                    }
                    .buttonStyle(SpringyButton())
                }
                if currentViewSeen != 2 && searchenabled == true {
                    Button(action: {
                        currentViewSeen = 2
                        title = "Search"
                    }) {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.primary)
                            .font(.title)
                    }
                    .buttonStyle(SpringyButton())
                }
            }
            ScrollView {
                if currentViewSeen == 0 {
                    VStack {
                        if recentsenabled {
                            ZStack {
                                if recents.count == 0 {
                                    Text("No recents")
                                        .padding(30)
                                }
                                if fiverowenabled == true {
                                    LazyVGrid(columns: fiverowcolumns) {
                                        ForEach(recents, id: \.self) { emote in
                                            Button(action: {
                                                pasteboard.clearContents()
                                                pasteboard.setString(emote.url.absoluteString, forType: NSPasteboard.PasteboardType.string)
                                            }) {
                                                VStack {
                                                    FuckingSwiftUI(emote: emote)
                                                        .frame(maxWidth: 48, maxHeight: 48)
                                                        .scaledToFit()
                                                    Text(emote.name ?? "")
                                                        .font(.caption)
                                                        .foregroundColor(.primary)
                                                }
                                            }
                                            .buttonStyle(SpringyButton())
                                        }
                                    }
                                    .onAppear {
                                        minimumWidth = 325
                                        recentMax = 5
                                    }
                                } else {
                                    LazyVGrid(columns: columns) {
                                        ForEach(recents, id: \.self) { emote in
                                            Button(action: {
                                                pasteboard.clearContents()
                                                pasteboard.setString(emote.url.absoluteString, forType: NSPasteboard.PasteboardType.string)
                                            }) {
                                                VStack {
                                                    FuckingSwiftUI(emote: emote)
                                                        .frame(maxWidth: 48, maxHeight: 48)
                                                        .scaledToFit()
                                                    Text(emote.name ?? "")
                                                        .font(.caption)
                                                        .foregroundColor(.primary)
                                                }
                                            }
                                            .buttonStyle(SpringyButton())
                                        }
                                    }
                                    .onAppear {
                                        minimumWidth = 275
                                        recentMax = 4
                                    }
                                }
                            }
                            Divider()
                        }
                        if fiverowenabled == true {
                            LazyVGrid(columns: fiverowcolumns) {
                                ForEach(NitrolessParser.shared.emotes, id: \.self) { emote in
                                    Button(action: {
                                        pasteboard.clearContents()
                                        pasteboard.setString(emote.url.absoluteString, forType: NSPasteboard.PasteboardType.string)
                                        if recents.contains(emote) {
                                            for i in 0..<recents.count {
                                                if recents[i].name == emote.name {
                                                    recents.remove(at: i)
                                                    break
                                                }
                                            }
                                        } else {
                                            if recents.count == recentMax {
                                                recents.remove(at: recentMax - 1)
                                            }
                                        }
                                        recents.insert(emote, at: 0)
                                    }) {
                                        VStack {
                                            FuckingSwiftUI(emote: emote)
                                                .frame(maxWidth: 48, maxHeight: 48)
                                                .scaledToFit()
                                                .cornerRadius(2)
                                            Text(emote.name ?? "Error")
                                                .font(.caption)
                                                .foregroundColor(.primary)
                                        }
                                    }
                                    .buttonStyle(SpringyButton())
                                }
                            }
                            .padding(.top)
                            .transition(.opacity)
                        } else {
                            LazyVGrid(columns: columns) {
                                ForEach(NitrolessParser.shared.emotes, id: \.self) { emote in
                                    Button(action: {
                                        pasteboard.clearContents()
                                        pasteboard.setString(emote.url.absoluteString, forType: NSPasteboard.PasteboardType.string)
                                        if recents.contains(emote) {
                                            for i in 0..<recents.count {
                                                if recents[i].name == emote.name {
                                                    recents.remove(at: i)
                                                    break
                                                }
                                            }
                                        } else {
                                            if recents.count == recentMax {
                                                recents.remove(at: recentMax - 1)
                                            }
                                        }
                                        recents.insert(emote, at: 0)
                                    }) {
                                        VStack {
                                            FuckingSwiftUI(emote: emote)
                                                .frame(maxWidth: 48, maxHeight: 48)
                                                .scaledToFit()
                                                .cornerRadius(2)
                                            Text(emote.name ?? "Error")
                                                .font(.caption)
                                                .foregroundColor(.primary)
                                        }
                                    }
                                    .buttonStyle(SpringyButton())
                                }
                            }
                            .padding(.top)
                            .transition(.opacity)
                        }
                    }
                }
                if currentViewSeen == 1 {
                    SettingsView(recentsenabled: $recentsenabled, searchenabled: $searchenabled, fiverowenabled: $fiverowenabled)
                }
                if currentViewSeen == 2 {
                    SearchView(SearchText: $SearchText, fiverowenabled: $fiverowenabled)
                }
            }
        }
        .frame(minWidth: CGFloat(minimumWidth), maxWidth: .infinity, maxHeight: .infinity)
        .padding()
    }
}
