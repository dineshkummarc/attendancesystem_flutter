// ignore_for_file: prefer_single_quotes

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http_parser/http_parser.dart';
import 'package:vexana/vexana.dart';

import '../../../_product/_enum/network_route_enum.dart';
import '../../../_product/_utility/service_helper.dart';
import '../../attendance/model/manage_attendance_model.dart';
import '../model/submodel/course/course_model.dart';
import '../model/submodel/courselist_model.dart';
import '../model/submodel/detail/detail_model.dart';
import 'ICourseService.dart';

class CourseService extends ICourseService with ServiceHelper {
  CourseService(INetworkManager manager, GlobalKey<ScaffoldState> scaffoldyKey)
      : super(manager, scaffoldyKey);

  @override
  Future<CourseModel?> addCourseControl(
      String teacherId, CourseModel courseModel, String token) async {
    final response = await manager.send<CourseModel, CourseModel>(
      NetworkRoutes.TEACHER.rawValue,
      urlSuffix: 'course/addcourse',
      parseModel: CourseModel(),
      method: RequestType.POST,
      data: {
        'teacherId': teacherId,
        'courseShortName': courseModel.courseShortName,
        'courseName': courseModel.courseName
      },
      options: Options(headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token'
      }),
    );

    showMessage(scaffoldyKey, response.error);
    return response.data;
  }

  @override
  Future<CourseModel?> addCourseScheduleControl(String id, String courseStartDate,
      String courseEndDate, String courseTime, String token) async {
    final response = await manager.send<CourseModel, CourseModel>(
      NetworkRoutes.TEACHER.rawValue,
      urlSuffix: 'course/addschedule/$id',
      parseModel: CourseModel(),
      method: RequestType.POST,
      options: Options(headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token'
      }),
    );

    showMessage(scaffoldyKey, response.error);
    return response.data;
  }

  @override
  Future<CourseModel?> updateCourseControl(CourseModel courseModel, String token) async {
    final response = await manager.send<CourseModel, CourseModel>(
      NetworkRoutes.TEACHER.rawValue,
      urlSuffix: 'course/update/' + courseModel.id!,
      parseModel: CourseModel(),
      method: RequestType.POST,
      options: Options(headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token'
      }),
    );

    showMessage(scaffoldyKey, response.error);
    return response.data;
  }

  @override
  Future<CourseModel?> deleteCourseControl(String id, String token) async {
    final response = await manager.send<CourseModel, CourseModel>(
      NetworkRoutes.TEACHER.rawValue,
      urlSuffix: 'course/deletecourse/' + id,
      parseModel: CourseModel(),
      method: RequestType.DELETE,
      options: Options(headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token'
      }),
    );

    showMessage(scaffoldyKey, response.error);
    return response.data;
  }

  @override
  Future<DetailModel?> getOneCourseTeacherControl(String id, String token) async {
    final response = await manager.send<DetailModel, DetailModel>(
      NetworkRoutes.TEACHER.rawValue,
      urlSuffix: 'course/' + id,
      parseModel: DetailModel(),
      method: RequestType.GET,
      options: Options(headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token'
      }),
    );
    showMessage(scaffoldyKey, response.error);
    return response.data;
  }

  @override
  Future<CourseListModel?> getCourseListTeacherControl(String teacherId, String token) async {
    final response = await manager.send<CourseListModel, CourseListModel>(
      NetworkRoutes.TEACHER.rawValue,
      urlSuffix: 'course/list/' + teacherId,
      parseModel: CourseListModel(),
      method: RequestType.GET,
      data: {},
      options: Options(headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token'
      }),
    );

    showMessage(scaffoldyKey, response.error);
    return response.data;
  }

  @override
  Future<CourseListModel?> getCourseListStudentControl(String studentId, String token) async {
    final response = await manager.send<CourseListModel, CourseListModel>(
      NetworkRoutes.STUDENT.rawValue,
      urlSuffix: 'course/list/' + studentId,
      parseModel: CourseListModel(),
      method: RequestType.GET,
      options: Options(headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token'
      }),
    );

    showMessage(scaffoldyKey, response.error);
    return response.data;
  }

  @override
  Future<DetailModel?> getOneCourseStudentControl(String studentId, String id, String token) async {
    final response = await manager.send<DetailModel, DetailModel>(
      NetworkRoutes.STUDENT.rawValue,
      urlSuffix: 'course/' + id,
      parseModel: DetailModel(),
      method: RequestType.POST,
      data: {'studentId': studentId},
      options: Options(headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token'
      }),
    );

    showMessage(scaffoldyKey, response.error);
    return response.data;
  }

  @override
  Future<CourseModel?> joinCourseControl(
      String studentId, CourseModel courseModel, String token) async {
    final response = await manager.send<CourseModel, CourseModel>(
      NetworkRoutes.STUDENT.rawValue,
      urlSuffix: 'course/joincourse',
      parseModel: CourseModel(),
      method: RequestType.POST,
      data: {'studentId': studentId, 'courseCode': courseModel.courseCode},
      options: Options(headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token'
      }),
    );

    showMessage(scaffoldyKey, response.error);
    return response.data;
  }

  @override
  Future<CourseModel?> leaveCourseControl(String id, String courseId, String token) async {
    final response = await manager.send<CourseModel, CourseModel>(
      NetworkRoutes.STUDENT.rawValue,
      urlSuffix: 'course/leave/' + id,
      parseModel: CourseModel(),
      method: RequestType.DELETE,
      data: {'courseId': courseId},
      options: Options(headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token'
      }),
    );

    showMessage(scaffoldyKey, response.error);
    return response.data;
  }

  @override
  Future<ManageAttendanceModel?> manageAttendance(
      String date, String id, String token, dynamic statusArray) async {
    final response = await manager.send<ManageAttendanceModel, ManageAttendanceModel>(
      NetworkRoutes.TEACHER.rawValue,
      urlSuffix: 'course/manageattendance/$id/$date',
      parseModel: ManageAttendanceModel(),
      method: RequestType.POST,
      data: {'statusArray': statusArray},
      options: Options(headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token'
      }),
    );
    showMessage(scaffoldyKey, response.error);
    return response.data;
  }

  @override
  Future<void> takeAttendance(String date, String id, String token, File file) async {
    final mimeType = await file.path.toString().trim().split('.').last;
    final originalFile = await file.path.toString().trim().split('/').last;
    final formData = FormData.fromMap({
      "image": await MultipartFile.fromFile(file.path,
          filename: originalFile, contentType: MediaType("image", mimeType)),
    });
    try {
      final baseUrl = dotenv.env['APP_API_SITE'].toString();
      await manager.uploadFile(
        baseUrl + NetworkRoutes.TEACHER.rawValue + "course/takeattendance/$id/$date",
        formData,
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
          HttpHeaders.acceptHeader: '*/*',
          HttpHeaders.acceptEncodingHeader: 'gzip, deflate, br',
          HttpHeaders.connectionHeader: 'keep-alive',
        },
      );
    } on DioError catch (e) {
      if (e.type == DioErrorType.response) {
        print('Catched');
      }
      if (e.type == DioErrorType.connectTimeout) {
        print('Check your connection');
      }

      if (e.type == DioErrorType.receiveTimeout) {
        print('Unable to connect to the server');
      }

      if (e.type == DioErrorType.other) {
        print('Something went wrong');
      }
      print(e);
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<ManageAttendanceModel?> showAttendance(String date, String id, String token) async {
    final response = await manager.send<ManageAttendanceModel, ManageAttendanceModel>(
      NetworkRoutes.TEACHER.rawValue + '/course/showattendance/$id/$date',
      parseModel: ManageAttendanceModel(),
      method: RequestType.GET,
      options: Options(headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token'
      }),
    );
    showMessage(scaffoldyKey, response.error);
    return response.data;
  }
}
