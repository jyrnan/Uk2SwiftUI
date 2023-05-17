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

