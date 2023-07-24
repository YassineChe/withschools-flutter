import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:withschools/bindings/auth_binding.dart';
import 'package:withschools/bindings/init_binding.dart';
import 'package:withschools/bindings/supervisor_clue_binding.dart';
import 'package:withschools/middlewares/guards_middleware.dart';
import 'package:withschools/views/login_view.dart';
import 'package:withschools/views/supervisor/supervisor_clue_view.dart';
import 'package:withschools/themes/color_schemes.dart';

//@constants
import 'configs/colors.dart';

Future<void> main() async {
  //* WAiT To INIt ************************************************************/
  WidgetsFlutterBinding.ensureInitialized();
  //***************************************************************************/

  //Init GetStorage
  await GetStorage.init();
  //Run app
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: InitBinding(),
      debugShowCheckedModeBanner: false,
      title: 'WithSchools',
      //@themes schemes light
      theme: ThemeData(
        useMaterial3: true,
        textTheme: GoogleFonts.jostTextTheme(),
        colorScheme: lightColorScheme,
        appBarTheme: const AppBarTheme(
          centerTitle: false,
        ),
      ),
      //@themes schemes dark
      darkTheme: ThemeData(
        useMaterial3: true,
        textTheme: GoogleFonts.jostTextTheme(),
        colorScheme: darkColorScheme,
        appBarTheme: const AppBarTheme(centerTitle: false),
      ),
      // themeMode: ThemeMode.dark,
      //@pages
      getPages: [
        //? ---------------------- SUERBVISOR VIEWS ------------------------? //
        GetPage(
          name: '/loginView',
          page: () => const LoginView(),
          binding: AuthBinding(),
          middlewares: [GuardsMiddleware()],
        ),
        GetPage(
          name: '/supervisorClueView',
          page: () => const SupervisorClueView(),
          binding: SupervisorClueBinding(),
        )
      ],
      initialRoute: '/loginView',
    );
  }
}
