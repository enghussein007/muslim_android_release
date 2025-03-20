import 'package:calendar/app/shared/constants/tasbeeh.dart';
import 'package:calendar/app/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import '../shared/network/local/shared_prefernce.dart';
import '../shared/utils/size_config.dart';

class SebhaScreen extends StatefulWidget {
  const SebhaScreen({super.key});

  @override
  State<SebhaScreen> createState() => _SebhaScreenState();
}

class _SebhaScreenState extends State<SebhaScreen> {
  int numOfTasbeeh=0;int totaLTasbeeh=0;int completedNum=0;
  final formKey = GlobalKey<FormState>();
  TextEditingController textController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  final _focusNode = FocusNode();
  String targetZekr='سبحان الله ';
  int targetCount=33;

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: textController,
                  decoration: const InputDecoration(labelText: 'ادخل الذكر'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'برجاء إدخال الذكر المطلوب';
                    }
                    return null;
                  },
                  onFieldSubmitted: (_)=>FocusScope.of(context).requestFocus(_focusNode),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: numberController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'العدد'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'برجاء إدخال العدد المطلوب';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Invalid number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      // Perform your save logic here
                      //print('Text: ${textController.text}');
                      targetZekr =textController.text;
                      targetCount=int.parse(numberController.text);
                      setState(() {});
                      textController.text='';
                      numberController.text='';
                     // print('Number: ${numberController.text}');
                      Navigator.of(context).pop(); // Close the bottom sheet
                    }
                  },
                  child: const Text('Save'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }



  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        backgroundColor: defaultColor,

        child: ListView.separated(
            itemBuilder: (context,index)=>ListTile(
              textColor: Colors.white,
              iconColor: Colors.white,
              title:  Text(
                tasbeeh[index]['text'],
                textScaler: const TextScaler.linear(1.5),
              ),
              subtitle: Text(
                  tasbeeh[index]['count'].toString(),
                  textScaler: const TextScaler.linear(1.0)),
              onTap:(){
                Navigator.pop(context);
                setState(() {
                  numOfTasbeeh=0;
                  completedNum=0;
                  targetZekr=tasbeeh[index]['text'];
                  targetCount=tasbeeh[index]['count'];
                  CachHelper.putData(key: 'selectedTasbeeh', value: index);
                });

              },
              trailing: const Icon(Icons.arrow_forward_ios),
            ),
            separatorBuilder: (context,index)=>const Divider(),
            itemCount: tasbeeh.length),
      ),
      appBar: AppBar(
        title: const Text('سبحة',
          style: TextStyle(
              fontSize: 28,
            fontWeight: FontWeight.bold),),
         actions: [
        //   IconButton(tooltip: 'Reset All',onPressed: ()async{
        //     RingerModeStatus ringerStatus = await SoundMode.ringerModeStatus;
        //     print(ringerStatus);
        //     try {
        //       await SoundMode.setSoundMode(RingerModeStatus.normal);
        //     } on PlatformException {
        //      // print('Please enable permissions required');
        //
        //     }
        //     setState((){
        //       b=0;
        //       CachHelper.putData(key: 'num', value: b);
        //     });
        //   }, icon: const Icon(Icons.restart_alt)),
        //   IconButton(tooltip:'Ring',onPressed: ()async{
        //     await SoundMode.setSoundMode(RingerModeStatus.normal);
        //   }, icon:const Icon(Icons.phonelink_ring)),
        //   IconButton(tooltip:'Silent',onPressed: ()async{
        //     await SoundMode.setSoundMode(RingerModeStatus.silent);
        //   }, icon:const Icon(Icons.do_not_disturb_on_total_silence)),
        //   IconButton(tooltip:'Vibrate',onPressed: ()async{
        //     await SoundMode.setSoundMode(RingerModeStatus.vibrate);
        //   }, icon:const Icon(Icons.vibration))
           MaterialButton(onPressed: (){
             _showBottomSheet(context);
           }, child: const Row(children: [
             Text('الوضع الحر',
             style: TextStyle(
                 fontWeight: FontWeight.bold),),
             Icon(Icons.format_list_numbered)
           ],))
         ],
      ),
      body: Center(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          //mainAxisSize: MainAxisSize.min,
          children: [
             Container(
               width: double.infinity,
               constraints: BoxConstraints(
                 minHeight: SizeConfig.defaultSize!*8
               ),
               child: Card(
                 color: defaultColor,
                 child: Center(
                   child: Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: Text(targetZekr,
                       style: const TextStyle(
                       fontSize: 28,
                         fontWeight: FontWeight.bold,
                         color: Colors.white
                     ),
                       overflow: TextOverflow.clip,
                       textAlign: TextAlign.center,
                     ),
                   ),
                 ),
               ),
             ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: GestureDetector(onTap: (){
                    setState((){
                      numOfTasbeeh=0;
                    });
                  },child: const CircleAvatar(radius: 25,backgroundColor: Colors.red,child:Icon(Icons.restart_alt_outlined),)),
                ),
              ]),
            ),
            Expanded(
              flex: 5,
              child: GestureDetector(onTap:(){
              setState((){
                SystemSound.play(SystemSoundType.click);
                HapticFeedback.selectionClick();
                if(numOfTasbeeh==targetCount){
                  numOfTasbeeh=0;completedNum++;

                }else{
                  numOfTasbeeh++;totaLTasbeeh++;
                }

                CachHelper.putData(key: 'num', value: totaLTasbeeh);
              });
              } ,child: SfRadialGauge(
                backgroundColor: Colors.transparent,
                axes: <RadialAxis>[
                  RadialAxis(
                    isInversed: true,
                    startAngle: 90,
                    endAngle: 90,
                    interval: 1,
                    minimum: 0,
                    maximum: targetCount.toDouble(),
                    showLabels: false,
                    showTicks: false,
                    annotations:  <GaugeAnnotation>[
                      GaugeAnnotation(axisValue: 0, positionFactor: 1.0,
                          widget: Column(
                            children: [
                              Text("${numOfTasbeeh.toString()} of $targetCount", style:
                              const TextStyle(fontWeight: FontWeight.bold, fontSize: 32),),
                              Container(width: 200,height: 2,color: Colors.grey[300],),
                              Text("عدد المرات المكتملة:${completedNum.toString()}", style:
                              const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),),
                              Image.asset('assets/images/point.jpg',width: 50,height: 50,),

                            ],
                          ))],
                    pointers:  <GaugePointer>[RangePointer(
                      value: numOfTasbeeh.toDouble(),
                      color: defaultColor,
                      cornerStyle: CornerStyle.endCurve,
                      onValueChangeEnd: (double d){
                       // print("finish");
                      },
                      onValueChanging: (value){
                       // print(value);
                      },

                    )],
                  ),
                ],
              )),
            ),
            Expanded(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: GestureDetector(onTap: (){
                      setState((){

                        numOfTasbeeh=totaLTasbeeh=completedNum=0;
                        CachHelper.putData(key: 'num', value: totaLTasbeeh);
                      });
                    },child: const CircleAvatar(radius: 25,backgroundColor: Colors.red,child:Icon(Icons.restart_alt_outlined),)),
                  ),
                  ]),
            ),

        Expanded(
          child: SizedBox(
            width: double.infinity,
            child: Card(
              color: defaultColor,
              child: Center(
                child: FittedBox(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("${CachHelper.getData(key: 'num') ?? '0'} : مجموع التسبيحات اليومية",
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      color: Colors.white
                    ),
                    textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
          ],
        ),
      ),
    );
  }
}
