// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:noviindus_ayurvedic_patient_management/api_service/post_api.dart'
    as _i594;
import 'package:noviindus_ayurvedic_patient_management/screen/services/injection/register_module.dart'
    as _i1040;
import 'package:noviindus_ayurvedic_patient_management/screen/services/shared_preference.dart'
    as _i240;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    gh.factoryAsync<_i460.SharedPreferences>(() => registerModule.prefs);
    gh.singleton<_i594.PostApi>(() => _i594.PostApi());
    gh.singletonAsync<_i240.Shared>(() async => _i240.Shared(
        sharedPreferences: await getAsync<_i460.SharedPreferences>()));
    return this;
  }
}

class _$RegisterModule extends _i1040.RegisterModule {}
