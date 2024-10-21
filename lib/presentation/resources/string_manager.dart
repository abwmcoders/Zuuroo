class AppStrings{
  static const String noRouteFound = "No Route Found";
  static const String login = "Login";
  static const String email = "Email";
  static const String first = "First Name";
  static const String last = "Last Name";
  static const String middle = "Middle Name";
  static const String password = "Password";
  static const String loginInstruction = "By signing in you are agreeing our";
  static const String tc = "Term and privacy policy";
  static const String rememberPassword = "Remember Password";
  static const String forgetPassword = "Forget Password";
  static const String hello = "Hello";
  static const String search = "Search ...";
  static const String academics = "Academics";
  static const String staff = "Staff Portal";
  static const String attendance = "Attendance";
  static const String att = "Attendance Sheet";
  static const String course = "Course";
  static const String createCourse = "Create Course";
  static const String outline = "Outline";
  static const String createTt = "Create TimeTable";
  static const String point = "Point";
  static const String prev = "Prev";
  static const String current = "Current";
  static const String all = "All";
  static const String total = "Total";
  static const String grade = "Grade";
  static const String med = "Medical";
  static const String fess = "Fees";
  static const String profile = "Profile";
  static const String result = "Results";
  static const String tt = "Time Table";
  static const String ai = "AI Solution";
  static const String help = "Help";
  static const String pastQ = "Past Questions";
  static const String eLearning = "E-Learning";
  static const String berry = "The Made Berry";
  static const String level = "500 lvl.";
  static const String company = "Deovaze Software Solution";
  static const String address = "Number 23, water cooperation drive Eti-osa, Victoria island, Lagos State, Nigeria.";
  static const String performance = "Performance Profile";
  static const String acaPerformance = "Academic Performance";
  static const String matNoTitle = "Matric Number:";
  static const String dob = "Date of birth:";
  static const String bGroup = "Blood Group:";
  static const String number = "Phone Number:";
  static const String dept = "Department:";
  static const String faculty = "Faculty:";
  static const String matNo = "N/CS/21/2026";
  static const String totalAttendance = "Total attendant of the student";
  static const String lvl = "Level";
  static const String cNumber = "Matric Number";
  static const String amount = "Amount";
  static const String courseTitle = "Course Title";
  static const String courseCode = "Course Code";
  static const String courseUnit = "Course Unit";
  static const String recent = "Recent Files";
  static const String import = "Import";
  static const String more = "More";
  static const String selectTt = "Select Time Table";

  //! Staff Routes
  static const String payslip = "Payslip";
  static const String studentList = "Student List";
  static const String studentReg = "Registration";
  static const String upload = "Upload";

  //! FUNCTIONS
  String emptyEmailField({String fieldType = "Email"}) =>
      '$fieldType field cannot be empty!';
  final String emailRegex =
      '[a-zA-Z0-9+._%-+]{1,256}\\@[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}(\\.[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25})+';
  final String invalidEmailField =
      "Email provided isn't valid.Try another email address";
  final String emptyTextField = 'Field cannot be empty!';
  final String passwordErrorTextField = 'Password does not match !!!';
            
}