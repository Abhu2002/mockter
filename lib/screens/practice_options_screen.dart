import 'package:expt1_login/screens/login_screen.dart';
import 'package:expt1_login/screens/network_error.dart';
import 'package:expt1_login/screens/test_screen.dart';
import 'package:flutter/material.dart';
import 'package:expt1_login/brains/login_brain.dart';
import 'package:flutter_awesome_alert_box/flutter_awesome_alert_box.dart';
import 'package:provider/provider.dart';
import 'package:expt1_login/models/authentication_details.dart';
import 'package:expt1_login/components/option_tab_topic.dart';
import 'package:expt1_login/components/subject_tab.dart';

// Create a key

class PracticeOptionsScreen extends StatefulWidget {
  static String id = '/practice_option_screen';

  @override
  State<PracticeOptionsScreen> createState() => _PracticeOptionsScreenState();
}

class _PracticeOptionsScreenState extends State<PracticeOptionsScreen>
    with SingleTickerProviderStateMixin {
  Map<String, List<String>> subjectsAndTopics = {
    'Programming And Data Structures': [
      'Programming in \nC',
      'Recursion',
      'Arrays',
      'Linked List',
      'Stack',
      'Queues',
      'Trees',
      'Graphs',
      'Binary Heaps',
    ],
    'Digital Logic': [
      'Boolean Algebra',
      'Combinational\n&\nSequential Circuits',
      'Minimization',
      'Number Representation\n&\nComputer Arithmetic'
    ],
    'Computer Organization And Architecture': [
      'Machine Instructions\n&\nAddressing Modes',
      'ALU,data-path\n&\nControl Unit',
      'Instruction Pipelining\n&\nPipeline Hazards',
      'Memory\nHierarchy',
      'I/O Interface',
    ],
    'Algorithms': [
      'Searching',
      'Sorting',
      'Hashing',
      'Greedy\nAlgorithms',
      'Dynamic Algorithms',
      'Divide\nAnd\nConquer Algorithms',
    ],
    'Theory Of Computation': [
      'Regular expressions\n&\nfinite automata',
      'Context-free\ngrammars &\npush-down automata',
      'Regular\n&\ncontex-free\nlanguages',
      'Pumping lemma',
      'Turing machines\n&\nundecidability',
    ],
    'Compiler Design': [
      'Lexical analysis',
      'Parsing',
      'Syntax-directed\ntranslation',
      'Runtime\nenvironments',
      'Intermediate code\ngeneration',
      'Local optimisation',
      'Data flow analyses:\nConstant\npropagation',
      'Liveness\nanalysis',
      'Common\nsubexpression\nelimination',
    ],
    'Operating System': [
      'System calls',
      'Processes',
      'Threads',
      'Inter-process\ncommunication',
      'Concurrency\n&\nsynchronization',
      'Deadlock',
      'CPU\n&\nI/O scheduling',
      'Memory\nmanagement\n&\nvirtual memory',
      'File systems'
    ],
    'Database Management System': [
      'ER-model',
      'Relational model',
      'Integrity constraints',
      'Normal forms',
      'File organization',
      'Indexing',
      'Transactions\n&\nconcurrency control',
    ],
    'Computer Networks': [
      'Concept Of Layering',
      'Data Link Layer',
      'Network Layer',
      'Transport Layer',
      'Application Layer'
    ],
  };
  @override
  Widget build(BuildContext context) {
    AuthenticationDetails ae = Provider.of<AuthenticationDetails>(context);
    return !ae.isLoggedIn
        ? LoginScreen()
        : Scaffold(
            drawerEnableOpenDragGesture: false,
            drawer: NetworkError(),
            body: SafeArea(
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.all(20.0),
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Hello,',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            SizedBox(height: 15.0),
                            Text(
                              Provider.of<AuthenticationDetails>(context).name,
                              style: const TextStyle(
                                fontSize: 35.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Builder(
                          builder: (context) => GestureDetector(
                            onTap: () {
                              Scaffold.of(context).openDrawer();
                            },
                            child: const Icon(
                              Icons.account_circle,
                              size: 60.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.0),
                    const Divider(
                      thickness: 2.0,
                      color: Colors.black,
                    ),
                    SizedBox(height: 20.0),
                    Text(
                      'Programming And Data Structures',
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey),
                    ),
                    SubjectTab(
                      subjectName: 'Programming And Data Structures',
                      topics:
                          subjectsAndTopics['Programming And Data Structures']!,
                    ),
                    SizedBox(height: 20.0),
                    Text(
                      'Digital Logic',
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey),
                    ),
                    SubjectTab(
                      subjectName: 'Digital Logic',
                      topics: subjectsAndTopics['Digital Logic']!,
                    ),
                    SizedBox(height: 20.0),
                    Text(
                      'Computer Organization And Architecture',
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey),
                    ),
                    SubjectTab(
                      subjectName: 'Computer Organization And Architecture',
                      topics: subjectsAndTopics[
                          'Computer Organization And Architecture']!,
                    ),
                    SizedBox(height: 20.0),
                    Text(
                      'Algorithms',
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey),
                    ),
                    SubjectTab(
                      subjectName: 'Algorithms',
                      topics: subjectsAndTopics['Algorithms']!,
                    ),
                    SizedBox(height: 20.0),
                    Text(
                      'Theory Of Computation',
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey),
                    ),
                    SubjectTab(
                      subjectName: 'Theory Of Computation',
                      topics: subjectsAndTopics['Theory Of Computation']!,
                    ),
                    SizedBox(height: 20.0),
                    Text(
                      'Compiler Design',
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey),
                    ),
                    SubjectTab(
                      subjectName: 'Compiler Design',
                      topics: subjectsAndTopics['Compiler Design']!,
                    ),
                    SizedBox(height: 20.0),
                    Text(
                      'Operating System',
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey),
                    ),
                    SubjectTab(
                      subjectName: 'Operating System',
                      topics: subjectsAndTopics['Operating System']!,
                    ),
                    SizedBox(height: 20.0),
                    Text(
                      'Database Management System',
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey),
                    ),
                    SubjectTab(
                      subjectName: 'Database Management System',
                      topics: subjectsAndTopics['Database Management System']!,
                    ),
                    SizedBox(height: 20.0),
                    Text(
                      'Computer Networks',
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey),
                    ),
                    SubjectTab(
                      subjectName: 'Computer Networks',
                      topics: subjectsAndTopics['Computer Networks']!,
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
