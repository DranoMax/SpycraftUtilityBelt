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
        self.loadElectronicsGear()
    }
    
    func loadElectronicsGear() {
        if let path = Bundle.main.path(forResource: "gear_electronics", ofType: "txt") {
            do {
                let mob = HSDatabaseManager.sharedInstance.mob
                let data = try String(contentsOfFile: path, encoding: .macOSRoman)
                let myStrings = data.components(separatedBy: .newlines)
                for var i in 0..<myStrings.count {
                    // Starting a new group of a given Caliber
                    if myStrings[i] == "*" {
                        i += 1
                        self.currentCaliber = myStrings[i]
                    } else if myStrings[i] == "**" {
                        // TODO: Footer
                        continue
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
        if let name = mutStr.capturedGroups(withRegex: "(.*?)[\\d|-]").first {
            mutStr.replaceCharacters(in: NSRange(location: 0, length: name.characters.count), with: "")
            mutStr = NSMutableString(string: mutStr.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))
            electGear.name = name
        }
        
        // power rating
        if let pr = mutStr.capturedGroups(withRegex: "(\\S*)").first {
            mutStr.replaceCharacters(in: NSRange(location: 0, length: pr.characters.count), with: "")
            mutStr = NSMutableString(string: mutStr.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))
            electGear.powerRating = pr
        }
        
        // skill cap
        if let skillCap = mutStr.capturedGroups(withRegex: "(\\S*)").first {
            mutStr.replaceCharacters(in: NSRange(location: 0, length: skillCap.characters.count), with: "")
            mutStr = NSMutableString(string: mutStr.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))
            electGear.resultCapMod = skillCap
        }
        
        // range
        if let range = mutStr.capturedGroups(withRegex: "(.*?)[T|N|S|M|S|D|F|L|-]").first {
            if range != "" && range != " " {
                mutStr.replaceCharacters(in: NSRange(location: 0, length: range.characters.count), with: "")
                mutStr = NSMutableString(string: mutStr.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))
                electGear.range = range
            } else {
                if let rangeFirstMatch = mutStr.matches(for: "(.*?)[T|N|S|M|S|D|F|L|-]").first {
                    mutStr.replaceCharacters(in: NSRange(location: 0,
                                                         length: rangeFirstMatch.characters.count),
                                             with: "")
                    mutStr = NSMutableString(string: mutStr.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))
                    electGear.range = rangeFirstMatch
                }
            }
        }
        // size/hand
        if let szHand = mutStr.capturedGroups(withRegex: "(\\S*)").first {
            mutStr.replaceCharacters(in: NSRange(location: 0, length: szHand.characters.count), with: "")
            mutStr = NSMutableString(string: mutStr.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))
            electGear.sizeHand = szHand
        }
        
        // battery
        if let battery = mutStr.capturedGroups(withRegex: "(.*?)[+|-]").first {
            mutStr.replaceCharacters(in: NSRange(location: 0, length: battery.characters.count), with: "")
            mutStr = NSMutableString(string: mutStr.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))
            electGear.battery = battery
        }
        
        // save
        if let save = mutStr.capturedGroups(withRegex: "(\\S*)").first {
            mutStr.replaceCharacters(in: NSRange(location: 0, length: save.characters.count), with: "")
            mutStr = NSMutableString(string: mutStr.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))
            electGear.save = save
        }
        
        // weight
        if let weight = mutStr.capturedGroups(withRegex: "(\\S*)").first {
            mutStr.replaceCharacters(in: NSRange(location: 0, length: weight.characters.count), with: "")
            mutStr = NSMutableString(string: mutStr.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))
            electGear.weight = weight
        }
        
        // complexity
        if let complexity = mutStr.capturedGroups(withRegex: "(\\S*)").first {
            mutStr.replaceCharacters(in: NSRange(location: 0, length: complexity.characters.count), with: "")
            mutStr = NSMutableString(string: mutStr.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))
            electGear.complexity = complexity
        }
        
        // year
        if let year = mutStr.capturedGroups(withRegex: "(\\S*)").first {
            mutStr.replaceCharacters(in: NSRange(location: 0, length: year.characters.count), with: "")
            mutStr = NSMutableString(string: mutStr.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))
            electGear.year = year
        }
        
        // street value
        if let streetValue = mutStr.capturedGroups(withRegex: "(\\S*)").first {
            mutStr.replaceCharacters(in: NSRange(location: 0, length: streetValue.characters.count), with: "")
            mutStr = NSMutableString(string: mutStr.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))
            electGear.streetValue = streetValue
        }
        
        
               //        _ = CrisisCard(context: mob,
        //                       name: name,
        //                       desc: desc,
        //                       strategy: strategy,
        //                       special: special,
        //                       skill: skill,
        //                       duration: duration,
        //                       requirements: requirements,
        //                       advantages: advantages,
        //                       skillmod: skillMod,
        //                       crisisType: crisisType)
    }
}
