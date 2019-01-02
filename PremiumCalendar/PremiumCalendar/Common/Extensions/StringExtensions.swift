//
//  someExtensions.swift
//  HipotecarioApp
//
//  Created by iMac on 13/12/2018.
//  Copyright © 2018 Hipotecario. All rights reserved.
//

import UIKit

extension String {
    
    func localized(withComment comment: String? = nil) -> String {
        return NSLocalizedString(self, comment: comment ?? "")
    }
    
}
