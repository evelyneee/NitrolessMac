//
// EmoteGetter.swift
// NitrolessMac
//
// Created by e b on 12.02.21
//

import SwiftUI
import AppKit

struct FuckingSwiftUI: NSViewRepresentable {

    let emote: Emote

    func makeNSView(context: Self.Context) -> NSView {
        let containerView = NSView(frame: CGRect(x: 0, y: 0, width: 48, height: 48))
        switch emote.type {
            case .png: do {
                let iv = NSImageView(frame: CGRect(x: 0, y: 0, width: 48, height: 48))
                iv.image = emote.image
                iv.autoresizesSubviews = true
                containerView.addSubview(iv)
            }
            case .gif: do {
                if let ag = emote.image as? AmyGif {
                    containerView.layer = CALayer()
                    containerView.wantsLayer = true
                    let layer = CALayer()
                    let keyPath = "contents"
                    let frameAnimation = CAKeyframeAnimation(keyPath: keyPath)
                    frameAnimation.repeatCount = .infinity
                    frameAnimation.values = ag.image
                    frameAnimation.duration = CFTimeInterval(ag.calculatedDuration)
                    let layerRect = CGRect(origin: .zero, size: containerView.frame.size)
                    layer.frame = layerRect
                    layer.bounds = layerRect
                    containerView.layer?.cornerRadius = 5.0
                    layer.add(frameAnimation, forKey: keyPath)
                    containerView.layer?.addSublayer(layer)
                }
            }
            default: fatalError("If you've called this, you're dead")
        }
        return containerView
    }

    func updateNSView(_ uiView: NSView, context: NSViewRepresentableContext<FuckingSwiftUI>) {

    }
}

func searchFilter(args: String) -> [Emote] {
    if args.isEmpty {
        return NitrolessParser.shared.emotes
    } else {
        return NitrolessParser.shared.emotes.filter { (emote:  Emote) -> Bool in
            emote.name.lowercased().contains(args.lowercased())
        }
    }
}
