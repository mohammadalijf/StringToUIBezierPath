//
//  String.swift
//  
//
//  Created by Mohammad Ali Jafarian on 10/6/17.
//

import UIKit

extension String {
    func bezierPath(withFont font: UIFont) -> UIBezierPath {
        // create CTFont with UIFont
        let ctFont = CTFontCreateWithName(font.fontName as CFString,
                                          font.pointSize, nil)
        // create a container CGMutablePath for letter paths
        let letters = CGMutablePath()
        // create a NSAttributedString from self
        let attrString = NSAttributedString(string: self,
                                            attributes: [.font: font])
        // get CTLines from attributed string
        let line = CTLineCreateWithAttributedString(attrString)
        // get CTRuns from line
        let runs = CTLineGetGlyphRuns(line) as! [CTRun]
        for run in runs {
            // number of gylph available
            let  glyphCount = CTRunGetGlyphCount(run)
            for i in 0 ..< glyphCount {
                // take one glyph from run
                let range = CFRangeMake(i, 1)
                // create array to hold glyphs, this should have array with one item
                var glyphs = [CGGlyph](repeating: 0,
                                       count: range.length)
                // create position holder
                var position = CGPoint()
                // get glyph
                CTRunGetGlyphs(run,
                               range,
                               &glyphs)
                // glyph postion
                CTRunGetPositions(run,
                                  range,
                                  &position)
                // append glyph path to letters
                for glyph in glyphs {
                    if let letter = CTFontCreatePathForGlyph(ctFont, glyph, nil) {
                        letters.addPath(letter, transform: CGAffineTransform(translationX: position.x, y: position.y))
                    }
                }

            }
        }
        // following lines normalize path. this path is created with textMatrix so it should first be normalized to nomral matrix
        let lettersRotated = CGMutablePath()
        lettersRotated.addPath(letters, transform: CGAffineTransform(scaleX: 1, y: -1))
        let lettersMoved = CGMutablePath()
        lettersMoved.addPath(lettersRotated, transform: CGAffineTransform(translationX: 0, y: lettersRotated.boundingBoxOfPath.size.height))
        // create UIBezierPath
        let bezier = UIBezierPath(cgPath: lettersMoved)
        return bezier
    }
}
