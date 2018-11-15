//
//  UserDefaultsStore.swift
//  NCU
//
//  Created by Simon Rowlands on 14/11/2018.
//  Copyright © 2018 simonrowlands. All rights reserved.
//

import Foundation

final class UserDefaultsStore {
    /** T must be Encodable, note that in Swift 4.2, Enums are not Encodable on their own */
    static func store<T: Encodable>(encodableData: T?, to key: String) {
        guard let data = encodableData else { return }
        do {
            let encodedData = try JSONEncoder().encode(data)
            UserDefaults.standard.set(encodedData, forKey: key)
        } catch {
            debugPrint("Failed to encode data! \(error.localizedDescription)")
        }
    }
    
    static func retrieve<T: Decodable>(from key: String) -> T? {
        guard let data = UserDefaults.standard.data(forKey: key) else { return nil }
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            debugPrint("Failed to decode data! \(error.localizedDescription)")
        }
        return nil
    }
}
