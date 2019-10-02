//
//  GCD.swift
//  Simple Powerlifting
//
//  Created by Sungjea Cho on 5/11/17.
//  Copyright © 2017 chillmo. All rights reserved.
//

import Foundation

func performUIUpdatesOnMain(updates: @escaping () -> Void) {
    DispatchQueue.main.async {
        updates()
    }
}
