//
//  ConflictCardTable.swift
//  SpyCraft Utility Belt
//
//  Created by Alexander Scoggins on 10/16/16.
//  Copyright © 2016 Alexander Scroggins. All rights reserved.
//

import CoreData

public class ConflictCardTable: NSObject {
    
    /**
     This is so stupid but there are 8 rows for the first 18 cards and 7 thereafter, so this
     is going to be complicated...
     */
    func loadCrisisCardTableForFirstTime() {
        if let path = Bundle.main.path(forResource: "conflict_cards", ofType: "txt") {
            do {
                let mob = HSDatabaseManager.sharedInstance.mob
                let data = try String(contentsOfFile: path, encoding: .macOSRoman)
                let myStrings = data.components(separatedBy: .newlines)
                var numCreatedCards = 0
                let partsOfCard = NSMutableArray()
                for i in 0..<myStrings.count {
                    if myStrings[i] != "*" {
                        partsOfCard.add((myStrings[i]).trimmingCharacters(in: .whitespaces))
                    } else {
                        self.putTogetherCardPieces(cardParts: partsOfCard, mob: mob)
                        partsOfCard.removeAllObjects()
                        numCreatedCards += 1
                    }
                }
                // save models
                HSDatabaseManager.sharedInstance.save()
            } catch {
                print(error)
            }
        }
    }
    
    private func matches(for regex: String, in text: String) -> [String] {
        
        do {
            let regex = try NSRegularExpression(pattern: regex)
            let nsString = text as NSString
            let results = regex.matches(in: text, range: NSRange(location: 0, length: nsString.length))
            return results.map { nsString.substring(with: $0.range)}
        } catch let error {
            print("invalid regex: \(error.localizedDescription)")
            return []
        }
    }
    
    private func putTogetherCardPieces(cardParts: NSArray, mob: NSManagedObjectContext) {
        // The Name and Strategy are always first
        let name = cardParts[0] as? String
        let strategy = cardParts[1] as? String
        var desc: String?
        var skill: String?
        var requirements: String?
        var skillMod: String?
        var special: String?
        var duration: String?
        var advantages: String?
        // CrisisType is always the last value
        let crisisType = cardParts[cardParts.count-1] as? String
        
        for i in 0..<cardParts.count {
            if self.matches(for: "Skill: ", in: cardParts[i] as! String).count != 0 {
                skill = cardParts[i] as? String
            } else if self.matches(for: "Requirements: ", in: cardParts[i] as! String).count != 0 {
                requirements = cardParts[i] as? String
            } else if self.matches(for: "Skill Check Modifier: ", in: cardParts[i] as! String).count != 0 {
                skillMod = cardParts[i] as? String
            } else if self.matches(for: "Special: ", in: cardParts[i] as! String).count != 0 {
                special = cardParts[i] as? String
            } else if self.matches(for: "Description: ", in: cardParts[i] as! String).count != 0 {
                desc = (cardParts[i] as? String)?.replacingOccurrences(of: "Description: ", with: "")
            } else if self.matches(for: "Conflict Round Duration: ", in: cardParts[i] as! String).count != 0 {
                duration = cardParts[i] as? String
            } else if self.matches(for: "Advantages \\w*: ", in: cardParts[i] as! String).count != 0 {
                advantages = cardParts[i] as? String
            } else if i < cardParts.count-1 && i > 1{
                desc = cardParts[i] as? String
            }
        }
        
        _ = CrisisCard(context: mob,
                       name: name,
                       desc: desc,
                       strategy: strategy,
                       special: special,
                       skill: skill,
                       duration: duration,
                       requirements: requirements,
                       advantages: advantages,
                       skillmod: skillMod,
                       crisisType: crisisType)
    }
    
    private func getCrisisType(str: String) -> String? {
        if str == "BRAINWASHING" ||
            str == "CHASE" ||
            str == "HACKING" ||
            str == "INFILTRATION" ||
            str == "INTERROGATION" ||
            str == "MANHUNT" ||
            str == "SEDUCTION" {
            return str
        }
        return nil
    }
}
