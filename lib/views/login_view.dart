import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:withschools/controllers/auth_controller.dart';
//@clippath styles
import '/styles/login_clippath.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    //@injections --------------------------------------------------------------
    final AuthController authController =
        Get.isRegistered<AuthController>() ? Get.find<AuthController>() : Get.put(AuthController());
    //@-------------------------------------------------------------------------

    return Scaffold(
      body: Obx(
        () {
          return LoadingOverlay(
            isLoading: authController.callbackHelper!.isBusy(related: 'post-signin').isTrue,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      //@clippath 1
                      Opacity(
                        opacity: 0.8,
                        child: ClipPath(
                          clipper: DrawClipLoginShadow(),
                          child: Container(
                            height: Get.height * 0.3,
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.bottomRight,
                                  end: Alignment.bottomLeft,
                                  colors: [Color.fromRGBO(236, 119, 121, 1), Color.fromRGBO(248, 153, 68, 1)]),
                            ),
                          ),
                        ),
                      ),
                      //@clippath 2
                      //* CLIP PATH 2 *******************************************/
                      ClipPath(
                        clipper: DrawClipLogin(),
                        child: Container(
                          height: Get.height * 0.3,
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.bottomRight,
                                end: Alignment.bottomLeft,
                                colors: [Color.fromRGBO(236, 119, 121, 1), Color.fromRGBO(248, 153, 68, 1)]),
                          ),
                        ),
                      ),
                      //@logo
                      Container(
                        height: Get.height * 0.30,
                        alignment: Alignment.center,
                        child: SvgPicture.asset(
                          'assets/app/ws-logo.svg',
                          width: 120,
                          allowDrawingOutsideViewBox: true,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04),
                    child: Column(
                      children: [
                        SizedBox(height: Get.height * 0.03),
                        //* HEADLINE
                        SizedBox(
                          width: Get.width,
                          child: Text(
                            'Connexion',
                            style: Theme.of(context).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                        //* SUBTITLE
                        SizedBox(
                          width: Get.width,
                          child: Text(
                            'Définissez vos identifiants',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                        //* SPACING
                        SizedBox(height: Get.height * 0.03),
                        //* EMAIL OR USERNAME
                        TextFormField(
                          controller: authController.emailTextController,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.account_circle),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            filled: true,
                            hintText: "E-mail ou nom d'utilisateur",
                          ),
                        ),
                        //* SPACING
                        SizedBox(height: Get.height * 0.02),
                        //*
                        TextFormField(
                          controller: authController.passwordTextController,
                          obscureText: true,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.lock),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            filled: true,
                            hintText: 'Mot de passe',
                          ),
                        ),
                        //* SPACING
                        SizedBox(height: Get.height * 0.01),
                        //* RESET PASSWORD
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () => {},
                              child: const Text(
                                'Mot de passe oublié',
                              ),
                            )
                          ],
                        ),
                        //* SPACING
                        SizedBox(height: Get.height * 0.02),
                        ElevatedButton(
                          style: ButtonStyle(
                            minimumSize: MaterialStateProperty.all(Size(Get.width, 50)),
                          ),
                          child: const Text('Connexion'),
                          onPressed: () {
                            authController.postLogin(
                              email: authController.getEmailText,
                              password: authController.getPasswordText,
                            );
                          },
                        ),
                        //* SPACING
                        SizedBox(height: Get.height * 0.03),
                        //* TEXT
                        const Text("Vous n'avez pas de compte ?"),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
