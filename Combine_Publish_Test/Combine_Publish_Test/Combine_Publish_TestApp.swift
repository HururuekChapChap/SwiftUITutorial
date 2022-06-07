//
//  Combine_Publish_TestApp.swift
//  Combine_Publish_Test
//
//  Created by TaeSoo Yoon on 2022/06/07.
//

import SwiftUI

@main
struct Combine_Publish_TestApp: App {
    var body: some Scene {
        WindowGroup {
            VGrideView(viewModel: VGrideViewModel())
        }
    }
}
