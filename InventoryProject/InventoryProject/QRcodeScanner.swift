//
//  QRcodeScanner.swift
//  InventoryProject
//
//  Created by Cody Mudrack on 10/13/19.
//  Copyright © 2019 Cody Mudrack. All rights reserved.
//

// This website helped me with this portion of the code: https://developer.apple.com/documentation/avfoundation/cameras_and_media_capture/avcam_building_a_camera_app

import UIKit
import AVFoundation

class QRcodeScanner: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    var captureSession = AVCaptureSession()
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    var camera: AVCaptureDevice?
    var cameraCaptureOutput: AVCapturePhotoOutput?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //check for authorization
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized: // The user has previously granted access to the camera.
            self.setupCaptureSession()
            
        case .notDetermined: // The user has not yet been asked for camera access.
            AVCaptureDevice.requestAccess(for: .video) { granted in
                if granted {
                    self.setupCaptureSession()
                }
            }
            
        case .denied: // The user has previously denied access.
            return
            
        case .restricted: // The user can't grant access due to restrictions.
            return
            
        default:
            return
            
        }
        
    }
    
    
    func setupCaptureSession() {
        captureSession.sessionPreset = AVCaptureSession.Preset.high
        camera = AVCaptureDevice.default(for: .video)
        
        do{
            let cameraCaptureInput = try AVCaptureDeviceInput(device: camera!)
                cameraCaptureOutput = AVCapturePhotoOutput()
            
            captureSession.addInput(cameraCaptureInput)
            captureSession.addOutput(cameraCaptureOutput!)
        } catch {
            print(error.localizedDescription)
        }
        
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        videoPreviewLayer?.frame = view.bounds
        videoPreviewLayer?.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
        view.layer.insertSublayer(videoPreviewLayer!, at: 0)
        captureSession.startRunning()
    }
    
}
