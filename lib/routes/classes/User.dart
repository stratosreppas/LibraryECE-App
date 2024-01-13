import 'package:flutter/material.dart';

class User {

  final String username;
  final String name;
  final String surname;
  final String am;
  final String email;
  final String phone;
  final String penalty;

  User({
    required this.username,
    required this.name,
    required this.surname,
    required this.am,
    required this.email,
    required this.phone,
    required this.penalty,
  });
}
