const readline = require('readline-sync');

function Course(coursecode, coursename, academicyear) {
    this.coursecode = coursecode;
    this.coursename = coursename;
    this.academicyear = academicyear;
    this.toString = function() {
        return this.coursecode + ": " + this.coursename + ", " + this.academicyear + "\n";
    };
}

function Student(studentid, forename, lastname, academicyear) {
    this.studentid = studentid;
    this.name = new function Name () {
        this.forename = forename;
        this.lastname = lastname;
    };
    this.academicyear = academicyear;
    this.toString = function() {
        return this.studentid + ": " + this.name.forename + ", " + this.name.lastname + ", "+ this.academicyear + "\n";
    };
}

function getcoursedata () {
    var coursecode = readline.question("Course code: ");
    var coursename = readline.question("Course name: ");
    var academicyear = readline.question("Academic year: ");
    var course = new Course(coursecode, coursename, academicyear);
    return course;
};

function getstudentdata () {
    var studentid = readline.question("Student id: ");
    var forename = readline.question("Forename: ");
    var lastname = readline.question("Lastname: ");
    var academicyear = readline.question("Academic year: ");
    var student = new Student(studentid, forename, lastname, academicyear);
    return student;
};

var course1 = getcoursedata();
process.stdout.write(course1.toString());

var course2 = getcoursedata();
process.stdout.write(course2.toString());
    
var student1 = getstudentdata();
process.stdout.write(student1.toString());

var student2 = getstudentdata();
process.stdout.write(student2.toString());