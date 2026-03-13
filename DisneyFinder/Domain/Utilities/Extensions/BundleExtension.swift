//
//  BundleExtension.swift
//  DisneyFinder
//
//  Created by Fabricio Banda on 12/03/26.
//

import Foundation

extension Bundle {
    var apiHost: String {
        self.object(forInfoDictionaryKey: "ApiHost") as? String ?? ""
    }
}

