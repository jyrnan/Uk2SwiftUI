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
  var versionCheckViewModel: VersionCheckViewModel = .init()
  
  weak var viewController: UIViewController?
  /// 持有用来生成SwiftUIView的VC
  var hostingController: UIHostingController<VersionShouldUpdateView>!
  
  init(viewController: UIViewController) {
    self.viewController = viewController
    addObserver()
    setupVersionShouldUpdateView()
  }
    
  /// 注册Publisher方法
  func addObserver() {
    versionCheckViewModel.$newVersionInfo.sink { [weak self] versionInfo in
      guard let self = self else { return }
      
      print(#line, #function, "$newVersionInfo: \(versionInfo.debugDescription)")
      if versionInfo != nil {
        self.showVersionShouldUpdateView()
      }
    }
    .store(in: &disposeBag)
    
    versionCheckViewModel.$showNewVersionView.sink { [weak self] showNewVersionView in
      guard let self = self else { return }
      
      print(#line, #function, "$showNewVersionView:\(showNewVersionView)")
      if !showNewVersionView {
        self.dismissVersionShouldUpdateView()
      }
    }
    .store(in: &disposeBag)
  }
  
  /// 设置好要添加的NewVersionView的VC
  func setupVersionShouldUpdateView() {
    let sView = VersionShouldUpdateView(vm: self.versionCheckViewModel)
    
    /// 生成包含SwiftUIView的VC
    hostingController = UIHostingController(rootView: sView)
    hostingController.modalPresentationStyle = .overFullScreen
    hostingController.view.backgroundColor = .clear
  }
  
  func showVersionShouldUpdateView() {
    guard viewController?.presentedViewController == nil else { return }
    viewController?.present(hostingController, animated: false)
  }
  
  /// 用来消除UIHostingVC的方法，延迟0.2秒调用
  func dismissVersionShouldUpdateView() {
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { [weak self] in
      self?.viewController?.presentedViewController?.dismiss(animated: false)
    }
  }

  func checkNewVersion() {
    versionCheckViewModel.checkNewVersion(id: "1523021399")
  }
}
