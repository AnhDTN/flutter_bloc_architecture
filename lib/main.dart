import 'package:auth_repository/auth_repository.dart';
import 'package:demo_login/access/colors.dart';
import 'package:demo_login/blocs/CountBloc.dart';
import 'package:demo_login/blocs/CountCubit.dart';
import 'package:demo_login/home/view/home.dart';
import 'package:demo_login/introduction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';

import 'auth/bloc/auth_bloc.dart';
import 'auth/bloc/auth_state.dart';
import 'login/bloc/login_bloc.dart';

void main() => runApp(MyApp(
      authenticationRepository: AuthRepository(),
      userRepository: UserRepository(),
    ));

class MyApp extends StatelessWidget {
  final AuthRepository authenticationRepository;
  final UserRepository userRepository;

  MyApp({Key key, this.authenticationRepository, this.userRepository})
      : assert(authenticationRepository != null),
        assert(userRepository != null),
        super(key: key);

  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: userRepository,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (_) => AuthBloc(
                    authRepository: authenticationRepository,
                    userRepository: userRepository,
                  )),
          BlocProvider(
              create: (context) => LoginBloc(
                  userRepository:
                      RepositoryProvider.of<UserRepository>(context),
                  authBloc: BlocProvider.of<AuthBloc>(context))),
        ],
        child: MaterialApp(
          navigatorKey: _navigatorKey,
          onGenerateRoute: (_) => IntroPage.route(),
          builder: (context, child) {
            return MultiBlocListener(
              listeners: [
                BlocListener<AuthBloc, AuthState>(
                  listener: (context, state) {
                    switch (state.status) {
                      case AuthStatus.authenticated:
                        _navigator.pushAndRemoveUntil<void>(
                          Home.route(),
                          (route) => false,
                        );
                        break;
                      case AuthStatus.unauthenticated:
                        _navigator.pushAndRemoveUntil<void>(
                          IntroPage.route(),
                          (route) => false,
                        );
                        break;
                      default:
                        break;
                    }
                  },
                ),
              ],
              child: child,
            );
          },
          title: 'Flutter Demo',
          theme: ThemeData(
              primarySwatch: Colors.blue,
              accentColor: AppColors.accent100Color,
              primaryColor: AppColors.primary100Color,
              backgroundColor: AppColors.grey25Color,
              buttonColor: AppColors.accent100Color,
              disabledColor: AppColors.grey50Color,
              dividerColor: AppColors.grey75Color,
              textTheme: TextTheme(
                headline1: TextStyle(
                    color: AppColors.black,
                    fontSize: 34,
                    fontWeight: FontWeight.bold),
                headline2: TextStyle(
                    color: AppColors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
                headline3: TextStyle(
                    color: AppColors.black,
                    fontSize: 17,
                    fontWeight: FontWeight.bold),
                headline4: TextStyle(
                    color: AppColors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
                headline5: TextStyle(
                    color: AppColors.black,
                    fontSize: 13,
                    fontWeight: FontWeight.bold),
                headline6: TextStyle(
                    color: AppColors.black,
                    fontSize: 11,
                    fontWeight: FontWeight.normal),
                button: TextStyle(
                    color: AppColors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold),
                caption: TextStyle(
                    color: AppColors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.normal),
                bodyText1: TextStyle(
                    color: AppColors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.normal),
                bodyText2: TextStyle(
                    color: AppColors.black,
                    fontSize: 13,
                    fontWeight: FontWeight.normal),
              ),
              appBarTheme: AppBarTheme(
                color: AppColors.white,
              )),
          home: BlocProvider(
              create: (context) => CountBloc(),
              child: MyHomePage(title: 'Flutter Demo Home Page')),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //Demo basic for cubit and bloc simple
  CountCubit countCubit = CountCubit(10);
  CountBloc countBloc;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    countBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    countBloc = BlocProvider.of<CountBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            BlocBuilder<CountBloc, int>(builder: (context, count) {
              return Text("$count");
            }),
            GestureDetector(
              child: Text("Decrement"),
              onTap: () => countBloc.add(CountEvent.decrement),
            ),
            GestureDetector(
              child: Text("GO HOME"),
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => IntroPage()));
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => countCubit.increment()
        // countBloc.add(CountEvent.increment)
        ,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
