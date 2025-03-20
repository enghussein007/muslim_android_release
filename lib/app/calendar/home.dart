import 'dart:async';
import 'dart:math';
import 'package:calendar/app/qiblah/qiblah_screen.dart';
import 'package:calendar/app/shared/network/remote/location_service.dart';
import 'package:calendar/app/shared/constants/proverb.dart';
import 'package:calendar/app/shared/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:jhijri/_src/_jHijri.dart';
import 'package:adhan/adhan.dart';
import '../azkar/azkar_screen.dart';
import '../radio_screen.dart';
import '../sebha/sebha_screen.dart';
import '../shared/styles/colors.dart';
class HomeScreeen extends StatefulWidget {
     HomeScreeen({super.key});

  @override
  State<HomeScreeen> createState() => _HomeScreeenState();
}

class _HomeScreeenState extends State<HomeScreeen> {
  late JHijri jh;
  late final prayerTimes;
  late final proverb;
  String timeString = '';


  void adhan() {

    //final myCoordinates = Coordinates(30.796310,31.624430 ); // Replace with your own location lat, lng.
    final myCoordinates = Coordinates(AuthServices.cl!.latitude,AuthServices.cl!.longitude );
    final params = CalculationMethod.egyptian.getParameters();
    params.madhab = Madhab.shafi;
     prayerTimes = PrayerTimes.today(myCoordinates, params);
    // print('My Prayer Times');
    // print("---Today's Prayer Times in Your Local Timezone(${prayerTimes.fajr.timeZoneName})---");
    //  print(prayerTimes.fajr.toString().substring(11,19));
    // print(prayerTimes.sunrise.toString().substring(11,19));
    // print(prayerTimes.dhuhr.toString().substring(11,19));
    // print(prayerTimes.asr.toString().substring(11,19));
    // print(prayerTimes.maghrib.toString().substring(11,19));
    // print(prayerTimes.isha.toString().substring(11,19));
    // print('---');

  }
  String randomProverb() {
    Random random = Random();
    String randomString = proverbs[random.nextInt(proverbs.length)];
    return randomString;
  }

   getData(){
     jh = JHijri(fDate: DateTime.now());
  }

