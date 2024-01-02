//
//  BaseView.swift
//
//
//  Created by Dmytro Yantsybaiev on 02.01.2024.
//

import SwiftUI

public protocol BaseView: View {

    associatedtype ViewModel: ViewModelType

    var viewModel: ViewModel { get }

    init(_ viewModel: ViewModel)
}
