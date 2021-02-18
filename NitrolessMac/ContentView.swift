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

// actual view
struct ContentView: View {
    @State var recents = [Emote]()
    @State var SearchText: String = ""
    let pasteboard = NSPasteboard.general
    var columns: [GridItem] = [
        GridItem(spacing: 20),
        GridItem(spacing: 20),
        GridItem(spacing: 20)
    ]
    @State var searchContents: [[String:String]] = []
    @Environment(\.openURL) var openURL
    @State var currentViewSeen: Int = 0
    @State var title: String = "Nitroless"
    @State var recentsenabled = true
    @State var searchenabled = true
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
                    .buttonStyle(BorderlessButtonStyle())
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
                    .buttonStyle(BorderlessButtonStyle())
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
                    .buttonStyle(BorderlessButtonStyle())
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
                                                    .cornerRadius(2)
                                                Text(emote.name ?? "")
                                                    .font(.caption)
                                                    .foregroundColor(.primary)
                                            }
                                        }
                                        .buttonStyle(CoolButtonStyle())
                                    }
                                }
                            }
                            Divider()
                        }
                        LazyVGrid(columns: columns) {
                            ForEach(NitrolessParser.shared.emotes, id: \.self) { emote in
                                Button(action: {
                                    pasteboard.clearContents()
                                    pasteboard.setString(emote.url.absoluteString, forType: NSPasteboard.PasteboardType.string)
                                    if recents.count == 3 {
                                        recents.remove(at: 2)
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
                                .buttonStyle(CoolButtonStyle())
                            }
                        }
                        .padding(.top)
                        .transition(.opacity)
                    }
                }
                if currentViewSeen == 1 {
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
                        HStack {
                            Text("Quit app")
                                .font(.title3)
                                .fontWeight(.bold)
                            Spacer()
                            Button(action: {
                                NSApp.terminate(self)
                            }) {
                                Image(systemName: "xmark.circle.fill")
                            }
                        }
                    }
                }
                if currentViewSeen == 2 {
                    VStack {
                        TextField("Search", text: $SearchText)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        LazyVGrid(columns: columns) {
                            ForEach(searchFilter(args: SearchText), id: \.self) { emote in
                                Button(action: {
                                    pasteboard.clearContents()
                                    pasteboard.setString(emote.url.absoluteString, forType: NSPasteboard.PasteboardType.string)
                                    if recents.count == 3 {
                                        recents.remove(at: 2)
                                    }
                                    recents.insert(emote, at: 0)
                                }) {
                                    VStack {
                                        FuckingSwiftUI(emote: emote)
                                            .frame(maxWidth: 48, maxHeight: 48)
                                            .scaledToFit()
                                            .cornerRadius(2)
                                        Text(emote.name ?? "")
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
            }

        }.frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
            ContentView()
    }
}
