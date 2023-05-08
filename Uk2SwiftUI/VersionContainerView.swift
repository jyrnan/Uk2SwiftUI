//
//  VersionContainerView.swift
//  Uk2SwiftUI
//
//  Created by jyrnan on 2023/4/18.
//

import SwiftUI

struct VersionContainerView: View {
  
  
  @StateObject var vm = VersionCheckViewModel()
  
  /// 弹窗高度值
  @State var newVersionViewHeight: CGFloat = 0
  
    var body: some View {
      ZStack(alignment: .bottom){
        AboutView(vm: vm)
        
        Color.black
          .opacity(vm.showNewVersionView ? 0.6 : 0)
          .ignoresSafeArea()
          .onTapGesture {
            vm.showNewVersionView = false
          }
        
        NewVersionView(vm: vm, newVersionViewHeight: $newVersionViewHeight)
          .frame(height: newVersionViewHeight)
          .offset(y: vm.showNewVersionView ? 0 : newVersionViewHeight )
      }
      .ignoresSafeArea(edges: .bottom)
      .animation(.default, value: vm.showNewVersionView)
      .onAppear{
        vm.checkNewVersion()
      }
    }
}

struct VersionContainerView_Previews: PreviewProvider {
    static var previews: some View {
      NavigationView {
        VersionContainerView()

      }
      
    }
}

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
            self.isCheckingVersion = false
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
