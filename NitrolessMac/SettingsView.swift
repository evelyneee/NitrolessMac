//
//  SettingsView.swift
//  NitrolessMac
//
//  Created by e b on 2021-02-20.
//

import SwiftUI

struct SettingsView: View {
    @Binding var recentsenabled: Bool
    @Binding var searchenabled: Bool
    @Binding var fiverowenabled: Bool
    var body: some View {
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
                Text("5 row layout")
                    .font(.title3)
                    .fontWeight(.bold)
                Spacer()
                Toggle(isOn: $fiverowenabled) {
                }
            }
            .toggleStyle(SwitchToggleStyle())
            HStack {
                Text("Quit app")
                    .font(.title3)
                    .fontWeight(.bold)
                Spacer()
                Button(action: {
                    NSApp.terminate(self)
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.title2)
                        .padding(.trailing, 5)
                }
                .buttonStyle(BorderlessButtonStyle())
            }
            HStack {
                Text("Force reload")
                    .font(.title3)
                    .fontWeight(.bold)
                Spacer()
                Button(action: {
                    NitrolessParser.shared.getEmotes()
                }) {
                    Image(systemName: "arrow.clockwise.circle.fill")
                        .font(.title2)
                        .padding(.trailing, 5)
                }
                .buttonStyle(BorderlessButtonStyle())
            }
        }
    }
}
