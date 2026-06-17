import 'package:flutter/material.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  bool selected = false;
  int selectedIndex = -1;
  int correctAnswerIndex = 2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(),
      body: PageView(
        children: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                Text(
                  'An experience that is easy to use is said to be… An experience that is easy to use is said to be…',
                ),
                Expanded(
                  child: ListView.separated(
                    itemCount: 4,
                    separatorBuilder: (context, index) {
                      return SizedBox(height: 10.0);
                    },
                    itemBuilder: (context, index) {
                      return CheckboxListTile(
                        onChanged: (value) {
                          setState(() {
                            selected = true;
                            selectedIndex = index;
                          });
                        },
                        value: false,
                        controlAffinity: ListTileControlAffinity.leading,
                        tileColor: setTileColor(index),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                          side: BorderSide(
                            width: 3,
                            // agar tanlangani to'g'ri bo'lsa -> yashil
                            // agar tanlangani xato bo'lsa -> qizil
                            // agar tanlanmagan bo'lsa -> kulrang
                            color: setColor(index),
                          ),
                        ),
                        checkboxShape: CircleBorder(),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: ElevatedButton(
        onPressed: () {},
        child: Text('Check'),
      ),
    );
  }

  Color setColor(int index) {
    if (selected) {
      if (selectedIndex == index && index != correctAnswerIndex) {
        return Colors.red;
      } else if (selectedIndex != index && index == correctAnswerIndex) {
        return Colors.green;
      } else if (selectedIndex == index && index == correctAnswerIndex) {
        return Colors.green;
      } else {
        return Colors.grey;
      }
    } else {
      return Colors.grey;
    }
  }

  Color setTileColor(int index) {
    if (selected) {
      if (selectedIndex == index && index != correctAnswerIndex) {
        return Colors.red.withValues(alpha: .5);
      } else if (selectedIndex != index && index == correctAnswerIndex) {
        return Colors.green.withValues(alpha: .5);
      } else if (selectedIndex != index && index != correctAnswerIndex) {
        return Colors.grey.withValues(alpha: .5);
      } else if (selectedIndex == index && index == correctAnswerIndex) {
        return Colors.green.withValues(alpha: .5);
      }
      // ishlamaydi
      return Colors.black.withValues(alpha: .5);
    } else {
      return Colors.grey.withValues(alpha: .5);
    }
  }
}
