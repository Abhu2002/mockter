import 'package:flutter/material.dart';
import 'package:expt1_login/components/option_tab_topic.dart';

class SubjectTab extends StatelessWidget {
  final String subjectName;
  final List<String> topics;

  SubjectTab({this.subjectName = '', this.topics = const []});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: topics.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(5.0),
              child: OptionTabTopic(
                subjectName: subjectName,
                title: topics[index],
              ),
            );
          }),
    );
  }
}
