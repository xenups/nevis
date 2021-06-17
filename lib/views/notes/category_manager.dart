// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:nevis/blocs/note_blocs.dart';
// import 'package:sliding_panel/sliding_panel.dart';
//
// class CategoryManager extends StatefulWidget {
//   @override
//   _CategoryManagerState createState() => _CategoryManagerState();
// }
//
// class _CategoryManagerState extends State<CategoryManager> {
//   PanelController pc = PanelController();
//   List<Widget> get _content => [
//     Container(
//       padding: EdgeInsets.symmetric(vertical: 16),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: <Widget>[
//           Container(
//             margin: EdgeInsets.all(24.0),
//             child: Text(
//               'This is SlidingPanel',
//               style: Theme.of(context).textTheme.headline5,
//             ),
//           ),
//           Container(
//             margin: EdgeInsets.all(24.0),
//             child: Text(
//               'This panel doesn\'t contain bodyContent, but the SlidingPanel is attached to previous widget tree.',
//               style: Theme.of(context).textTheme.headline6,
//             ),
//           ),
//           Container(
//             margin: EdgeInsets.all(24.0),
//             child: Text(
//               'Here you get some more content.',
//               style: Theme.of(context).textTheme.headline6,
//             ),
//           ),
//           Container(
//             margin: EdgeInsets.all(24.0),
//             child: Text(
//               'Some useful content.',
//               style: Theme.of(context).textTheme.headline6,
//             ),
//           ),
//           Container(
//             margin: EdgeInsets.all(24.0),
//             child: Text(
//               'See you later!',
//               style: Theme.of(context).textTheme.headline6,
//             ),
//           ),
//         ],
//       ),
//     ),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return SlidingPanel(
//       panelController: pc,
//       backdropConfig: BackdropConfig(
//           enabled: true, closeOnTap: true, shadowColor: Colors.blue),
//       content: PanelContent(
//         panelContent: _content,
//         bodyContent: null,
//         // see this...
//       ),
//       snapping: PanelSnapping.enabled,
//       size: PanelSize(
//           closedHeight: 0.15,
//           collapsedHeight: 0.40,
//           expandedHeight: 0.85),
//       autoSizing: PanelAutoSizing(
//         autoSizeExpanded: true,
//       ),
//       //
//       parallaxSlideAmount: 1.0,
//       // Parallax sliding is not available if you don't use 'bodyContent'.
//       //
//       duration: Duration(milliseconds: 500),
//     );
//
//   }
// }
