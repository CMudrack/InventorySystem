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
    var cameraCaptureOutput: AVCaptureMetadataOutput?
    var qrCodeFrameView: UIView?
    
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
            cameraCaptureOutput = AVCaptureMetadataOutput()
            captureSession.addInput(cameraCaptureInput)
            captureSession.addOutput(cameraCaptureOutput!)
            
            cameraCaptureOutput?.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            cameraCaptureOutput?.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
        } catch {
            print(error.localizedDescription)
        }
        
         // Initialize QR Code Frame to highlight the QR code
         qrCodeFrameView = UIView()

         if let qrCodeFrameView = qrCodeFrameView {
             qrCodeFrameView.layer.borderColor = UIColor.green.cgColor
             qrCodeFrameView.layer.borderWidth = 2
             view.addSubview(qrCodeFrameView)
             view.bringSubviewToFront(qrCodeFrameView)
         }
        
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        videoPreviewLayer?.frame = view.bounds
        videoPreviewLayer?.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
        view.layer.insertSublayer(videoPreviewLayer!, at: 0)
        captureSession.startRunning()
    }
    
    // Got function from https://www.appcoda.com/intermediate-swift-tips/qrcode-reader.html
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        // Check if the metadataObjects array is not nil and it contains at least one object.
        if metadataObjects.count == 0 {
            qrCodeFrameView?.frame = CGRect.zero
            return
        }

        // Get the metadata object.
        let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        
        // Counter to ensure qrCode variable only gets set once
        
        if metadataObj.type == AVMetadataObject.ObjectType.qr {
            // If the found metadata is equal to the QR code metadata then update the status label's text and set the bounds
            let barCodeObject = videoPreviewLayer?.transformedMetadataObject(for: metadataObj)
            qrCodeFrameView?.frame = barCodeObject!.bounds
            
            
            DataStore.sharedInstance.qrCodeInput = metadataObj.stringValue!
            _ = navigationController?.popViewController(animated: true)
        }
    }
}