  void updateTime() {
    final now = DateTime.now();
    final String formattedTime =
        "${now.hour.toString().padLeft(2, '0')}:"
        "${now.minute.toString().padLeft(2, '0')}:"
        "${now.second.toString().padLeft(2, '0')}";

    setState(() {
      timeString = formattedTime;
    });
  }


@override
  void initState() {
      getData();
      adhan();
      proverb = randomProverb();
      updateTime();
      Timer.periodic(const Duration(seconds: 1), (Timer t) => updateTime());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    TextStyle headerFormat = TextStyle(fontSize:SizeConfig.defaultSize!*1.0,fontWeight: FontWeight.bold );
    TextStyle rowFormat = TextStyle(fontSize:SizeConfig.defaultSize!*1.3,fontWeight: FontWeight.bold );

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('اليوم',style: TextStyle(fontSize:SizeConfig.defaultSize!*3.0, fontWeight: FontWeight.bold,color: defaultColor),),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              margin: const EdgeInsetsDirectional.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                   // margin: const EdgeInsets.all(8.0),
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black, width: 2.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Text(
                            jh.dayName,
                            style: TextStyle(fontSize:SizeConfig.defaultSize!*3.0, fontWeight: FontWeight.bold,color: defaultColor)
                          ),
                  ),
                  SizedBox(height: SizeConfig.defaultSize),
                  Container(
                    width: SizeConfig.screenWidth,
                   // margin: const EdgeInsets.all(8.0),
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black, width: 2.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Text(
                      textAlign: TextAlign.center,
                     "Current Time: $timeString",
                        style: TextStyle(fontSize: SizeConfig.defaultSize!*2.5, fontWeight: FontWeight.bold,color: defaultColor)
                    ),
                  ),
                  SizedBox(height: SizeConfig.defaultSize),
                  Container(
                height: 2,
                width: double.infinity,
                color: Colors.black,
              ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.all(8.0),
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black, width: 2.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Column(
                          children: [
                            Text(jh.day.toString(),style: TextStyle(
                              fontSize: SizeConfig.defaultSize!*6.0,
                              fontWeight: FontWeight.bold,
                              color: defaultColor,
                            ),),
                            FittedBox(
                              child: Text(jh.monthName,style: TextStyle(
                                fontSize: SizeConfig.defaultSize!*3.0,
                                fontWeight: FontWeight.bold,
                                color: defaultColor,
                              ),),
                            ),
                            Text(jh.year.toString(),style: TextStyle(
                              fontSize: SizeConfig.defaultSize!*3.0,
                              fontWeight: FontWeight.bold,
                              color: defaultColor,
                            ),)
                          ],
                        ),
                      ),
                    ),
                      Container(
                        height: SizeConfig.defaultSize!*18,
                        width: 2,
                        color: Colors.black,
                      ),
        
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.all(8.0),
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.black, width: 2.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Column(
                            children: [
                              Text(jh.hijri.westernDate.day.toString(),style: TextStyle(
                                fontSize:SizeConfig.defaultSize!*6.0,
                                fontWeight: FontWeight.bold,
                                color: defaultColor,
                              )),
                              FittedBox(
                                child: Text(jh.hijri.westernDate.monthName,style: TextStyle(
                                  fontSize: SizeConfig.defaultSize!*3.0,
                                  fontWeight: FontWeight.bold,
                                  color: defaultColor,
                                )),
                              ),
                              Text(jh.hijri.westernDate.year.toString(),style: TextStyle(
                                fontSize: SizeConfig.defaultSize!*3.0,
                                fontWeight: FontWeight.bold,
                                color: defaultColor,
                              ))
                            ],
                          ),
                        ),
                      )
                  ],),
                  Table(
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    border: TableBorder.all(color: defaultColor),
                    children:  [
                       TableRow(
                        decoration: const BoxDecoration(color: Colors.grey),
                        children: [
                          Text('العشاء', textAlign: TextAlign.center,style:headerFormat),
                          Text('المغرب', textAlign: TextAlign.center,style:headerFormat),
                          Text('العصر', textAlign: TextAlign.center,style:headerFormat),
                          Text('الظهر', textAlign: TextAlign.center,style:headerFormat),
                          Text('الشروق', textAlign: TextAlign.center,style:headerFormat),
                          Text('الفجر', textAlign: TextAlign.center,style:headerFormat),
                          Text('المواقيت', textAlign: TextAlign.center,style:headerFormat),
                        ],
                      ),
                      TableRow(
                        children: [
                          Text(prayerTimes.isha.toString().substring(11,16), textAlign: TextAlign.center,style: rowFormat,),
                          Text(prayerTimes.maghrib.toString().substring(11,16), textAlign: TextAlign.center,style: rowFormat,),
                          Text(prayerTimes.asr.toString().substring(11,16), textAlign: TextAlign.center,style: rowFormat,),
                          Text(prayerTimes.dhuhr.toString().substring(11,16), textAlign: TextAlign.center,style: rowFormat,),
                          Text(prayerTimes.sunrise.toString().substring(11,16), textAlign: TextAlign.center,style: rowFormat,),
                          Text(prayerTimes.fajr.toString().substring(11,16), textAlign: TextAlign.center,style: rowFormat,),
                          Text('الموقع الحالي', textAlign: TextAlign.center,style: rowFormat,),
                        ],
                      ),
                    ],
                  ),
        
                  Container(
                    width: SizeConfig.screenWidth,
                    margin: const EdgeInsets.all(8.0),
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: defaultColor,
                      border: Border.all(color: Colors.black, width: 2.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Text(
                      proverb,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: SizeConfig.defaultSize!*1.7,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
                ),
        
            Row(
            //  mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: SizeConfig.defaultSize!*15,
                  width: SizeConfig.screenWidth!/4,
                  child: GestureDetector(child: Card(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset('assets/images/sebha.png'),
                        Text('تسابيح',
                          style: TextStyle(fontWeight: FontWeight.bold,
                              fontSize: SizeConfig.defaultSize!*1.2,
                              color: defaultColor),)
                      ],
                    ),
                  ),
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SebhaScreen()),
                    );
                  },
                  ),
                ),
                SizedBox(
                 height: SizeConfig.defaultSize!*15,
                  width: SizeConfig.screenWidth!/4,
                  child: GestureDetector(child: Card(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset('assets/images/radio.png'),
                        Text('اذاعة القران الكريم',textAlign:TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: SizeConfig.defaultSize!*1.2,
                              color: defaultColor),)
                      ],
                    ),
                  ),
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const QuranRadioWidget()),
                      );
                    },
                  ),
                ),
                SizedBox(
                 height: SizeConfig.defaultSize!*15,
                  width: SizeConfig.screenWidth!/4,
                  child: GestureDetector(child: Card(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset('assets/images/splash.png'),
                         Text('اذكاري',style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: SizeConfig.defaultSize!*1.2,
                            color: defaultColor),)
                      ],
                    ),
                  ),
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const AzkarHomeScreen()),
                      );
                    },
                  ),
                ),
                SizedBox(
                 height: SizeConfig.defaultSize!*15,
                  width: SizeConfig.screenWidth!/4,
                  child: GestureDetector(child: Card(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset('assets/images/compass.png'),
                         Text('القبلة',style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: SizeConfig.defaultSize!*1.2,
                            color: defaultColor),)
                      ],
                    ),
                  ),
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const QiblaCompassPage()),
                      );
                    },
                  ),
                ),
        
        
        
        
              ],
            ),
          ],
        ),
      ));
  }
}
