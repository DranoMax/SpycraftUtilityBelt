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
    var currentCaliber: String!
    
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
                for var i in 0..<myStrings.count {
                    // Starting a new group of a given Caliber
                    if myStrings[i] == "*" {
                        i += 1
                        self.currentCaliber = myStrings[i]
                    } else if myStrings[i] == "**" {
                        // TODO: Footer
                        break
                    } else {
                        self.putTogetherCardPieces(str: myStrings[i], mob: mob)
                    }
                }
                // save models
                HSDatabaseManager.sharedInstance.save()
            } catch {
                print(error)
            }
        }
    }
    
    private func putTogetherCardPieces(str: String, mob: NSManagedObjectContext) {
        //Name PR Cap Rng SZ/Hand Battery Save Weight Comp Year Street Value
        
        let electGear = ElectronicsGear(context: mob,
                            name: "",
                            caliber: self.currentCaliber,
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
        if let name = mutStr.matches(for: "^Any[^—]*").first {
            electGear.name = name
            return
        }
        
        // Also a case where it directs reader to a given page
        if let _ = mutStr.matches(for: "see Table").first {
            electGear.name = mutStr as String
            return
        }
        
        if let name = mutStr.capturedGroups(withRegex: "(.*?)[\\d|∆|—]").first {
            mutStr.replaceCharacters(in: NSRange(location: 0, length: name.characters.count), with: "")
            mutStr = NSMutableString(string: mutStr.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))
            electGear.name = name.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
        
        // power rating
        if let pr = mutStr.capturedGroups(withRegex: "(\\S*)").first {
            mutStr.replaceCharacters(in: NSRange(location: 0, length: pr.characters.count), with: "")
            mutStr = NSMutableString(string: mutStr.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))
            electGear.powerRating = pr.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
        
        // skill cap
        if let skillCap = mutStr.capturedGroups(withRegex: "(\\S*)").first {
            mutStr.replaceCharacters(in: NSRange(location: 0, length: skillCap.characters.count), with: "")
            mutStr = NSMutableString(string: mutStr.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))
            electGear.resultCapMod = skillCap.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
        
        // range
        if let range = mutStr.capturedGroups(withRegex: "(.*?)[T|N|S|M|S|D|F|L|—]").first {
            if range != "" && range != " " {
                mutStr.replaceCharacters(in: NSRange(location: 0, length: range.characters.count), with: "")
                mutStr = NSMutableString(string: mutStr.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))
                electGear.range = range.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            } else {
                if let rangeFirstMatch = mutStr.matches(for: "(.*?)[T|N|S|M|S|D|F|L|—]").first {
                    mutStr.replaceCharacters(in: NSRange(location: 0,
                                                         length: rangeFirstMatch.characters.count),
                                             with: "")
                    mutStr = NSMutableString(string: mutStr.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))
                    electGear.range = rangeFirstMatch.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                }
            }
        }
        // size/hand
        if let szHand = mutStr.capturedGroups(withRegex: "(\\S*)").first {
            mutStr.replaceCharacters(in: NSRange(location: 0, length: szHand.characters.count), with: "")
            mutStr = NSMutableString(string: mutStr.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))
            electGear.sizeHand = szHand.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
        
        // battery
        if let battery = mutStr.capturedGroups(withRegex: "(.*?)[+|—]").first {
            mutStr.replaceCharacters(in: NSRange(location: 0, length: battery.characters.count), with: "")
            mutStr = NSMutableString(string: mutStr.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))
            electGear.battery = battery.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
        
        // save
        if let save = mutStr.capturedGroups(withRegex: "(\\S*)").first {
            mutStr.replaceCharacters(in: NSRange(location: 0, length: save.characters.count), with: "")
            mutStr = NSMutableString(string: mutStr.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))
            electGear.save = save.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
        
        // weight
        if let weight = mutStr.capturedGroups(withRegex: "(\\S*)").first {
            mutStr.replaceCharacters(in: NSRange(location: 0, length: weight.characters.count), with: "")
            mutStr = NSMutableString(string: mutStr.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))
            electGear.weight = weight.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
        
        // complexity
        if let complexity = mutStr.capturedGroups(withRegex: "(\\S*)").first {
            mutStr.replaceCharacters(in: NSRange(location: 0, length: complexity.characters.count), with: "")
            mutStr = NSMutableString(string: mutStr.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))
            electGear.complexity = complexity.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
        
        // year
        if let year = mutStr.capturedGroups(withRegex: "(\\S*)").first {
            mutStr.replaceCharacters(in: NSRange(location: 0, length: year.characters.count), with: "")
            mutStr = NSMutableString(string: mutStr.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))
            electGear.year = year.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
        
        // street value
        if let streetValue = mutStr.capturedGroups(withRegex: "(\\S*)").first {
            mutStr.replaceCharacters(in: NSRange(location: 0, length: streetValue.characters.count), with: "")
            mutStr = NSMutableString(string: mutStr.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))
            electGear.streetValue = streetValue.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
}
