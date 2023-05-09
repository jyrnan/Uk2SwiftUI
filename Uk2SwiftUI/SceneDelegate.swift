//
//  SceneDelegate.swift
//  Uk2SwiftUI
//
//  Created by jyrnan on 2023/4/11.
//

import SwiftUI
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  var window: UIWindow?

  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
    // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
    // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
    guard let _ = (scene as? UIWindowScene) else { return }

    // For Back button customization, setup the custom image for UINavigationBar inside CustomBackButtonNavController.
    let backButtonBackgroundImage = resizeImage(image: UIImage(named: "编组")!, verticalPadding: 4)?.withTintColor(.init(named: "TextColor1")!, renderingMode: .alwaysOriginal)

    let barAppearance =
      UINavigationBar.appearance()
    barAppearance.backIndicatorImage = backButtonBackgroundImage
    barAppearance.backIndicatorTransitionMaskImage = backButtonBackgroundImage
//
//    // Nudge the back UIBarButtonItem image down a bit.
    // 只对后面是文字才有效果，并且是前面的图片和后面的文字同时更改
    let barButtonAppearance =
      UIBarButtonItem.appearance()
    barButtonAppearance.setBackButtonTitlePositionAdjustment(UIOffset(horizontal: 0, vertical: -5), for: .default)
  }

  func sceneDidDisconnect(_ scene: UIScene) {
    // Called as the scene is being released by the system.
    // This occurs shortly after the scene enters the background, or when its session is discarded.
    // Release any resources associated with this scene that can be re-created the next time the scene connects.
    // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
  }

  func sceneDidBecomeActive(_ scene: UIScene) {
    // Called when the scene has moved from an inactive state to an active state.
    // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
  }

  func sceneWillResignActive(_ scene: UIScene) {
    // Called when the scene will move from an active state to an inactive state.
    // This may occur due to temporary interruptions (ex. an incoming phone call).
  }

  func sceneWillEnterForeground(_ scene: UIScene) {
    // Called as the scene transitions from the background to the foreground.
    // Use this method to undo the changes made on entering the background.
  }

  func sceneDidEnterBackground(_ scene: UIScene) {
    // Called as the scene transitions from the foreground to the background.
    // Use this method to save data, release shared resources, and store enough scene-specific state information
    // to restore the scene back to its current state.
  }
}

func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage? {
  let scale = newWidth / image.size.width
  let newHeight = image.size.height * scale
  UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
  image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))

  let newImage = UIGraphicsGetImageFromCurrentImageContext()
  UIGraphicsEndImageContext()

  return newImage
}

/// 将图片上下各增加padding， 前面增加2倍padding，后面不增加
/// 因为图片本身这样可以让图片在保持
/// - Parameters:
///   - image: 原图片
///   - padding: 图片上下各增加的空间
/// - Returns: 增加空间后的图片
func resizeImage(image: UIImage, verticalPadding: CGFloat) -> UIImage? {
  
  /// 获取宽高比后计算宽高各增加的padding值，可以保证新图片尺寸和原图一致
  let ratio = image.size.width / image.size.height
  
  let newWidth = image.size.width + verticalPadding * 2 * ratio
  let newHeight = image.size.height + verticalPadding * 2

  UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
  image.draw(in: CGRect(x: verticalPadding * 2, y: verticalPadding, width: image.size.width, height: image.size.height))

  let newImage = UIGraphicsGetImageFromCurrentImageContext()
  UIGraphicsEndImageContext()

  return newImage
}
