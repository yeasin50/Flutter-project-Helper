part of 'models.dart';

extension IsarExtension<T> on T {
  get toMain {
    switch (runtimeType) {
      case CourseAndSections:
        return IsarCourseAndSection()
          ..courseCode = (this as CourseAndSections).courseCode
          ..sections = (this as CourseAndSections).sections;

      case ClassSchedule:
        final model = this as IsarClassSchedule;
        return ClassSchedule(
            timeSlot: model.timeSlot,
            dayName: model.dayName,
            roomNo: model.roomNo,
            course: model.course,
            section: model.section,
            teacher: model.teacher);

      default:
        throw UnimplementedError();
    }
  }

  get toIsar {
    switch (runtimeType) {
      case IsarCourseAndSection:
        return CourseAndSections(
          courseCode: (this as CourseAndSections).courseCode,
          sections: (this as CourseAndSections).sections,
        );
      case IsarClassSchedule:
        final model = this as ClassSchedule;
        return IsarClassSchedule()
          ..course = model.course
          ..timeSlot = model.timeSlot
          ..dayName = model.dayName
          ..roomNo = model.roomNo
          ..course = model.course
          ..section = model.section
          ..teacher = model.teacher;

      default:
        throw UnimplementedError();
    }
  }
}
