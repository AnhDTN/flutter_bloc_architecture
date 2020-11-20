import 'package:demo_login/auth/bloc/auth_bloc.dart';
import 'package:demo_login/auth/bloc/auth_event.dart';
import 'package:demo_login/common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => Home());
  }
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Container(
                  child: Builder(builder: (context) {
                    final phone = context.select(
                            (AuthBloc bloc) => bloc.state.user.phone);
                        return Text("Xin chao $phone");
                  }),

              ),
            ),
            Padding(
              padding: EdgeInsets.all(24),
              child: GestureDetector(
                  onTap: () {
                    context.read<AuthBloc>().add(AuthLogoutRequested());
    },
                  child: Text("logOut")),
            )
          ],
      ),
        ));
  }
}
