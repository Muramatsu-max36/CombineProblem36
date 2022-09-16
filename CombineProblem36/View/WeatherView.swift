//
//  WeatherView.swift
//  CombineProblem36
//
//  Created by cmStudent on 2022/09/16.
//

import SwiftUI

struct WeatherView: View {
    
    @StateObject private var viewModel = WeatherViewModel()
    
    var body: some View {
        if viewModel.isShowView {
            DetailView(viewModel: viewModel)
        } else {
            HomeView(viewModel: viewModel)
        }
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
    }
}

