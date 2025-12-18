// ignore_for_file: constant_identifier_names, camel_case_types

enum Auth_Exceptions {
  EMAIL_ALREADY_EXISTS,
  NETWORK_ERROR,
  INVALID_EMAIL,
  REGISTRATION_SUCCESS,
  EMAIL_NOT_VERIFIED,
  LOGIN_SUCCESSFULL,
  ACCOUNT_NOT_FOUND,
  INVALID_PASSWORD,
  RESET_LINK_SENT,
}

enum Question_Type {
  SINGLE_CORRECT_ANSWER,
  MULTIPLE_CORRECT_ANSWER,
  FILL_IN_THE_BLANKS
}
Map<String, List<String>> subjectsAndTopics = {
  'Programming And Data Structures': [
    'Programming in C',
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
    'Combinational And Sequential Circuits',
    'Minimization',
    'Number Representation And Computer Arithmetic'
  ],
  'Computer Organization And Architecture': [
    'Machine Instructions And Addressing Modes',
    'ALU,data-path and Control Unit',
    'Instruction Pipelining & Pipeline Hazards',
    'Memory Hierarchy',
    'I/O Interface',
  ],
  'Algorithms': [
    'Searching',
    'Sorting',
    'Hashing',
    'Greedy Algorithms',
    'Dynamic Algorithms',
    'Divide And Conquer Algorithms',
  ],
  'Theory Of Computation': [
    'Regular expressions and finite automata',
    'Context-free grammars and push-down automata',
    'Regular and contex-free languages',
    'Pumping lemma',
    'Turing machines and undecidability',
  ],
  'Compiler Design': [
    'Lexical analysis',
    'Parsing',
    'Syntax-directed translation',
    'Runtime environments',
    'Intermediate code generation',
    'Local optimisation',
    'Data flow analyses: constant propagation',
    'Liveness analysis',
    'Common subexpression elimination',
  ],
  'Operating System': [
    'System calls',
    'Processes',
    'Threads',
    'Inter-process communication',
    'Concurrency and synchronization',
    'Deadlock',
    'CPU and I/O scheduling',
    'Memory management and virtual memory',
    'File systems'
  ],
  'DBMS': [
    'ER-model',
    'Relational model: relational algebra, tuple calculus, SQL',
    'Integrity constraints',
    'Normal forms',
    'File organization',
    'Indexing',
    'Transactions and concurrency control',
  ],
  'Computer Networks': [
    'Concept Of Layering',
    'Data Link Layer',
    'Network Layer',
    'Transport Layer',
    'Application Layer'
  ],
};
