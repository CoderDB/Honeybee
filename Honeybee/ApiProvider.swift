//
//  ApiProvider.swift
//  Honeybee
//
//  Created by Dongbing Hou on 13/05/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import Foundation
import Moya

enum ApiProvider {
    case userInfo(uid: String)
}

extension ApiProvider: TargetType {
    var baseURL: URL {
        return URL(string: "http:www.honeybee.com")!
    }
    
    var path: String {
        switch self {
        case .userInfo(_):
            return "/userinfo"
        }
    }
    
    var method: Moya.Method {
        return .post
    }
    
    var parameters: [String : Any]? {
        switch self {
        case let .userInfo(uid):
            return ["uid": uid]
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
    
    var sampleData: Data {
        return "".data(using: .utf8)!
    }
    var task: Task {
        return Task.request
    }
}
