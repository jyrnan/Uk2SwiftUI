//
//  ViewController.swift
//  Uk2SwiftUI
//
//  Created by jyrnan on 2023/4/11.
//

import Combine
import SwiftUI
import UIKit


class ViewController: UIViewController {
  
  lazy var versionChecker: MainViewVersionChecker = .init(viewController: self)
  
  private var myView: UIView!

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    view.backgroundColor = .orange
    navigationItem.title = "VC"
    
    versionChecker.checkNewVersion()
  }
  
  @IBAction func showPrivacyAgreementView(sender: Any?) {
    configurePrivacyAgreementView()
  }
  
  @IBAction func showPersonCenterViewAction(sender: Any?) {
    naviToMyView()
  }
  
  @IBAction func showVersionCheckViewAction(sender: Any?) {
    versionChecker.checkNewVersion()
  }

  func configurePrivacyAgreementView() {
    let sView = PrivacyAgreementView(agreeClosure: {}, cancelClosure: removeSheetView, licenseClosure: {})
    let hostingController = UIHostingController(rootView: sView)
    
    myView = hostingController.view
    view.addSubview(myView)
    myView.translatesAutoresizingMaskIntoConstraints = false
    myView.backgroundColor = .clear
    view.addSubview(myView)
//    myView.layer.cornerRadius = 24

    NSLayoutConstraint.activate([
      myView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      myView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      myView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      myView.heightAnchor.constraint(equalToConstant: 427)
    ])
//    myView.frame = CGRect(x: 50, y: UIScreen.main.bounds.height - 427, width: UIScreen.main.bounds.width - 100, height: 427)
  }
  
  func removeSheetView() {
    myView.removeFromSuperview()
  }
  
  @objc func leftBarClicked() {
    navigationController?.popViewController(animated: true)
  }
  
  func naviToMyView() {
    let leftBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
    leftBtn.addTarget(self, action: #selector(leftBarClicked), for: .touchUpInside)
    leftBtn.setBackgroundImage(UIImage(named: "NavBackIcon"), for: .normal)
    let leftItem = UIBarButtonItem(customView: leftBtn)
    
    let sView = PersonalCenterMyView()
    let hostingController = UIHostingController(rootView: sView)
//    hostingController.title = "我的"
    let arrowImg = UIImage(systemName: "chevron.backward")?.withTintColor(UIColor(named: "TextColor1")!, renderingMode: .alwaysOriginal)
    let backBarButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    let imageBackBarButton = UIBarButtonItem(image: arrowImg, style: .plain, target: nil, action: nil)
    /// 为了让后面的ViewController不显示返回按钮的文字，
    /// 需要将当前一个ViewController的backBarButtonItem文字设置成空
    navigationItem.backBarButtonItem = backBarButton
    
    /// 为了让后面的ViewController不显示返回按钮的文字，
    /// 需要将当前一个ViewController的backBarButtonItem文字设置成空
    /// 这里和上面所指的ViewController不同
    hostingController.navigationItem.backBarButtonItem = backBarButton
    navigationController?.pushViewController(hostingController, animated: true)
  }
  
  func naviToCommonQuestionView() {
    let sView = PersonalCenterQuestionsView()
    let hostingController = UIHostingController(rootView: sView)
    hostingController.title = "常见问题"
    
    navigationController?.pushViewController(hostingController, animated: true)
  }
}
