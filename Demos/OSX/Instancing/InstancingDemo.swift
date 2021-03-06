//
//  InstancingDemo.swift
//  MetalSwift
//
//  Created by Dustin on 2/22/16.
//  Copyright © 2016 none. All rights reserved.
//

#if os(OSX)
    import AppKit
#elseif os(iOS)
    import UIKit
#endif

import MetalKit



class InstancingDemo : DemoBase {
    
    var metalRenderer : MetalRenderer! = nil
        
    //-----------------------------------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupMTKView()
        
        self.setMultiBufferMode(.TripleBuffer)
        
        let metalRenderDescriptor = MetalRenderDescriptor(
            device: device,
            shaderLibrary: defaultShaderLibrary,
            sampleCount: mtkView.sampleCount,
            colorPixelFormat: mtkView.colorPixelFormat,
            depthStencilPixelFormat: mtkView.depthStencilPixelFormat,
            stencilAttachmentPixelFormat: mtkView.depthStencilPixelFormat,
            framebufferWidth: Int(mtkView.drawableSize.width),
            framebufferHeight: Int(mtkView.drawableSize.height),
            numBufferedFrames: self.numBufferedFrames
        )
        metalRenderer = MetalRenderer(descriptor: metalRenderDescriptor)
    }
    
    //-----------------------------------------------------------------------------------
    private func setupMTKView() {
        mtkView.sampleCount = 4
        mtkView.colorPixelFormat = MTLPixelFormat.BGRA8Unorm_sRGB
        mtkView.depthStencilPixelFormat = MTLPixelFormat.Depth32Float_Stencil8
        mtkView.framebufferOnly = true
    }
    
    //-----------------------------------------------------------------------------------
    override func viewSizeChanged (
            view: MTKView,
            newSize: CGSize
    ) {
        metalRenderer.reshape(newSize)
    }
    
    //-----------------------------------------------------------------------------------
    override func draw(commandBuffer : MTLCommandBuffer) {
        metalRenderer.render(
            commandBuffer,
            renderPassDescriptor: mtkView.currentRenderPassDescriptor!
        )
    }
    
}
