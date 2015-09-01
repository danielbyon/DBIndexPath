//
//  DBIndexPathTests.swift
//  DBIndexPathTests
//
//  Created by Daniel Byon on 8/31/15.
//  Copyright © 2015 Daniel Byon. All rights reserved.
//

import Quick
import Nimble
@testable import DBIndexPath

class DBIndexPathTests: QuickSpec {
    
    override func spec() {
        describe("A DBIndexPath") {
            
            describe("initialized from integers") {
                it("should not be nil") {
                    let actual = DBIndexPath(section: 0, row: 0)
                    expect(actual).toNot(beNil())
                }
            }
            
            describe("initialized from NSIndexPath") {
                context("when valid") {
                    let indexPath = NSIndexPath(forItem: 0, inSection: 0)
                    
                    it("should not be nil") {
                        let actual = DBIndexPath(indexPath)
                        expect(actual).toNot(beNil())
                    }
                }
                
                context("when the index path has no indices") {
                    let indexPath = NSIndexPath()
                    
                    it("should be nil") {
                        let actual = DBIndexPath(indexPath)
                        expect(actual).to(beNil())
                    }
                }
                
                context("when the index path has one index") {
                    let indexPath = NSIndexPath(index: 0)
                    
                    it("should be nil") {
                        let actual = DBIndexPath(indexPath)
                        expect(actual).to(beNil())
                    }
                }
                
                context("when the index path has more than two indices") {
                    let indexPath = NSIndexPath(indexes: [1, 2, 3], length: 3)
                    
                    it("should be nil") {
                        let actual = DBIndexPath(indexPath)
                        expect(actual).to(beNil())
                    }
                }
            }
            
            describe("initialized from a String") {
                context("when the string is valid") {
                    context("and the path is 0,0") {
                        let string = "0,0"
                        
                        it("should not be nil") {
                            let actual = DBIndexPath(rawValue: string)
                            expect(actual).toNot(beNil())
                        }
                    }
                    
                    context("and the path is a pair of random integers") {
                        let string = "\(random()),\(random())"
                        
                        it("should not be nil") {
                            let actual = DBIndexPath(rawValue: string)
                            expect(actual).toNot(beNil())
                        }
                    }
                }
                
                context("when the string is empty") {
                    let string = ""
                    
                    it("should be nil") {
                        let actual = DBIndexPath(rawValue: string)
                        expect(actual).to(beNil())
                    }
                }
                
                context("when there is only one index") {
                    let string = "1"
                    
                    it("should be nil") {
                        let actual = DBIndexPath(rawValue: string)
                        expect(actual).to(beNil())
                    }
                }
                
                context("when there are more than two indices") {
                    let string = "1,2,3"
                    
                    it("should be nil") {
                        let actual = DBIndexPath(rawValue: string)
                        expect(actual).to(beNil())
                    }
                }
                
                context("when the string contains non-numeric characters") {
                    let string = "a,b"
                    
                    it("should be nil") {
                        let actual = DBIndexPath(rawValue: string)
                        expect(actual).to(beNil())
                    }
                }
                
                context("when the string does not use a comma separator") {
                    let string = "0.0"
                    
                    it("should be nil") {
                        let actual = DBIndexPath(rawValue: string)
                        expect(actual).to(beNil())
                    }
                }
                
                context("its rawValue") {
                    let expected = "1,2"
                    let indexPath = DBIndexPath(stringLiteral: expected)
                    
                    it("should be the same as what was passed in") {
                        let actual = indexPath.rawValue
                        expect(actual).to(equal(expected))
                    }
                }
                
            }
            
            describe("testing equality") {
                let lhs = DBIndexPath(section: 0, row: 0)
                
                context("to one created with the same section and row") {
                    it("should be equal") {
                        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
                        let rhs = DBIndexPath(indexPath)
                        expect(lhs).to(equal(rhs))
                    }
                    
                    it("should be equal") {
                        let rhs = DBIndexPath(section: 0, row: 0)
                        expect(lhs).to(equal(rhs))
                    }
                    
                    it("should be equal") {
                        let rhs = DBIndexPath(stringLiteral: "0,0")
                        expect(lhs).to(equal(rhs))
                    }
                }
                
                context("to one created with a different section") {
                    it("should not be equal") {
                        let indexPath = NSIndexPath(forRow: 0, inSection: 1)
                        let rhs = DBIndexPath(indexPath)
                        expect(lhs).toNot(equal(rhs))
                    }
                    
                    it("should not be equal") {
                        let rhs = DBIndexPath(section: 1, row: 0)
                        expect(lhs).toNot(equal(rhs))
                    }
                    
                    it("should not be equal") {
                        let rhs = DBIndexPath(stringLiteral: "1,0")
                        expect(lhs).toNot(equal(rhs))
                    }
                }
                
                context("to one created with a different row") {
                    it("should not be equal") {
                        let indexPath = NSIndexPath(forRow: 1, inSection: 0)
                        let rhs = DBIndexPath(indexPath)
                        expect(lhs).toNot(equal(rhs))
                    }
                    
                    it("should not be equal") {
                        let rhs = DBIndexPath(section: 0, row: 1)
                        expect(lhs).toNot(equal(rhs))
                    }
                    
                    it("should not be equal") {
                        let rhs = DBIndexPath(stringLiteral: "0,1")
                        expect(lhs).toNot(equal(rhs))
                    }
                }
                
                context("to one created with a different section and row") {
                    it("should not be equal") {
                        let indexPath = NSIndexPath(forRow: 1, inSection: 1)
                        let rhs = DBIndexPath(indexPath)
                        expect(lhs).toNot(equal(rhs))
                    }
                    
                    it("should not be equal") {
                        let rhs = DBIndexPath(section: 1, row: 1)
                        expect(lhs).toNot(equal(rhs))
                    }
                    
                    it("should not be equal") {
                        let rhs = DBIndexPath(stringLiteral: "1,1")
                        expect(lhs).toNot(equal(rhs))
                    }
                }
            }
            
        }
    }
    
}
