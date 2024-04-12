// import 'package:flutter/material.dart';
// import 'package:get_it/get_it.dart';
// import 'package:pp71/core/generated/assets.gen.dart';
// import 'package:pp71/core/keys/storage_keys.dart';
// import 'package:pp71/core/routes/routes.dart';
// import 'package:pp71/core/storage/storage_service.dart';
// import 'package:pp71/core/widgets/app_button.dart';

// class OnboardingView extends StatefulWidget {
//   const OnboardingView({super.key});

//   @override
//   State<OnboardingView> createState() => _OnboardingViewState();
// }

// class _OnboardingViewState extends State<OnboardingView> {
//   var _currentStep = 0;
//   final _storageService = GetIt.instance<StorageService>();

//   List _steps = [];

//   _OnboardingStep get _currentOnboarding => _steps[_currentStep];

//   @override
//   void initState() {
//     super.initState();
//   }

//   void _progress() async {
//     if (_currentStep == 2) {
//       _storageService.setBool(StorageKeys.seenOnboarding, true);
//       Navigator.of(context).pushReplacementNamed(RouteNames.pages);
//     } else {
//       setState(() => _currentStep++);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     _steps = [
//       _OnboardingStep(
//         text: const OnbTextWidgets(
//           text1: 'Add broken items',
//           text2:
//               'Easily create a personalized card for\neach broken item with complete information\nabout it.',
//         ),
//         backgorund: Assets.images.onb1,
//       ),
//       _OnboardingStep(
//         text: const OnbTextWidgets(
//           text1: 'Find information',
//           text2:
//               'Quickly find the right thing and\ninformation about it, monitor the\ncompletion of all tasks.',
//         ),
//         backgorund: Assets.images.onb2,
//       ),
//       _OnboardingStep(
//         text: const OnbTextWidgets(
//           text1: 'Study analytics',
//           text2:
//               'Keep track of how many things have already been repaired and how much is the total amount for repair materials.',
//         ),
//         backgorund: Assets.images.onb3,
//       ),
//     ];
//     return Container(
//       width: MediaQuery.of(context).size.width,
//       height: double.infinity,
//       decoration: BoxDecoration(
//         color: Theme.of(context).colorScheme.background,
//       ),
//       child: Scaffold(
//         backgroundColor: Colors.transparent,
//         floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//         floatingActionButton: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             AppButton(
//                 width: 0.9 * MediaQuery.of(context).size.width,
//                 fontSize: 24,
//                 onPressed: _progress,
//                 label: _currentStep == 2 ? 'Get started!' : 'Next'),
//             const SizedBox(height: 30),
//           ],
//         ),
//         body: Container(
//           padding: const EdgeInsets.only(left: 20, right: 20),
//           width: double.infinity,
//           height: double.infinity,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               Container(
//                   alignment: Alignment.topCenter,
//                   child: _currentOnboarding.backgorund.image()),
//               const SizedBox(height: 100),
//               Align(
//                   alignment: Alignment.bottomCenter,
//                   child: _currentOnboarding.text),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class OnbTextWidgets extends StatelessWidget {
//   const OnbTextWidgets({
//     super.key,
//     required this.text1,
//     required this.text2,
//   });

//   final String text1;
//   final String text2;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         Text(
//           text1,
//           textAlign: TextAlign.center,
//           style: Theme.of(context).textTheme.displayLarge!.copyWith(
//                 // fontWeight: FontWeight.w700,
//                 // fontSize: 30,
//                 color: Theme.of(context).colorScheme.onBackground,
//               ),
//         ),
//         const SizedBox(height: 5),
//         Text(
//           text2,
//           textAlign: TextAlign.center,
//           style: Theme.of(context).textTheme.bodyLarge!.copyWith(
//                 fontWeight: FontWeight.w500,
//                 fontSize: 16,
//                 color:
//                     Theme.of(context).colorScheme.onBackground.withOpacity(0.5),
//               ),
//         ),
//         const SizedBox(height: 150)
//       ],
//     );
//   }
// }

// class _OnboardingStep {
//   final Widget text;
//   final AssetGenImage backgorund;

//   const _OnboardingStep({
//     required this.text,
//     required this.backgorund,
//   });
// }
