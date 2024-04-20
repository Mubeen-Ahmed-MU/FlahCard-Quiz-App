// import 'package:flutter/material.dart';
// // import 'package:firebase_core/firebase_core.dart';
// // import 'package:cloud_firestore/cloud_firestore.dart';

// void main() {
//   // WidgetsFlutterBinding.ensureInitialized();
//   // await Firebase.initializeApp();
//   runApp(const FlashcardApp());
// }

// class FlashcardApp extends StatelessWidget {
//   const FlashcardApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flashcard Quiz',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const FlashcardHomePage(),
//     );
//   }
// }

// class FlashcardHomePage extends StatefulWidget {
//   const FlashcardHomePage({super.key});

//   @override
//   // ignore: library_private_types_in_public_api
//   _FlashcardHomePageState createState() => _FlashcardHomePageState();
// }

// class _FlashcardHomePageState extends State<FlashcardHomePage> {
//   late Stream<QuerySnapshot> flashcardsStream;
//   int currentIndex = 0;
//   int score = 0;

//   @override
//   void initState() {
//     super.initState();
//     flashcardsStream =
//         FirebaseFirestore.instance.collection('flashcards').snapshots();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Flashcard Quiz'),
//       ),
//       body: StreamBuilder<QuerySnapshot>(
//         stream: flashcardsStream,
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             List<QueryDocumentSnapshot> flashcards = snapshot.data!.docs;
//             return flashcards.isEmpty
//                 ? const Center(
//                     child: Text('No flashcards available.'),
//                   )
//                 : Column(
//                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                     children: [
//                       Expanded(
//                         child: Padding(
//                           padding: const EdgeInsets.all(16.0),
//                           child: Card(
//                             elevation: 2,
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                               children: [
//                                 Padding(
//                                   padding: const EdgeInsets.all(16.0),
//                                   child: Text(
//                                     flashcards[currentIndex]['question'],
//                                     style: const TextStyle(fontSize: 24),
//                                   ),
//                                 ),
//                                 ...((flashcards[currentIndex]['options']
//                                         as List<dynamic>)
//                                     .map<Widget>((option) {
//                                   return Padding(
//                                     padding: const EdgeInsets.symmetric(
//                                         horizontal: 16.0),
//                                     child: ElevatedButton(
//                                       onPressed: () => _showAnswer(
//                                           option,
//                                           flashcards[currentIndex]
//                                               ['correctAnswer']),
//                                       style: ElevatedButton.styleFrom(
//                                         foregroundColor: Colors.white,
//                                         backgroundColor: Colors.blue,
//                                       ),
//                                       child: Text(option),
//                                     ),
//                                   );
//                                 }).toList()),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Text(
//                           'Score: $score/${flashcards.length}',
//                           textAlign: TextAlign.center,
//                           style: const TextStyle(fontSize: 20),
//                         ),
//                       ),
//                     ],
//                   );
//           } else if (snapshot.hasError) {
//             return Center(
//               child: Text('Error: ${snapshot.error}'),
//             );
//           } else {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//         },
//       ),
//     );
//   }

//   void _showAnswer(String selectedOption, String correctAnswer) {
//     setState(() {
//       if (selectedOption == correctAnswer) {
//         score++;
//       }
//       currentIndex++;
//     });
//   }
// }

import 'package:flutter/material.dart';

void main() {
  runApp(const FlashcardApp());
}

class FlashcardApp extends StatelessWidget {
  const FlashcardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flashcard Quiz',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const FlashcardHomePage(),
    );
  }
}

class FlashcardHomePage extends StatefulWidget {
  const FlashcardHomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _FlashcardHomePageState createState() => _FlashcardHomePageState();
}

class _FlashcardHomePageState extends State<FlashcardHomePage> {
  List<Flashcard> flashcards = [];
  int currentIndex = 0;
  int score = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flashcard Quiz'),
      ),
      body: flashcards.isEmpty
          ? const Center(
              child: Text('No flashcards yet. Add some!'),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Card(
                      //color for card
                      color: Colors.redAccent,
                      elevation: 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              flashcards[currentIndex].question,
                              style: const TextStyle(fontSize: 24),
                            ),
                          ),
                          ...flashcards[currentIndex]
                              .options
                              .map(
                                (option) => Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 0.0),
                                  child: ElevatedButton(
                                    onPressed: () => _showAnswer(option),
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.white,
                                      backgroundColor: Colors.blue,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.zero,
                                      ),
                                    ),
                                    child: Text(option),
                                  ),
                                ),
                              )
                              .toList(),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Questions: $score/${flashcards.length}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addFlashcard,
        child: const Icon(
          Icons.add,
          size: 30,
        ),
      ),
    );
  }

  void _addFlashcard() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String question = '';
        String correctAnswer = '';
        List<String> options = List.filled(4, '');
        return AlertDialog(
          title: const Text('Add Flashcard'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  onChanged: (value) => question = value,
                  decoration: const InputDecoration(labelText: 'Question'),
                ),
                TextField(
                  onChanged: (value) => correctAnswer = value,
                  decoration:
                      const InputDecoration(labelText: 'Correct Answer'),
                ),
                for (int i = 0; i < 4; i++)
                  TextField(
                    onChanged: (value) => options[i] = value,
                    decoration: InputDecoration(labelText: 'Option ${i + 1}'),
                  ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  flashcards.add(Flashcard(
                    question: question,
                    correctAnswer: correctAnswer,
                    options: options,
                  ));
                });
                Navigator.of(context).pop();
              },
              child: const Text('Add'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void _showAnswer(String selectedOption) {
    String correctAnswer = flashcards[currentIndex].correctAnswer;
    setState(() {
      if (selectedOption == correctAnswer) {
        score++;
      }
      if (currentIndex < flashcards.length - 1) {
        currentIndex++;
      } else {
        _showResultDialog();
      }
    });
  }

  void _showResultDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Quiz Completed'),
          content: Text('Your score is $score/${flashcards.length}'),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  currentIndex = 0;
                  score = 0;
                });
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}

class Flashcard {
  final String question;
  final String correctAnswer;
  final List<String> options;

  Flashcard({
    required this.question,
    required this.correctAnswer,
    required this.options,
  });
}
