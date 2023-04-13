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
    self.view.backgroundColor = .red
    
  }
  
  @IBAction func showSwiftUI(sender: Any?) {
    configureCustomView()
  }
  
  @IBAction func showPesonCenterViewAction(sender: Any?) {
    naviToPersonCenterView()
  }
  
//  @IBSegueAction func toSwfitUIView(_ coder: NSCoder) -> UIViewController?  {
//    return UIHostingController(coder: coder, rootView: SwiftUIView())
//  }

  func configureCustomView() {
    let sView = PrivacyAgreementView(agreeClosure: {}, cancelClosure: removeSheetView, lisenceClosure: {})
    let hostingController = UIHostingController(rootView: sView)
    
//    self.addChild(hostingController)
    myView = hostingController.view
    self.view.addSubview(myView)
    myView.translatesAutoresizingMaskIntoConstraints = false
    myView.backgroundColor = .clear
            view.addSubview(myView)
    myView.layer.cornerRadius = 24

            NSLayoutConstraint.activate([
              myView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
//              myView.topAnchor.constraint(equalTo: view.topAnchor),
                myView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                myView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                myView.heightAnchor.constraint(equalToConstant: 427)
            ])
  }
  
  func removeSheetView() {
    myView.removeFromSuperview()
  }
  
  func showPersonCenterView() {
    let sView = PersonalCenterView()
    let hostingController = UIHostingController(rootView: sView)
    
//    self.addChild(hostingController)
    myView = hostingController.view
    self.view.addSubview(myView)
    myView.translatesAutoresizingMaskIntoConstraints = false
    myView.backgroundColor = .clear
            view.addSubview(myView)
    myView.layer.cornerRadius = 24

            NSLayoutConstraint.activate([
              myView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
              myView.topAnchor.constraint(equalTo: view.topAnchor),
                myView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                myView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//                myView.heightAnchor.constraint(equalToConstant: 427)
            ])
  }
  
  func naviToPersonCenterView() {
    let sView = PersonalCenterView()
    let hostingController = UIHostingController(rootView: sView)
    hostingController.title = "常见问题"
    
    self.navigationController?.pushViewController(hostingController, animated: true)
  }

}

