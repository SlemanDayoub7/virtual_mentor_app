import 'package:flutter/material.dart';

class AppValidators {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }

    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }

    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }

    // Check for at least one special character and one uppercase letter
    final hasUpperCase = value.contains(RegExp(r'[A-Z]'));
    final hasSpecialChar = value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));

    if (!hasUpperCase) {
      return 'Password must contain at least one uppercase letter';
    }

    if (!hasSpecialChar) {
      return 'Password must contain at least one special character';
    }

    return null;
  }

  static String? validateConfirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }

    if (value != password) {
      return 'Passwords do not match';
    }

    return null;
  }

  static String? validateFullName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Full name is required';
    }

    if (value.length < 3) {
      return 'Name must be at least 3 characters';
    }

    if (value.length > 50) {
      return 'Name must not exceed 50 characters';
    }

    return null;
  }

  static String? validateOTP(String? value, {int length = 4}) {
    if (value == null || value.isEmpty) {
      return 'OTP code is required';
    }

    if (value.length != length) {
      return 'OTP must be $length digits';
    }

    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      return 'OTP must contain only numbers';
    }

    return null;
  }

  static bool isTermsAccepted(bool? value) {
    if (value == null || !value) {
      return false;
    }
    return true;
  }
}

// Extension for easy access in widgets
extension ValidatorExtensions on BuildContext {
  String? validateEmail(String? value) => AppValidators.validateEmail(value);
  String? validatePassword(String? value) =>
      AppValidators.validatePassword(value);
  String? validateConfirmPassword(String? value, String password) =>
      AppValidators.validateConfirmPassword(value, password);
  String? validateFullName(String? value) =>
      AppValidators.validateFullName(value);
  String? validateOTP(String? value, {int length = 4}) =>
      AppValidators.validateOTP(value, length: length);
}
