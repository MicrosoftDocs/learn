//@ts-check
import {config} from "./config.js";
import * as cosmos from "@azure/cosmos";
import * as coursetypes from "./studentgrades.js";

const client = new cosmos.CosmosClient(config.connectionString);
const databaseid = config.database;
const containerid = config.container;
const containerref = client.database(databaseid).container(containerid);
const containerdata = containerref.items;

function isOK(statusCode)
{
    return statusCode >= 200 && statusCode <= 299;
}

async function queryStudents(course) {
    const studentquery = {
        query: "SELECT s.id, s.Name.Forename, s.Name.Lastname, c.Course, c.Grade \
                FROM students s JOIN c IN s.CourseGrades \
                WHERE s.AcademicYear = @year AND c.Course = @coursename",
        parameters: [
            {
                name: "@year",
                value: course.AcademicYear
            },
            {
                name: "@coursename",
                value: course.CourseName
            }
        ]
    };

    const { resources } = await containerdata.query(studentquery).fetchAll();
    for (let queryResult of resources) {
        let resultString = JSON.stringify(queryResult);
        process.stdout.write(`\nQuery returned ${resultString}\n`);
    }
}

async function getStudent(id, year) {
    const { resource, statusCode } = await containerref.item(id, year).read();
    if (isOK(statusCode)) { 
        process.stdout.write(`Student data: ${resource.id}: ${resource.Name.Forename}, ${resource.Name.Lastname}: ${resource.AcademicYear}\n`);
        resource.CourseGrades.forEach (function(coursegrade) {
            process.stdout.write(`${coursegrade.Course}:${coursegrade.Grade}\n`);
        });
    }
}

async function addStudent(student) {
    const { item, statusCode } = await containerdata.create(student);
    isOK(statusCode) && process.stdout.write(`Added student with id: ${item.id}\n`);
}

async function updateStudent(student) {
    const { item, statusCode } = await containerdata.upsert(student);
    isOK(statusCode) && process.stdout.write(`Updated student with id: ${item.id}\n`);
}

async function deleteStudent(student) {
    const { item, statusCode } = await containerref.item(student.id, student.AcademicYear).delete();
    isOK(statusCode) && process.stdout.write(`Deleted student with id: ${item.id}\n`);
}

async function addCourse(course) {
    const { item, statusCode } = await containerdata.create(course);
    isOK(statusCode) && process.stdout.write(`Added course with id: ${item.id}\n`);
}

async function getCourse(id, year) {
    const { resource, statusCode } = await containerref.item(id, year).read();
    isOK(statusCode) && process.stdout.write(`Course data: ${resource.id}: ${resource.CourseName}: ${resource.AcademicYear}\n`);
}

async function test() {
    process.stdout.write("Testing addCourse and getCourse\n\n");
    let course1 = coursetypes.getCourseData();
    await addCourse(course1).then(
        () => getCourse(course1.id, course1.AcademicYear)
    );

    let course2 = coursetypes.getCourseData();
    await addCourse(course2).then(
        () => getCourse(course2.id, course2.AcademicYear)
    );

    process.stdout.write("\n\nTesting addStudent and getStudent\n\n");
    let student1 = coursetypes.getStudentData();
    await addStudent(student1).then(
        () => getStudent(student1.id, student1.AcademicYear)
    );
    process.stdout.write("\n\nTesting addStudent and getStudent\n\n");
    let student2 = coursetypes.getStudentData();
    await addStudent(student2).then(
        () => getStudent(student2.id, student2.AcademicYear)
    );

    process.stdout.write("\n\nTesting updateStudent\n\n");
    student1.addGrade(course1.CourseName, "A");
    student1.addGrade(course2.CourseName, "C");
    await updateStudent(student1).then(
        () => getStudent(student1.id, student1.AcademicYear)
    );

    student2.addGrade(course1.CourseName, "B");
    student2.addGrade(course2.CourseName, "D");
    await updateStudent(student2).then(
        () => getStudent(student2.id, student2.AcademicYear)
    );

    process.stdout.write("\n\nTesting queryStudents\n\n");
    await queryStudents(course1);
    await queryStudents(course2);


    process.stdout.write("\n\nTesting deleteStudent\n\n");
    await deleteStudent(student1).then(
        () => getStudent(student1.id, student1.AcademicYear)
    );
    await deleteStudent(student2).then(
        () => getStudent(student2.id, student2.AcademicYear)
    );

    process.stdout.write("\n\nDone\n");
}

test();