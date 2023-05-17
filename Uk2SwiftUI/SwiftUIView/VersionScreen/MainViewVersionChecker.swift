//
//  MainViewVersionChecker.swift
//  Uk2SwiftUI
//
//  Created by jyrnan on 2023/5/16.
//

import Combine
import SwiftUI

class MainViewVersionChecker {
  private var disposeBag = Set<AnyCancellable>()
  var versionChecker: VersionCheckViewModel = .init()
  
  weak var viewController: UIViewController?
  /// 持有用来生成SwiftUIView的VC
  var hostingController: UIHostingController<VersionShouldUpdateView>!
  
  init(viewController: UIViewController) {
    self.viewController = viewController
    addObserver()
  }
    
  /// 添加Publisher方法
  func addObserver() {
    versionChecker.$newVersionInfo.sink { [weak self] versionInfo in
      guard let self = self else { return }
      
      if versionInfo != nil {
        self.showVersionShouldUpdateView()
      }
    }
    .store(in: &disposeBag)
  }
  
  func showVersionShouldUpdateView() {
    let sView = VersionShouldUpdateView(dismissClosure: dismissVersionShouldUpdateView)
    
    /// 生成包含SwiftUIView的VC
    hostingController = UIHostingController(rootView: sView)
    hostingController.modalPresentationStyle = .overFullScreen
    hostingController.view.backgroundColor = .clear
    
    viewController?.present(hostingController, animated: false)
  }
  
  /// 用来消除UIHostingVC的方法，延迟0.2秒调用
  func dismissVersionShouldUpdateView() {
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { [weak self] in
      self?.hostingController?.dismiss(animated: false)
    }
  }

  func checkNewVersion() {
    versionChecker.checkNewVersion(id: "1523021399")
  }
}
