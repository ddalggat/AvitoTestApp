//
//  StateBinding.swift
//  AvitoTestApp
//
//  Created by Abdullabekov Dalgat on 8/27/23.
//

import Foundation

enum State {
    case none
    case loading
    case error
    case result
}

final class StateBinding {
    var value: State {
        didSet {
            stateBinding?(value)
        }
    }
    
    init(_ value: State) {
        self.value = value
    }
    
    private var stateBinding:((State) -> Void)?

    func bind(_ stateBinding: @escaping(State) -> Void) {
        stateBinding(value)
        self.stateBinding = stateBinding
    }
}
