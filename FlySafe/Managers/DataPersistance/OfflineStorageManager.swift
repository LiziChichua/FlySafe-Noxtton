//
//  OfflineStorageManager.swift
//  FlySafe
//
//  Created by Nika Topuria on 03.02.22.
//

import Foundation


class OfflineStorageManager {
    
    func convertToJson <T: Codable>(info: T) -> Data? {
        let encoder = JSONEncoder()
        encoder.dataEncodingStrategy = .base64
        guard let data = try? encoder.encode(info) else {return nil}
        return data
    }
    
    
    func saveJsonToFile(data: Data) {
        let fileManager = FileManager.default
        let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
        if let path = documentDirectory?.appendingPathComponent("Flight_Plans_And_Restrictions.json") {
            if fileManager.fileExists(atPath: path.absoluteString) {
                do {
                    try fileManager.removeItem(at: path)
                } catch {
                    print (error)
                }
            } else {
                do {
                    try data.write(to: path)
                } catch {
                    print (error)
                }
            }
        }
    }
    
    
    func readFromJsonFile() -> Data? {
        let fileManager = FileManager.default
        let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
        if let path = documentDirectory?.appendingPathComponent("Flight_Plans_And_Restrictions.json") {
                do {
                    return try Data(contentsOf: path)
                } catch {
                    print (error)
                }
        }
        return nil
    }
    
    
    func decodeFromRawData(data: Data) -> [OfflineItem]? {
        let decoder = JSONDecoder()
        do {
            return try decoder.decode([OfflineItem].self, from: data)
        } catch {
            print (error)
        }
        return nil
    }
    
}
