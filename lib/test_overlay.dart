// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';
//
// void main() => runApp(const MyApp());
//
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         useMaterial3: true,
//       ),
//       home: const MyStatefulWidget(),
//     );
//   }
// }
//
// class MyStatefulWidget extends StatefulWidget {
//   const MyStatefulWidget({Key? key}) : super(key: key);
//
//   @override
//   State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
// }
//
// class _MyStatefulWidgetState extends State<MyStatefulWidget> {
//   late final WebViewController controller;
//
//   @override
//   void initState() {
//     super.initState();
//     controller = WebViewController()
//       ..setJavaScriptMode(JavaScriptMode.unrestricted)
//       ..loadRequest(
//         Uri.dataFromString('''
//           <html>
//             <head><meta name="viewport" content="width=device-width, initial-scale=1.0"></head>
//             <body>
//               <iframe src="https://timesprayer.com/widgets.php?frame=1&lang=ar&name=zagazig&avachang=true"
//                 title="Prayer Times"
//                 frameborder="0">
//               </iframe>
//             </body>
//           </html>
//         ''', mimeType: 'text/html'),
//       );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Flutter WebView example'),
//       ),
//       body: Stack(
//         children: [
//           WebViewWidget(
//             controller: controller,
//           ),
//         ],
//       ),
//     );
//   }
// }
