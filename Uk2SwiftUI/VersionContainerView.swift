//
//  VersionContainerView.swift
//  Uk2SwiftUI
//
//  Created by jyrnan on 2023/4/18.
//

import SwiftUI

struct VersionContainerView: View {
  
  
  @StateObject var vm = VersionCheckViewModel()
  
  @State var newVersionViewHeight: CGFloat = 340
  
    var body: some View {
      ZStack(alignment: .bottom){
        AboutView(vm: vm)
        
        Color.black
          .opacity(vm.showNewVersionView ? 0.6 : 0)
          .ignoresSafeArea()
        
        NewVersionView(vm: vm)
          .frame(height: newVersionViewHeight)
          .offset(y: vm.showNewVersionView ? 0 : newVersionViewHeight )
      }
      .ignoresSafeArea(edges: .bottom)
      .animation(.default, value: vm.showNewVersionView)
      .onAppear(perform: vm.checkNewVersion)
    }
}

struct VersionContainerView_Previews: PreviewProvider {
    static var previews: some View {
      NavigationView {
        VersionContainerView()

      }
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
  let url = "https://itunes.apple.com/lookup?id=1523021399"
  
  func checkNewVersion() {
    self.isCheckingVersion = true
    print("Checking new version")
    
    let dataTask = URLSession.shared.dataTask(with: URLRequest(url: URL(string: url)!)) { data, response, error in
      if let data = data {
        if let versionResult = try? JSONDecoder().decode(VersionResult.self, from: data), let newVersionInfo = versionResult.results.first {
          
          DispatchQueue.main.async{
            if newVersionInfo.version > self.currentVersion {
              self.newVersionInfo = newVersionInfo
            }
            self.isCheckingVersion = false
          }
        }
      }
    }
    dataTask.resume()
  }
}
