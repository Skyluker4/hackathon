//
//  ViewController.swift
//  Hackathon
//
//  Created by Ogden Wells on 11/19/21.
//

import AVFoundation
import UIKit
import CoreML
import Vision

class ViewController: UIViewController, AVCapturePhotoCaptureDelegate {
    //Buttons
    //Capture Session

    @IBOutlet weak var previewView: UIView!
    var captureSession: AVCaptureSession?
    //Photo Output
    let output = AVCapturePhotoOutput()
    //Video Preview
    let previewLayer = AVCaptureVideoPreviewLayer()
    //Shutter Button
    var stillImageOutput: AVCapturePhotoOutput!
    @IBOutlet weak var shutterButton: UIButton!

    var videoPreviewLayer: AVCaptureVideoPreviewLayer!
    
    // Stuff for the AI data
    var imageToShow: UIImage!
    var resultsToSend: [VNClassificationObservation]!

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        // Request access to camera if not granted
        AVCaptureDevice.requestAccess(for: AVMediaType.video) { response in
            if response {
                // Go ahead and set the camera up
                DispatchQueue.main.async { [self] in
                    setupCamera()
                }
            } else {
                // TODO: Leave instructions and a button for the user to request later
            }
        }
    }

    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        // Stop the camera
        if captureSession != nil {
            captureSession!.stopRunning()
        }

    }

    
    @IBAction func buttonPressed(_ sender: Any) {
        let photoCaptureSettings = AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])
        if stillImageOutput != nil {
            stillImageOutput.capturePhoto(with: photoCaptureSettings, delegate: self)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        previewLayer.frame = view.bounds
        
        shutterButton.center = CGPoint(x: view.frame.size.width/2, y: view.frame.size.height - 200)
    }
    
    private func checkCameraPermissions() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        
        case .notDetermined:
            //request
            AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
                guard granted else{
                    return
                }
                DispatchQueue.main.async {
                    self?.setupCamera()
                }
            }
        case .restricted:
            break
        case .denied:
            break
        case .authorized:
            self.setupCamera()
        @unknown default:
            break
        
        }
    }
    
    func setupLivePreview() {
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)

        videoPreviewLayer.videoGravity = .resizeAspectFill
        videoPreviewLayer.connection?.videoOrientation = .portrait

        previewView.layer.addSublayer(videoPreviewLayer)

        // Run all the stuff
        DispatchQueue.global(qos: .userInitiated).async { [self] in
            captureSession!.startRunning()
            DispatchQueue.main.async {
                videoPreviewLayer.frame = previewView.bounds
            }
        }
    }
    
    func setupCamera() {
        // Set up camera settings
        captureSession = AVCaptureSession()
        captureSession?.sessionPreset = .high

        guard let backCamera = AVCaptureDevice.default(for: AVMediaType.video)
        else {
            print("Unable to access back camera!")
            return
        }

        do {
            let input = try AVCaptureDeviceInput(device: backCamera)
            stillImageOutput = AVCapturePhotoOutput()

            if captureSession!.canAddInput(input) && captureSession!.canAddOutput(stillImageOutput) {
                captureSession!.addInput(input)
                captureSession!.addOutput(stillImageOutput)
                setupLivePreview()
            }
        }
        catch let error  {
            print("Error Unable to initialize back camera:  \(error.localizedDescription)")
        }
    }

    // Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Result
        if segue.destination is ResultsView {
            let vc = segue.destination as? ResultsView
            vc?.image = imageToShow
            vc?.results = resultsToSend
        }
        //super.prepare(for: segue, sender: sender)
    }
    
    // Delegate for when a photo is saved
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard let image = photo.fileDataRepresentation()
        else { return }

        analyzeImage(uiImage: UIImage(data: image)!)
    }
    
    // Function to run the AI on the image
    func analyzeImage(uiImage: UIImage) {
        
        // Analyze the image
        guard let model = try? VNCoreMLModel(for: SignModel().model)
        else {return}
        let request = VNCoreMLRequest(model: model)
        { [self](finishedRequest, error) in
            guard let results = finishedRequest.results as?
                    [VNClassificationObservation] else {return}

            // Show results
            imageToShow = uiImage
            resultsToSend = results
            performSegue(withIdentifier: "PresentResult", sender: self)
        }

        try? VNImageRequestHandler(cgImage: (uiImage.cgImage)!, options: [:]).perform([request])
    }
    
    
}
