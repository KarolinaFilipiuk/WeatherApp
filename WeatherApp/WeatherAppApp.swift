//
//  WeatherAppApp.swift
//  WeatherApp
//
//  Created by Kaffoux on 23/05/2021.
//

import SwiftUI

@main
struct WeatherAppApp: App {
    var viewModel = WeatherViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: viewModel)
        }
    }
}
