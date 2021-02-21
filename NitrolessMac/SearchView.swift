//
//  SearchView.swift
//  NitrolessMac
//
//  Created by e b on 2021-02-20.
//

import SwiftUI

struct SearchView: View {
    @State var recents = [Emote]()
    var columns: [GridItem] = [
        GridItem(spacing: 10),
        GridItem(spacing: 10),
        GridItem(spacing: 10),
        GridItem(spacing: 10),
        GridItem(spacing: 10)
    ]
    let pasteboard = NSPasteboard.general
    @Binding var SearchText: String
    var body: some View {
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
                            Text(emote.name ?? "")
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

