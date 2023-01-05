import 'package:flutter/material.dart';
import 'package:joao_foxbit_test/app/application.dart';
import 'package:intl/intl.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Intl.defaultLocale = 'pt_BR';
  
  runApp(FoxbitApp());
}