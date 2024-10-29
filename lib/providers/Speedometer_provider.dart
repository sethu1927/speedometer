
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:speedmeter/models/speedometer_model.dart';
import 'package:location/location.dart' hide LocationAccuracy;


class  SpeedometerProvider with ChangeNotifier{

  Speedometer _speedometer = new  Speedometer(time10_30: 0, time30_10: 0, currentSpeed: 0);

  Speedometer get speedometer => _speedometer;
  Stopwatch _stopwatch = Stopwatch();

  final Geolocator _geolocator= Geolocator();

  // location access and permission

  Future<bool> checkLocationServiceAndPermissionStatus() async{

    Location location = new Location();
    bool _isLoationServiceEnabled;
    PermissionStatus _permissionGranted;

    // enable location

    _isLoationServiceEnabled = await location.serviceEnabled();
    if(!_isLoationServiceEnabled){
      _isLoationServiceEnabled = await location.requestService();
      if(!_isLoationServiceEnabled){
        Fluttertoast.showToast(msg: 'car Speedometer required enabling the location to measure the speed ', toastLength: Toast.LENGTH_LONG,
          fontSize: 16,
          textColor: Colors.white,
          timeInSecForIosWeb: 2,

        );
      }

    }

    _permissionGranted =  await location.hasPermission();
    if( _permissionGranted == PermissionStatus.denied){
      _permissionGranted= await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted){
        Fluttertoast.showToast(msg: 'car Speedometer required enabling the location to measure the speed ', toastLength: Toast.LENGTH_LONG,
          fontSize: 16,
          textColor: Colors.white,
          timeInSecForIosWeb: 2,

        );
      }
    }

    return _isLoationServiceEnabled && _permissionGranted == PermissionStatus.granted;
  }


// method to update the current speed according to the vehicle position
void updateSpeed( Position position){
  //convert to kms
    double speed = (position.speed)* 3.6;
   _speedometer.currentSpeed = speed;


   if (speed >= SPEED_10 || speed <= SPEED_30){
     WhileInRange(speed);
   }
    if (speed < SPEED_10 || speed > SPEED_30){
      OutInRange(speed);
    }

    print('Current speed is : ' +speed.toString());
    print(' time10_30 is : '+ speedometer.time10_30.toString());
    print(' time10_30 is : '+ speedometer.time30_10.toString());

    notifyListeners();
  }


  void WhileInRange( double VehicleSpeed) {
    if (VehicleSpeed >= SPEED_10) {
      //vehicle speed less than 10 KMH
      if (speedometer.range == LESS_10) {
        speedometer.range = FROM_10_TO_30;
        _stopwatch.start();
        speedometer.time30_10 = _stopwatch.elapsed.inSeconds;
      }
      //in range 10 to 30 and update on screen
      else if (speedometer.range == FROM_10_TO_30) {
        speedometer.time10_30 = _stopwatch.elapsed.inSeconds;
      }
    }
    if (VehicleSpeed <= SPEED_30) {
      // vehicle speed more than 30 KMH
      if (speedometer.range == OVER_30) {
        speedometer.range == FROM_30_TO_10;
        _stopwatch.start();
        speedometer.time30_10 = _stopwatch.elapsed.inSeconds;
      }
      //in range 30 to 10
      else if (speedometer.range == FROM_30_TO_10) {
        speedometer.time30_10 = _stopwatch.elapsed.inSeconds;
      }
    }
  }


    void OutInRange( double VehicleSpeed){

      if ( VehicleSpeed< SPEED_10){
        if( speedometer.range == FROM_30_TO_10){
          speedometer.range = LESS_10;
          _stopwatch.stop();
          //to update the time accprdingly

          speedometer.time30_10 =_stopwatch.elapsed.inSeconds;
          _stopwatch.reset();
        }
        else if (speedometer.range == FROM_10_TO_30){
          speedometer.range = LESS_10;

          _stopwatch.reset();
          speedometer.time10_30=  _stopwatch.elapsed.inSeconds;
        }
      }


      if( VehicleSpeed > SPEED_30){
        if(speedometer.range == FROM_10_TO_30){
          speedometer.range = OVER_30;
          _stopwatch.stop();

          speedometer.time10_30 = _stopwatch.elapsed.inSeconds;
          _stopwatch.reset();
        }
        else if( speedometer.range == FROM_30_TO_10){
          speedometer.range = OVER_30;
          _stopwatch.reset();
          speedometer.time30_10 = _stopwatch.elapsed.inSeconds;

        }
      }
    }


  getSpeedUpdates() async {
    if ( await  checkLocationServiceAndPermissionStatus()){
      LocationSettings options = LocationSettings(
      distanceFilter: 8,
      accuracy: LocationAccuracy.high,
      );

      Geolocator.getPositionStream(locationSettings: options).listen((Position){
          updateSpeed(Position);
      });
    }
  }

}