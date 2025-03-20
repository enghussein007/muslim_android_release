// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:html/parser.dart' as html_parser;
//
//
//
// class HomeLayoutScreen extends StatelessWidget {
//   const HomeLayoutScreen({Key? key}) : super(key: key);
//
//   Future fetchData() async {
//     //String today = DateTime.now().toString().substring(0,10);
//     final response = await http.get(Uri.parse('https://www.yallakora.com/match-center/'));   // we remove query "?date=12/7/2023" to get today matches
//     //final response = await http.get(Uri.parse('https://www.yallakora.com/match-center/%D9%85%D8%B1%D9%83%D8%B2-%D8%A7%D9%84%D9%85%D8%A8%D8%A7%D8%B1%D9%8A%D8%A7%D8%AA?date=12/7/2023#'));
//     if (response.statusCode == 200) {
//       final document = html_parser.parse(response.body);
//       //final titleElement = document.querySelector('title');
//       //final titleElement = document.getElementById("match-list-viewer");
//       //final titleElement = document.querySelectorAll('.mc-block');
//
//       //--------------------transfer to widget----------------------------
//       // final teamA= document.querySelectorAll('div.teams.teamA > p');
//       // final scoreA= document.querySelectorAll('div.teamCntnr > div > div.MResult > span:nth-child(1)');
//       // final scoreB= document.querySelectorAll('div.teamCntnr > div > div.MResult > span:nth-child(3)');
//       // final time= document.querySelectorAll('div.teamCntnr > div > div.MResult > span.time');
//       // final teamB= document.querySelectorAll('div.teams.teamB > p');
//       // -----------------------------------------------------------------
//
//       //loop(titleElement);
//       //print(scores1[scores1.length-1]?.text);
//       //print(scoreB[1].text);
//       //return scoreB[1]?.text??'Not found';
//       return document;
//     } else {
//       throw Exception('Failed to load data');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const  Text('Matches Today'),
//       ),
//       body: FutureBuilder(
//         future: fetchData(),
//         builder:(context,snap){
//           if(snap.hasData){
//             final teamA= snap.data.querySelectorAll('div.teams.teamA > p');
//             final scoreA= snap.data.querySelectorAll('div.teamCntnr > div > div.MResult > span:nth-child(1)');
//             final scoreB= snap.data.querySelectorAll('div.teamCntnr > div > div.MResult > span:nth-child(5)');
//             final time= snap.data.querySelectorAll('div.teamCntnr > div > div.MResult > span.time');
//             final teamB= snap.data.querySelectorAll('div.teams.teamB > p');
//             return  ListView.separated(
//                 itemBuilder: (context,index){
//                   return Card(
//                     margin: const EdgeInsetsDirectional.all(8),
//                     color: Colors.amberAccent,
//                     child: Container(
//                       padding: const EdgeInsetsDirectional.all(8),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Column(
//                             children: [
//                               Text(scoreA[index].text),
//                               Text(teamA[index].text),
//                             ],
//                           ),
//                           const SizedBox(width: 20),
//                           Column(children: [
//                             const Text('-'),
//                             Text(time[index].text),
//                           ],),
//                           const SizedBox(width: 20),
//                           Column(children: [
//                             Text(scoreB[index].text),
//                             Text(teamB[index].text),
//                           ],)
//
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//                 separatorBuilder: (context,index){
//                   return const Divider();
//                 },
//                 itemCount: teamA.length);
//           }else if (snap.hasError){
//             return const Text('No Matches Found');
//           }else if(snap.connectionState==ConnectionState.waiting){
//             return const Center(child:  CircularProgressIndicator());
//           }else{
//             return const Text('No Data Found');
//           }
//         } ,
//       ),
//     );
//   }
// }
