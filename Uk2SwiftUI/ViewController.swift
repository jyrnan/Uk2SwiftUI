//
//  ViewController.swift
//  Uk2SwiftUI
//
//  Created by jyrnan on 2023/4/11.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {
  
  private var myView: UIView!

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    
  }
  
  @IBAction func showPrivacyAgreementView(sender: Any?) {
    configurePrivacyAgreementView()
  }
  
  @IBAction func showPersonCenterViewAction(sender: Any?) {
    naviToMyView()
  }

  func configurePrivacyAgreementView() {
    let sView = PrivacyAgreementView(agreeClosure: {}, cancelClosure: removeSheetView, lisenceClosure: {})
    let hostingController = UIHostingController(rootView: sView)
    
    myView = hostingController.view
    self.view.addSubview(myView)
    myView.translatesAutoresizingMaskIntoConstraints = false
    myView.backgroundColor = .clear
            view.addSubview(myView)
    myView.layer.cornerRadius = 24

            NSLayoutConstraint.activate([
              myView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                myView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                myView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                myView.heightAnchor.constraint(equalToConstant: 427)
            ])
  }
  
  func removeSheetView() {
    myView.removeFromSuperview()
  }
  
  func naviToMyView() {
    let sView = PersonalCenterMyView(toQuestionView: naviToCommonQuestionView, toAboutView: naviToCommonQuestionView)
    let hostingController = UIHostingController(rootView: sView)
    hostingController.title = "我的"
   
    let backBarButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    /// 为了让后面的ViewController不显示返回按钮的文字，
    /// 需要将当前一个ViewController的backBarButtonItem文字设置成空
    navigationItem.backBarButtonItem = backBarButton
    
    /// 为了让后面的ViewController不显示返回按钮的文字，
    /// 需要将当前一个ViewController的backBarButtonItem文字设置成空
    /// 这里和上面所指的ViewController不同
    hostingController.navigationItem.backBarButtonItem = backBarButton
   
    self.navigationController?.pushViewController(hostingController, animated: true)
  }
  
  func naviToCommonQuestionView() {
    let sView = PersonalCenterQuestionsView()
    let hostingController = UIHostingController(rootView: sView)
    hostingController.title = "常见问题"
    
    self.navigationController?.pushViewController(hostingController, animated: true)
  }

}

