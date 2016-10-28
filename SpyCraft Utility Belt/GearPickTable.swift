//
//  ConflictCardTable.swift
//  SpyCraft Utility Belt
//
//  Created by Alexander Scoggins on 10/16/16.
//  Copyright © 2016 Alexander Scroggins. All rights reserved.
//

import CoreData

public class GearPickTable: NSObject {
    
    // The current caliber of gear we're parsing through
    var currentCaliber = ""
    
    // The current type of gear being loaded - used for sorting
    var currentGearType = ""
    
    func loadGearPickTablesForFirstTime() {
        self.loadGearFromFile(fileName: "gear_electronics")
        self.loadGearFromFile(fileName: "gear_mechanisms")
        self.loadGearFromFile(fileName: "gear_security")
        self.loadGearFromFile(fileName: "gear_tradecraft")
    }
    
    func loadGearFromFile(fileName: String) {
        if let path = Bundle.main.path(forResource: fileName, ofType: "txt") {
            do {
                let mob = HSDatabaseManager.sharedInstance.mob
                let data = try String(contentsOfFile: path, encoding: .utf8)
                let myStrings = data.components(separatedBy: .newlines)
                
                self.currentGearType = myStrings[0]
                
                // Swift 3.0 removed the conventional for loop...not sure how to do the following
                // without that so I'm using a while loop in the meantime >_>
                var count = 1
                while count < myStrings.count {
                    // Starting a new group of a given Caliber
                    if myStrings[count] == "*" {
                        count += 1
                        self.currentCaliber = myStrings[count]
                    } else if myStrings[count] == "**" {
                        // TODO: Footer
                        break
                    } else {
                        self.putTogetherCardPieces(str: myStrings[count], gearType: fileName, mob: mob)
                    }
                    count += 1
                }
        
                // save models
                HSDatabaseManager.sharedInstance.save()
            } catch {
                print(error)
            }
        }
    }
    
    private func putTogetherCardPieces(str: String, gearType: String, mob: NSManagedObjectContext) {
        //Name PR Cap Rng SZ/Hand Battery Save Weight Comp Year Street Value
        
        let standardGearModel = StandardGearModels(
            context: mob,
            name: "",
            caliber: self.currentCaliber,
            gearType: self.currentGearType,
            powerRating: "",
            resultCapMod: "",
            range: "",
            sizeHand: "",
            battery: "",
            save: "",
            weight: "",
            complexity: "",
            year: "",
            streetValue: "")
        
        
        var mutStr = NSMutableString(string: str)
        
        // name
        // There are special casses where the pick is actually two pics of a lower caliber...handling
        // that here...
        if let name = mutStr.matches(for: "^Any[^—|∆]*").first {
            standardGearModel.name = name
            return
        }
        
        // Also a case where it directs reader to a given page
        if let _ = mutStr.matches(for: "see Table").first {
            standardGearModel.name = mutStr as String
            return
        }
        
        if let name = mutStr.capturedGroups(withRegex: "(.*?)[\\d|∆|—]").first {
            mutStr.replaceCharacters(in: NSRange(location: 0, length: name.characters.count), with: "")
            mutStr = NSMutableString(string: mutStr.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))
            standardGearModel.name = name.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
        
        // power rating
        if let pr = mutStr.capturedGroups(withRegex: "(\\S*)").first {
            mutStr.replaceCharacters(in: NSRange(location: 0, length: pr.characters.count), with: "")
            mutStr = NSMutableString(string: mutStr.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))
            standardGearModel.powerRating = pr.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
        
        // skill cap
        if let skillCap = mutStr.capturedGroups(withRegex: "(\\S*)").first {
            mutStr.replaceCharacters(in: NSRange(location: 0, length: skillCap.characters.count), with: "")
            mutStr = NSMutableString(string: mutStr.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))
            standardGearModel.resultCapMod = skillCap.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
        
        // range
        if let range = mutStr.capturedGroups(withRegex: "(.*?)[T|N|S|M|S|D|F|L|—]").first {
            if range != "" && range != " " {
                mutStr.replaceCharacters(in: NSRange(location: 0, length: range.characters.count), with: "")
                mutStr = NSMutableString(string: mutStr.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))
                standardGearModel.range = range.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            } else {
                if let rangeFirstMatch = mutStr.matches(for: "(.*?)[T|N|S|M|S|D|F|L|—]").first {
                    mutStr.replaceCharacters(in: NSRange(location: 0,
                                                         length: rangeFirstMatch.characters.count),
                                             with: "")
                    mutStr = NSMutableString(string: mutStr.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))
                    standardGearModel.range = rangeFirstMatch.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                }
            }
        }
        // size/hand
        if let szHand = mutStr.capturedGroups(withRegex: "(\\S*)").first {
            mutStr.replaceCharacters(in: NSRange(location: 0, length: szHand.characters.count), with: "")
            mutStr = NSMutableString(string: mutStr.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))
            standardGearModel.sizeHand = szHand.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
        
        // battery
        if let battery = mutStr.capturedGroups(withRegex: "(.*?)[+|—]").first {
            mutStr.replaceCharacters(in: NSRange(location: 0, length: battery.characters.count), with: "")
            mutStr = NSMutableString(string: mutStr.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))
            standardGearModel.battery = battery.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
        
        // save
        if let save = mutStr.capturedGroups(withRegex: "(\\S*)").first {
            mutStr.replaceCharacters(in: NSRange(location: 0, length: save.characters.count), with: "")
            mutStr = NSMutableString(string: mutStr.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))
            standardGearModel.save = save.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
        
        // weight
        if let weight = mutStr.capturedGroups(withRegex: "(\\S*)").first {
            mutStr.replaceCharacters(in: NSRange(location: 0, length: weight.characters.count), with: "")
            mutStr = NSMutableString(string: mutStr.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))
            standardGearModel.weight = weight.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
        
        // complexity
        if let complexity = mutStr.capturedGroups(withRegex: "(\\S*)").first {
            mutStr.replaceCharacters(in: NSRange(location: 0, length: complexity.characters.count), with: "")
            mutStr = NSMutableString(string: mutStr.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))
            standardGearModel.complexity = complexity.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
        
        // year
        if let year = mutStr.capturedGroups(withRegex: "(\\S*)").first {
            mutStr.replaceCharacters(in: NSRange(location: 0, length: year.characters.count), with: "")
            mutStr = NSMutableString(string: mutStr.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))
            standardGearModel.year = year.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
        
        // street value
        if let streetValue = mutStr.capturedGroups(withRegex: "(\\S*)").first {
            mutStr.replaceCharacters(in: NSRange(location: 0, length: streetValue.characters.count), with: "")
            mutStr = NSMutableString(string: mutStr.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))
            standardGearModel.streetValue = streetValue.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
}
