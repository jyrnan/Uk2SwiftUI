//
//  VersionShouldUpdateView.swift
//  Uk2SwiftUI
//
//  Created by jyrnan on 2023/5/16.
//

import SwiftUI

//MARK: - 用于首页提示升级的版本视图

struct VersionShouldUpdateView: View {
  /// 传入的用来dissmiss UIHostingViewController方法
//  var dismissClosure: (() -> Void)?
  
  @StateObject var vm = VersionCheckViewModel()
  
  /// 弹窗高度值
  @State var newVersionViewHeight: CGFloat = 0
  
    var body: some View {
      ZStack(alignment: .bottom){
        
        Color.black
          .opacity(vm.showNewVersionView ? 0.6 : 0)
          .ignoresSafeArea()
          .onTapGesture {
            if !vm.isForceUpdateVersion {
              vm.showNewVersionView = false
//              dismissClosure?()
            }
          }
        
        NewVersionView(vm: vm, newVersionViewHeight: $newVersionViewHeight)
          .frame(height: newVersionViewHeight)
          .offset(y: vm.showNewVersionView ? 0 : newVersionViewHeight )
      }
      .ignoresSafeArea(edges: .bottom)
      .animation(.default, value: vm.showNewVersionView)
      .onDisappear{
          print("onDisappear")
      }
      .onAppear{
//        vm.checkNewVersion(id: "1523021399")
          print("onAppear")
        vm.showNewVersionView = true
      }
    
    }
}


struct VersionShouldUpdateView_Previews: PreviewProvider {
    static var previews: some View {
        VersionShouldUpdateView()
    }
}
