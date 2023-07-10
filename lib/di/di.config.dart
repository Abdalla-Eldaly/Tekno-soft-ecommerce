// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../api/ApiManager.dart' as _i3;
import '../data/dataSource/auth_online_dataSource.dart' as _i5;
import '../data/dataSource/CategoriesOnlineDataSourceImpl.dart' as _i9;
import '../data/repository/auth_repository.dart' as _i7;
import '../data/repository/CateogoriesRepository.dart' as _i11;
import '../domain/dataSource/auth_online_dataSource.dart' as _i4;
import '../domain/dataSource/CategoriesOnlineDataSource.dart' as _i8;
import '../domain/repository/auth_repository.dart' as _i6;
import '../domain/repository/CateogoriesRepository.dart' as _i10;
import '../domain/usecase/GetCategoriesUseCase.dart' as _i12;
import '../domain/usecase/login_use_case.dart' as _i14;
import '../domain/usecase/register_usecase.dart' as _i16;
import '../ui/home/tabs/home_tab/home_tab_viewModel.dart' as _i13;
import '../ui/login/login_viewModel.dart' as _i15;

extension GetItInjectableX on _i1.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.singleton<_i3.ApiManager>(_i3.ApiManager());
    gh.factory<_i4.AuthOnlineDataSource>(
        () => _i5.AuthOnlineDataSourceImpl(gh<_i3.ApiManager>()));
    gh.factory<_i6.AuthRepository>(
        () => _i7.AuthRepositoryImpl(gh<_i4.AuthOnlineDataSource>()));
    gh.factory<_i8.CategoriesOnlineDataSource>(
        () => _i9.CategoriesOnlineDataSourceImpl(gh<_i3.ApiManager>()));
    gh.factory<_i10.CategoriesRepository>(() =>
        _i11.CategoriesRepositoryImpl(gh<_i8.CategoriesOnlineDataSource>()));
    gh.factory<_i12.GetCategoriesUseCase>(
        () => _i12.GetCategoriesUseCase(gh<_i10.CategoriesRepository>()));
    gh.factory<_i13.HomeTabViewModel>(
        () => _i13.HomeTabViewModel(gh<_i12.GetCategoriesUseCase>()));
    gh.factory<_i14.LoginUseCase>(
        () => _i14.LoginUseCase(gh<_i6.AuthRepository>()));
    gh.factory<_i15.LoginViewModel>(
        () => _i15.LoginViewModel(gh<_i14.LoginUseCase>()));
    gh.factory<_i16.RegisterUseCase>(
        () => _i16.RegisterUseCase(gh<_i6.AuthRepository>()));
    return this;
  }
}
