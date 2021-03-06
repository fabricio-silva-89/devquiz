import 'package:devquiz/challenge/challenge_page.dart';
import 'package:devquiz/challenge/widgets/quiz/quiz_widget.dart';
import 'package:devquiz/core/core.dart';
import 'package:devquiz/home/home_controller.dart';
import 'package:devquiz/home/home_state.dart';
import 'package:devquiz/home/widgets/appbar/app_bar_widget.dart';
import 'package:devquiz/home/widgets/level_button/level_button_widget.dart';
import 'package:devquiz/home/widgets/quiz_card/quiz_card_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = HomeController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.getUser();
    controller.getQuizzes();
    controller.stateNotifier.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return controller.state == HomeState.success
        ? Scaffold(
            appBar: AppBarWidget(
              user: controller.user!,
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  SizedBox(height: 24.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      LevelButtonWidget(
                        label: "Fácil",
                      ),
                      LevelButtonWidget(
                        label: "Médio",
                      ),
                      LevelButtonWidget(
                        label: "Difícil",
                      ),
                      LevelButtonWidget(
                        label: "Perito",
                      ),
                    ],
                  ),
                  SizedBox(height: 24.0),
                  Expanded(
                    child: GridView.count(
                        crossAxisSpacing: 16.0,
                        mainAxisSpacing: 16.0,
                        crossAxisCount: 2,
                        children: controller.quizzes!
                            .map((e) => QuizCardWidget(
                                  title: e.title,
                                  percent: e.questionAnswered / e.questions.length,
                                  completed: "${e.questionAnswered}/${e.questions.length}",
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ChallengePage(
                                          title: e.title,
                                          questions: e.questions,
                                        ),
                                      ),
                                    );
                                  },
                                ))
                            .toList()),
                  ),
                ],
              ),
            ),
          )
        : Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.darkGreen),
              ),
            ),
          );
  }
}
