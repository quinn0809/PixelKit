//
//  FeedbackPIX.swift
//  Pixels
//
//  Created by Hexagons on 2018-08-21.
//  Copyright © 2018 Hexagons. All rights reserved.
//

import CoreGraphics
import Metal

public class FeedbackPIX: PIXSingleEffect, PIXofaKind {
    var kind: PIX.Kind = .feedback
    
    override open var shader: String { return "nilPIX" }
    
    var feedTexture: MTLTexture? {
        return feedPix?.texture
    }
    
    public var feedActive: Bool = true { didSet { setNeedsRender() } }
    public var feedPix: (PIX & PIXOut)? { didSet { if feedActive { setNeedsRender() } } }
    var readyToFeed: Bool = false
    var feedReset: Bool = false

    public override required init() {
        super.init()
    }
    
    override public func didRender(texture: MTLTexture, force: Bool) {
        super.didRender(texture: texture)
        if feedReset {
            feedActive = true
            feedReset = false
        }
        readyToFeed = true
        setNeedsRender()
//        switch pixels.renderMode {
//        case .frameLoop:
//            setNeedsRender()
//        case .direct:
//            pixels.delay(frames: 1, done: {
//                self.setNeedsRender()
//            })
//        }
    }
    
    public func resetFeed() {
        guard feedActive else {
            pixels.log(pix: self, .info, .effect, "Feedback reset; feed not active.")
            return
        }
        feedActive = false
        feedReset = true
        setNeedsRender()
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
    
}
