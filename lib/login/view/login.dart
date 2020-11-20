import 'package:demo_login/access/colors.dart';
import 'package:demo_login/access/images.dart';
import 'package:demo_login/login/bloc/login_bloc.dart';
import 'package:demo_login/login/bloc/login_event.dart';
import 'package:demo_login/login/bloc/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => LoginPage());
  }

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  AnimationController _animationController;
  Animation<Color> _colorTween;

  @override
  void initState() {
    _animationController =
        AnimationController(duration: Duration(milliseconds: 300), vsync: this);
    _colorTween = _animationController.drive(ColorTween(
        begin: AppColors.primary100Color, end: AppColors.green100Color));
    _animationController.repeat();

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }

  Widget inputForm() {
    return Container(
      child: Column(
        children: [
          BlocBuilder<LoginBloc, LoginState>(
            buildWhen: (preState, nextState) =>
                preState.phone != nextState.phone,
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.only(top: 48),
                child: TextFormField(
                    controller: emailController,
                    onChanged: (phone) =>
                        context.read<LoginBloc>().add(LoginPhoneChange(phone)),
                    decoration: InputDecoration(
                        hintText: "Email or phone number",
                        fillColor: Colors.white,
                        filled: true,
                        errorText: state.status == LoginStatus.phoneInvalidated
                            ? "Phone error"
                            : null,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: BorderSide(color: AppColors.white),
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide: BorderSide(color: AppColors.white)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide: BorderSide(color: AppColors.white)),
                        focusColor: AppColors.white)),
              );
            },
          ),
          BlocBuilder<LoginBloc, LoginState>(
              buildWhen: (preState, nextState) =>
                  preState.pass != nextState.pass,
              builder: (context, state) {
                return Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: TextFormField(
                      controller: passController,
                      onChanged: (password) => context
                          .read<LoginBloc>()
                          .add(LoginPassChange(password)),
                      decoration: InputDecoration(
                          hintText: "Password",
                          fillColor: Colors.white,
                          filled: true,
                          errorText: state.status == LoginStatus.passInvalidated
                              ? "Password error"
                              : null,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide: BorderSide(color: AppColors.white),
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                              borderSide: BorderSide(color: AppColors.white)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                              borderSide: BorderSide(color: AppColors.white)),
                          focusColor: AppColors.white)),
                );
              })
        ],
      ),
    );
  }

  Widget loginButton() {
    return BlocBuilder<LoginBloc, LoginState>(
        buildWhen: (pre, next) => pre.status != next.status,
        builder: (context, state) {
          return state?.status == LoginStatus.inProgress
              ? Container(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: CircularProgressIndicator(
                      valueColor: _colorTween,
                    ),
                  ),
                )
              : Container(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 24),
                    child: GestureDetector(
                      child: Container(
                        height: 48,
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 1, color: AppColors.blue100Color),
                            borderRadius: BorderRadius.all(Radius.circular(6)),
                            color: Colors.blue),
                        child: Text(
                          "LOG IN",
                          style: Theme.of(context).textTheme.button,
                        ),
                      ),
                      onTap: () => {
                        state.status == LoginStatus.validated
                            ? context
                                .read<LoginBloc>()
                                .add(const LoginSubmitted())
                            : null
                      },
                    ),
                  ),
                );
        });
  }

  Widget loginForm() {
    return Container(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 28, right: 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 128),
                    child: Text(
                      "Welcome Back",
                      style: Theme.of(context).textTheme.headline2,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      "Please log in to your account",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                  inputForm(),
                  loginButton(),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text(
                      "Forgot Password?",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2
                          .copyWith(color: AppColors.blue100Color),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Text(
                        "Don't have account?",
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text("Register new?",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2
                              .copyWith(color: AppColors.blue100Color)),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 70),
                      child: Text("Or log in with",
                          style: Theme.of(context).textTheme.bodyText1),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: GestureDetector(
                              child: Container(
                                height: 48,
                                alignment: Alignment.center,
                                color: Colors.white,
                                child: Row(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  children: [
                                    Center(
                                        child: Image.asset(
                                          ImageName.facebook,
                                          width: 16,
                                          height: 16,
                                        )),
                                    Padding(
                                      padding:
                                      const EdgeInsets.only(left: 8),
                                      child: Text(
                                        "Facebook",
                                        style: Theme.of(context)
                                            .textTheme
                                            .button
                                            .copyWith(
                                            color:
                                            AppColors.blue100Color),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: GestureDetector(
                              child: Container(
                                height: 48,
                                color: Colors.white,
                                child: Row(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  children: [
                                    Center(
                                        child: Image.asset(
                                          ImageName.google,
                                          width: 16,
                                          height: 16,
                                        )),
                                    Padding(
                                      padding:
                                      const EdgeInsets.only(left: 8),
                                      child: Text(
                                        "Google",
                                        style: Theme.of(context)
                                            .textTheme
                                            .button
                                            .copyWith(
                                            color:
                                            AppColors.red100Color),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        appBar: AppBar(
          leadingWidth: 100,
          leading: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Container(
                  height: 24,
                  width: 24,
                  child: Center(
                    child: Image.asset(
                      ImageName.back,
                      height: 24,
                      width: 24,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Text(
                "Back",
                style: TextStyle(
                    color: AppColors.blue100Color,
                    fontSize: 17,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
          toolbarHeight: 44,
        ),
        body: BlocListener<LoginBloc, LoginState>(
          listenWhen: (pre, next) => pre.status != next.status,
          listener: (context, state) {
            if (state.status == LoginStatus.fail) {
              final snackBar = SnackBar(
                content: Text('Login Fail, Please try again!!'),
                action: SnackBarAction(
                  label: 'Undo',
                  onPressed: () {
                    // Some code to undo the change.
                  },
                ),
              );
              Scaffold.of(context).showSnackBar(snackBar);
            } else if (state.status == LoginStatus.done) {}
          },
          child: loginForm()
        ),
    );
  }
}
