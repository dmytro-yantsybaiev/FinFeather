//
//  PassthroughSubject+Extensions.swift
//
//
//  Created by Dmytro Yantsybaiev on 02.01.2024.
//

import Combine

public extension PassthroughSubject where Output == Void {

    func send() {
        send(Void())
    }
}
