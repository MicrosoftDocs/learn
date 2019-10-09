//@ts-check
import { question } from 'readline-sync';

class Course {
    constructor(coursecode, coursename, academicyear) {
        this.id = coursecode;
        this.CourseName = coursename;
        this.AcademicYear = academicyear;
        this.toString = function () {
            return `${this.id}: ${this.CourseName}, ${this.AcademicYear}\n`;
        };
    }
}

class Student {
    constructor(studentid, forename, lastname, academicyear) {
        this.id = studentid;
        this.AcademicYear = academicyear;
        this.Name = new function Name() {
            this.Forename = forename;
            this.Lastname = lastname;
        };
        this.CourseGrades = [];
        this.addGrade = function (coursename, grade) {
            this.CourseGrades.push({Course: coursename, Grade: grade});
        };
        this.toString = function () {
            return `${this.id}: ${this.Name.Forename}, ${this.Name.Lastname}, ${this.AcademicYear}\n`;
        };
        this.getGrades = function () {
            let grades = "";
            this.CourseGrades.forEach (function(coursegrade) {
                grades = `${grades}${coursegrade.Course}:${coursegrade.Grade}\n`;
            });
            return grades;
        };
    }
}

function getCourseData () {
    let coursecode = question("Course code: ");
    let coursename = question("Course name: ");
    let academicyear = question("Academic year: ");
    let course = new Course(coursecode, coursename, academicyear);
    return course;
};

function getStudentData () {
    let studentid = question("Student id: ");
    let forename = question("Forename: ");
    let lastname = question("Lastname: ");
    let academicyear = question("Academic year: ");
    let student = new Student(studentid, forename, lastname, academicyear);
    return student;
};

function test() {
    let course1 = getCourseData();
    process.stdout.write(course1.toString());

    let course2 = getCourseData();
    process.stdout.write(course2.toString());
    
    let student1 = getStudentData();

    let student2 = getStudentData();

    student1.addGrade(course1.CourseName, "A");
    student1.addGrade(course2.CourseName, "C");
    student2.addGrade(course2.CourseName, "A");

    process.stdout.write(student1.toString());
    process.stdout.write(student1.getGrades());

    process.stdout.write(student2.toString());
    process.stdout.write(student2.getGrades());
}

//test();

export {Course, Student, getCourseData, getStudentData};