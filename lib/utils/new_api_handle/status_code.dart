import 'dart:ui';

import 'package:flutter/material.dart';

// enum StatussCode {
//   BadRequest,
//   Unauthorized,
//   Forbidden,
//   NotFound,
//   Conflict,
//   InternalServerError
// }
//
// int statusNo(StatussCode state) {
//   int statusCode;
//   switch (state) {
//     case StatussCode.BadRequest:
//       statusCode = 400;
//       break;
//     case StatussCode.Forbidden:
//       statusCode = 403;
//       break;
//     case StatussCode.InternalServerError:
//       statusCode = 500;
//       break;
//     case StatussCode.Unauthorized:
//       statusCode = 401;
//       break;
//     case StatussCode.NotFound:
//       statusCode = 404;
//       break;
//     case StatussCode.Conflict:
//       statusCode = 409;
//       break;
//   }
//   return statusCode;
// }

class StatusCode {
  static const int ok = 200;
  static const int badRequest = 400;
  static const int Conflict = 409;
  static const int NotFound = 404;
  static const int Unauthorized = 401;
  static const int InternalServerError = 500;
  static const int Forbidden = 403;
}
