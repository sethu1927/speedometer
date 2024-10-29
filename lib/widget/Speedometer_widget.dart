import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:segment_display/segment_display.dart';
import 'package:speedmeter/providers/Speedometer_provider.dart';

class Speedometer extends StatelessWidget{
  @override
  Widget build(BuildContext context) {


    final ProviderData = Provider.of<SpeedometerProvider>(context);
    ProviderData.getSpeedUpdates();


  return Scaffold(

    appBar: AppBar(
      title: Text(" Speed-o-meter ",
      style: Theme.of(context).textTheme.bodyLarge,
      ),centerTitle: true,

    ),

    body: SingleChildScrollView(
      child: Column(
        children: [

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Column(
                children: [
                  Text ("Current Speed", style: Theme.of(context).textTheme.bodyLarge,),
                  SevenSegmentDisplay(
                    value:
                      "${ProviderData.speedometer.currentSpeed.toStringAsFixed(2)}",
                    size: 8,
                    backgroundColor: Colors.white,
                    segmentStyle: HexSegmentStyle(
                        enabledColor: Colors.blue,
                        disabledColor: Colors.white
                    ),
                  ),

                  Text ("Kmh", style: Theme.of(context).textTheme.bodyLarge,),


                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Column(
                children: [
                  Text ("From 10 to 30", style: Theme.of(context).textTheme.bodyLarge,),
                  SevenSegmentDisplay(value: "${ProviderData.speedometer.time10_30}",
                  size: 10, backgroundColor: Colors.white,
                  segmentStyle: HexSegmentStyle(
                    enabledColor: Colors.blue,
                    disabledColor: Colors.white
                  ),
                  ),


                  Text ("Seconds", style: Theme.of(context).textTheme.bodyLarge,),


                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Column(
                children: [
                  Text (" From 30 to 10", style: Theme.of(context).textTheme.bodyLarge,),
                  //here Seven sergment Display will be provided .
                  SevenSegmentDisplay(value: '${ProviderData.speedometer.time30_10}',
                    size: 10,
                    backgroundColor: Colors.white,
                    segmentStyle: HexSegmentStyle(
                        enabledColor: Colors.blue,
                        disabledColor: Colors.white
                    ),
                  ),
                  Text ("Seconds", style: Theme.of(context).textTheme.bodyLarge,),


                ],
              ),
            ),
          ),




        ],

      ),


    ),




  );
  }

}