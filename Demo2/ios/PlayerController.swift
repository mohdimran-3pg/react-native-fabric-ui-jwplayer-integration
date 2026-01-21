//
//  PlayerController.swift
//  Demo
//
//  Created by Mohd Imran on 19/01/26.
//
import Foundation
import UIKit
import JWPlayerKit

class PlayerController: JWPlayerViewController {

  private let posterUrlString = "https://d3el35u4qe4frz.cloudfront.net/bkaovAYt-480.jpg"

  convenience init(licenseKey: String) {
      self.init()
      JWPlayerKitLicense.setLicenseKey(licenseKey)
  }

  override func viewDidLoad() {
      super.viewDidLoad()

      setupViews()
  }

  override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
  }

  func setupViews() {

      view.backgroundColor = .black

      var currentWidth = 0.0
      if UIDevice.current.orientation.isLandscape {
          currentWidth = UIScreen.main.bounds.height
      } else {
          currentWidth = UIScreen.main.bounds.width
      }
      let vidHeight: CGFloat = 9 * currentWidth / 16
      let vidWidth = currentWidth

      view.frame = CGRect(x: 0, y: 0, width: vidWidth, height: vidHeight)
  }

  func loadPL(with url: String) {
      let videoUrl = URL(string:url)!
      let posterUrl = URL(string:posterUrlString)!
      // First, use the JWPlayerItemBuilder to create a JWPlayerItem that will be used by the player configuration.
      let playerItembuilder = JWPlayerItemBuilder()
          .file(videoUrl)
          .posterImage(posterUrl)
      var playerItem: JWPlayerItem!
      do {
          playerItem = try playerItembuilder.build()
      } catch {
          // Handle player item build failure
          print(error.localizedDescription)
          return
      }

      // Second, create a player config with the created JWPlayerItem.
      let configBuilder = JWPlayerConfigurationBuilder()
          .playlist(items: [playerItem])
          .autostart(true)
      var config: JWPlayerConfiguration!
      do {
          config = try configBuilder.build()
      } catch {
          // Handle player item build failure
          print(error.localizedDescription)
          return
      }

      // Lastly, use the created JWPlayerConfiguration to set up the player.
      player.configurePlayer(with: config)
  }

  deinit {

  }
}

