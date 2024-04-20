// import 'package:cloud_firestore/cloud_firestore.dart';

// // Add flashcard data to Firestore
// void addFlashcardToFirestore(
//     String question, String correctAnswer, List<String> options) {
//   FirebaseFirestore.instance.collection('flashcards').add({
//     'question': question,
//     'correctAnswer': correctAnswer,
//     'options': options,
//   }).then((value) {
//     print('Flashcard added to Firestore');
//   }).catchError((error) {
//     print('Failed to add flashcard: $error');
//   });
// }

// // Retrieve flashcards data from Firestore
// Stream<QuerySnapshot> getFlashcardsFromFirestore() {
//   return FirebaseFirestore.instance.collection('flashcards').snapshots();
// }





















// // import 'package:flutter/foundation.dart';
// // import 'package:flutter/material.dart';

// // class AddData extends StatefulWidget {
// //   const AddData({super.key});

// //   @override
// //   State<AddData> createState() => _AddDataState();
// // }

// // class _AddDataState extends State<AddData> {
// //   TextEditingController titleController = TextEditingController();
// //   TextEditingController descCriptionController = TextEditingController();
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text("Data Added"),
// //       ),
// //       body: Column(
// //         children: [
// //           TextField(
// //             controller: titleController,
// //             decoration: InputDecoration(),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }
