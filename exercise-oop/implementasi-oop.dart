import 'dart:io';

//Abstract class
abstract class Person {
  String name;
  int age;

  Person(this.name, this.age);

  void introduction();
}

//Student class
class Student extends Person {
  int _studentID;

  Student(String name, int age, this._studentID) : super(name, age);

  int get studentID => _studentID;

  @override
  void introduction() {
    print("Hello $name, your student ID is $_studentID.");
  }
}

//Teacher class
class Teacher extends Person {
  String subject;

  Teacher(String name, int age, this.subject) : super(name, age);

  @override
  void introduction() {
    print("Sir $name will be teach you for $subject subject.");
  }
}

void main() {
  //Input untuk student
  stdout.write("Enter student name: ");
  String studentName = stdin.readLineSync() ?? "";

  stdout.write("Enter student age: ");
  int studentAge = int.parse(stdin.readLineSync() ?? "0");

  stdout.write("Enter student ID: ");
  int studentID = int.parse(stdin.readLineSync() ?? "0");

  Student student = Student(studentName, studentAge, studentID);
  Teacher teacher = Teacher("Kelvin Minor", 28, "Calculus");

  //Output
  print("\n--- Introduction ---");
  student.introduction();
  teacher.introduction();
}
