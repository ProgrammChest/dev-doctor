import 'package:dev_doctor/editor/bloc/server.dart';
import 'package:dev_doctor/models/course.dart';
import 'package:dev_doctor/models/part.dart';

class CourseEditorBloc {
  final ServerEditorBloc bloc;
  final Course course;
  final List<CoursePart> parts;

  CourseEditorBloc(this.course, {this.bloc, List<CoursePart> parts = const []})
      : parts = List<CoursePart>.unmodifiable(parts);

  CourseEditorBloc.fromJson(Map<String, dynamic> json)
      : course = Course.fromJson(json['course']),
        bloc = json['bloc'],
        parts = List<CoursePart>.unmodifiable((json['parts'] as List<dynamic> ?? [])
                .map((e) => CoursePart.fromJson(e))
                .toList(growable: false) ??
            []);
  Map<String, dynamic> toJson() =>
      {"course": course.toJson(), "parts": parts.map((e) => e.toJson()).toList()};
  CourseEditorBloc copyWith({Course course, List<CoursePart> parts}) =>
      CourseEditorBloc(course ?? this.course, parts: parts ?? this.parts, bloc: bloc);
}
