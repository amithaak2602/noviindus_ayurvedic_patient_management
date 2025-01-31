import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:noviindus_ayurvedic_patient_management/screen/services/injection/injection.config.dart';

final locator = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies() async => locator.init();
