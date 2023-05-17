//
//  MainViewVersionChecker.swift
//  Uk2SwiftUI
//
//  Created by jyrnan on 2023/5/16.
//

import SwiftUI
import Combine


class MainViewVersionChecker {
  private var disposeBag = Set<AnyCancellable>()
  lazy var versionChecker: VersionCheckViewModel = .init()
  
  weak var viewController: UIViewController?
  
  init(viewController: UIViewController) {
    self.viewController = viewController
  }
  
  func showVersionShouldUpdateView() {
    let sView = VersionShouldUpdateView()
    let hostingController = UIHostingController(rootView: sView)
    hostingController.modalPresentationStyle = .overFullScreen
    hostingController.view.backgroundColor = .clear
    viewController?.present(hostingController, animated: false)
  }

  func checkNewVersion() {
    versionChecker.$newVersionInfo.sink { [weak self] versionInfo in
      guard let self = self else { return }
      
      if versionInfo != nil {
        self.showVersionShouldUpdateView()
      }
    }
    .store(in: &disposeBag)
    
    versionChecker.checkNewVersion(id: "1523021399")
  }
}
