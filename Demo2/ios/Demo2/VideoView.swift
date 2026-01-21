//
//  VideoView.swift
//  app
//
//  Created by Diego Cue on 05/03/25.
//

import UIKit

// swiftlint:disable force_unwrapping

@objc(VideoView)
class VideoView: UIView {

    private var controller: PlayerController?
    private var pendingUrl: String?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) { fatalError("nope") }

    override func layoutSubviews() {
        super.layoutSubviews()
    }

    override func didMoveToWindow() {
        super.didMoveToWindow()

        guard window != nil, controller == nil else { return }
        setup()
    }

    private func setup() {
        guard let parentVC = parentViewController else { return }

        let player = PlayerController(licenseKey: "--- JW License Key --- ")
        parentVC.add(child: player)
        controller = player
        if let url = pendingUrl {
            controller?.loadPL(with: url)
            pendingUrl = nil
        }
    }

    @objc func setUpUrl(_ url: String) {
      print("Setting up video URL:", url)
      guard let controller else {
        pendingUrl = url
        return
      }
      controller.loadPL(with: url)
    }

    deinit {
        controller?.willMove(toParent: nil)
        controller?.view.removeFromSuperview()
        controller?.removeFromParent()
    }
}
