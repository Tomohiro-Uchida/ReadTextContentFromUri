//
//  SharingFileType.swift
//  multi_wallet_share
//
//  Created by Tomohiro Uchida on 2023/08/09.
//

import Foundation

enum SharingFileType: Int, Codable {
    case text
    case url
    case image
    case video
    case file
}
