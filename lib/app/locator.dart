import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:zuuro/app/cache/orage_cred.dart';
import 'package:zuuro/app/cache/storage.dart';
import 'package:zuuro/presentation/view/home/provider/home_provider.dart';

import '../presentation/view/auth/login/provider/login_provider.dart';
import '../presentation/view/auth/register/provider/reg_provider.dart';
import '../presentation/view/vtu/provider/vtu_provider.dart';
import 'services/base_services.dart';

final getIt = GetIt.instance;

initializer() async {
  //! Register classes here
  getIt.registerLazySingleton(() => BaseServices());
  getIt.registerLazySingleton(() => StorageCredentials());
  getIt.registerLazySingleton(() => VtuProvider());
  getIt.registerSingleton<MekStorage>(MekStorage());
  await getIt<MekStorage>().init();
}

final allProviders = <SingleChildWidget>[
  ChangeNotifierProvider(create: (_) => RegisterProvider()),
  ChangeNotifierProvider(create: (_) => LoginProvider()),
  ChangeNotifierProvider(create: (_) => HomeProvider()),
  ChangeNotifierProvider(create: (_) => VtuProvider()),
  // ChangeNotifierProvider(create: (_) => ForgetPasswordProvider()),
];
