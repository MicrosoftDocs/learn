
//@ts-check
import { question } from 'readline-sync';

class Course {
    constructor(coursecode, coursename, academicyear) {
        this.coursecode = coursecode;
        this.coursename = coursename;
        this.academicyear = academicyear;
        this.toString = function () {
            return `${this.coursecode}: ${this.coursename}, ${this.academicyear}\n`;
        };
    }
}

class Student {
    constructor(studentid, forename, lastname, academicyear) {
        this.studentid = studentid;
        this.academicyear = academicyear;
        this.name = new function Name() {
            this.forename = forename;
            this.lastname = lastname;
        };
        this.coursegrades = {};
        this.addGrade = function (course, grade) {
            this.coursegrades[course.coursecode] = grade;
        };
        this.toString = function () {
            return `${this.studentid}: ${this.name.forename}, ${this.name.lastname}, ${this.academicyear}\n`;
        };
        this.getGrades = function () {
            var grades = "";
            for (var coursecode in this.coursegrades) {
                grades = `${grades}${coursecode}: ${this.coursegrades[coursecode]}\n`;
            }
            return grades;
        };
    }
}

function getCourseData () {
    var coursecode = question("Course code: ");
    var coursename = question("Course name: ");
    var academicyear = question("Academic year: ");
    var course = new Course(coursecode, coursename, academicyear);
    return course;
};

function getStudentData () {
    var studentid = question("Student id: ");
    var forename = question("Forename: ");
    var lastname = question("Lastname: ");
    var academicyear = question("Academic year: ");
    var student = new Student(studentid, forename, lastname, academicyear);
    return student;
};


var course1 = getCourseData();
process.stdout.write(course1.toString());

var course2 = getCourseData();
process.stdout.write(course2.toString());
    
var student1 = getStudentData();

var student2 = getStudentData();

student1.addGrade(course1, "A");
student1.addGrade(course2, "C");
student2.addGrade(course2, "A");

process.stdout.write(student1.toString());
process.stdout.write(student1.getGrades());

process.stdout.write(student2.toString());
process.stdout.write(student2.getGrades());
