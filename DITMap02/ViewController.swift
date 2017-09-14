//
//  ViewController.swift
//  DITMap02
//
//  Created by D7702_10 on 2017. 8. 31..
//  Copyright © 2017년 D7702_10. All rights reserved.
//

import MapKit
import UIKit

class ViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var maps: MKMapView!
    
    var busG : CLLocationCoordinate2D!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //기본 표현
        
        // dit 35.165767, 129.072561
        let dits : CLLocationCoordinate2D = CLLocationCoordinate2DMake(35.165767, 129.072561)
        let lopark = CLLocationCoordinate2DMake(35.168406, 129.057834)
        
        // 반경 0.1 = 800
        let span = MKCoordinateSpanMake(0.05, 0.05)
        
        // 보여줄 영역
        let region = MKCoordinateRegionMake(dits, span)
        
        // 지도에 보여주기
        maps.setRegion(region, animated: true)
        
        /////////////////////////////////////////
        
        
        //함수 표현
        zoomToRegion()
        
        
        /////////////////////////////////////////
        
        // pin(annotaion) 꽂기
        let anno01 = MKPointAnnotation()
        anno01.coordinate = dits
        anno01.title = "Dit"
        anno01.subtitle = "동의과학대"
        
        let anno02 = MKPointAnnotation()
        anno02.coordinate = lopark
        anno02.title = "시민공원"
        anno02.subtitle = "포켓몬고"
        
        let anno03 = MKPointAnnotation()
        anno02.coordinate = busG
        anno02.title = "부산여대"
        anno02.subtitle = "여대다"
        
        let anns = ([anno01, anno02, anno03])
        maps.addAnnotations(anns)
        
        //자동선택
        maps.selectAnnotation(anno01, animated: true)
        
        //델리게이트 연결
        maps.delegate = self
    }
    
    func zoomToRegion(){
        //35.168657, 129.072813 부산여대
        busG = CLLocationCoordinate2DMake(35.168657, 129.072813)
        
    }
    
    //pin 딜리게이트
    public func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?{
        
        //pin의 재활용
        let iden = "mypin"
        var anno = maps.dequeueReusableAnnotationView(withIdentifier: iden) as? MKPinAnnotationView
        
        if anno == nil { //처음이면 실행
            anno = MKPinAnnotationView(annotation: annotation, reuseIdentifier: iden)
            
            anno?.canShowCallout = true
            
            if annotation.title! == "시민공원"{
                anno?.pinTintColor = UIColor.cyan
                //이미지 넣기
                let img = UIImageView(frame: CGRect(x: 0, y: 0, width: 53, height: 53))
                img.image = UIImage(named: "다운로드.jpeg")
                anno?.leftCalloutAccessoryView = img
            } else if annotation.title! == "Dit"{
                anno?.pinTintColor = UIColor.purple
                //이미지 넣기
                let img = UIImageView(frame: CGRect(x: 0, y: 0, width: 53, height: 53))
                img.image = UIImage(named: "unnamed.png")
                anno?.leftCalloutAccessoryView = img
            }
            
            anno?.animatesDrop = true
            
            // callout acceary
            let btn = UIButton(type: .detailDisclosure)
            anno?.rightCalloutAccessoryView = btn
            
            
        } else {
            // 제활용
            anno?.annotation = annotation
        }

    return anno
    }


    public func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl){
        
        //연결
        let vano = view.annotation
        //데이터 읽기
        let vtit : String = ((vano?.title)!)!
        let vsub : String = ((vano?.subtitle)!)!
        
        //알터 생성 .alter(가운데) .actionsheet(밑)
        let ac = UIAlertController(title: vtit, message: vsub, preferredStyle: .actionSheet)
        
        //ok생성
        ac.addAction(UIAlertAction(title: "OK", style: .destructive, handler: nil))
        
        //작동 됨
        present(ac, animated: true, completion: nil)
        
    }
}

