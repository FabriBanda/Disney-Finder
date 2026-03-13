//
//  ApiResponseVO.swift
//  DisneyFinder
//
//  Created by Fabricio Banda on 08/03/26.
//

import Foundation

struct ApiResponseVO<T> where T:Sendable{
    let data: T
}
