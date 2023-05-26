//
//  VersionCheckerViewModel.swift
//  Uk2SwiftUI
//
//  Created by jyrnan on 2023/5/17.
//

import SwiftUI
//MARK: - ViewModel

class VersionCheckViewModel: ObservableObject {
  
  struct VersionInfo: Codable {
    let version: String
    let releaseNotes: String
  }
  
  struct VersionResult: Codable {
    var resultCount : Int
    var results : [VersionInfo]
  }
  
  @Published var showNewVersionView = false
  @Published var newVersionInfo: VersionInfo?
  
  @Published var isCheckingVersion = false
  let currentVersion: String = "1.0.0"
  
  /// 决定是否需要强制升级
  var isForceUpdateVersion:Bool { return self.newVersionInfo?.releaseNotes.range(of: "造成闪退") != nil }
  
  
  func checkNewVersion(id: String = "6447176780") {
    
    let url = "https://itunes.apple.com/lookup?id=" + id //6447176780 小康在家1523021399
    self.isCheckingVersion = true
    print("Checking new version ID: \(id)")
    
    let dataTask = URLSession.shared.dataTask(with: URLRequest(url: URL(string: url)!)) { data, response, error in
      if let data = data {
        if let versionResult = try? JSONDecoder().decode(VersionResult.self, from: data){
          DispatchQueue.main.async{
            
            if let newVersionInfo = versionResult.results.first,  newVersionInfo.version > self.currentVersion {
              self.newVersionInfo = newVersionInfo
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
              self.isCheckingVersion = false
            }
            
          }
        }
      }
      
      ///  出错判断为没有更新版本
      if error != nil {
        DispatchQueue.main.async{
          self.newVersionInfo = nil
          self.isCheckingVersion = false
        }
      }
    }
    dataTask.resume()
  }
}
