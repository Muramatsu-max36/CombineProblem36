//
//  HomeView.swift
//  CombineProblem36
//
//  Created by cmStudent on 2022/09/16.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var viewModel: WeatherViewModel
    
    init(viewModel: WeatherViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        if viewModel.isLode {
            ProgressView()
        } else {
            Button(action: {
                viewModel.lode()
                viewModel.isLode = true
            }) {
                Text("表示")
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: WeatherViewModel())
    }
}
