//
//  Optional+Utils.swift
//  
//
//  Created by Kushal Panchal on 7/23/26.
//

import Foundation

extension Optional {
    @usableFromInline
    func unwrap(or error: @autoclosure () -> Error) throws -> Wrapped {
        switch self {
        case .some(let wrapped): return wrapped
        case .none: throw error()
        }
    }
}
