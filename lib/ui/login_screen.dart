import 'package:bartender/blocs/login/login_cubit.dart';
import 'package:bartender/blocs/login/login_states.dart';
import 'package:bartender/blocs/logout/logout_cubit.dart';
import 'package:bartender/constants.dart';
import 'package:bartender/dependency_injection.dart';
import 'package:bartender/i18n/bartender_localizations.dart';
import 'package:bartender/ui/drawer/drawer_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class LoginScreen extends StatefulWidget {
  @override
  State createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  void _handleSignIn() {
    final loginCubit = context.cubit<LoginCubit>();
    loginCubit.signIn();
  }

  Widget _buildBody(LoginState state) {
    if (state is LoginEmpty) {
      if (MediaQuery.of(context).orientation == Orientation.portrait) {
        return _buildPortraitBody();
      } else {
        return _buildLandscapeBody();
      }
    } else {
      //login success/ already logged in/ initial
      return Container(
          decoration: BoxDecoration(gradient: blueGradient),
          child: Center(
            child: CircularProgressIndicator(),
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CubitConsumer<LoginCubit, LoginState>(
        builder: (context, state) {
          return _buildBody(state);
        },
        listener: (context, state) {
          if (state is AlreadyLoggedIn || state is LoginSuccess) {
            Navigator.pushAndRemoveUntil(context,
                MaterialPageRoute(builder: (context) {
              return CubitProvider<LogoutCubit>(
                create: (context) => getIt.get<LogoutCubit>(),
                child: DrawerScreen(),
              );
            }), (Route<dynamic> route) => false);
          } else {
            return _buildBody(state);
          }
        },
      ),
    );
  }

  Widget _buildWelcomeImage() {
    return Center(
        child: Image.asset(
      'assets/images/wine.png',
      fit: BoxFit.contain,
    ));
  }

  Widget _buildWelcomeTextsPortrait() {
    return Container(
        margin: EdgeInsets.all(24),
        width: double.infinity,
        child: Row(
          children: [
            Expanded(
                flex: 1,
                child: Container(
                    height: double.infinity,
                    child: RotatedBox(
                      quarterTurns: 1,
                      child: Text(
                        BartenderLocalizations.of(context).actionLogin,
                        style: TextStyle(
                            fontSize: 56,
                            color: Colors.white,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500),
                      ),
                    ))),
            Expanded(
                flex: 3,
                child: Container(
                  height: double.infinity,
                  child: Text(
                    BartenderLocalizations.of(context).bartenderOffer,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ))
          ],
        ));
  }

  Widget _buildWelcomeTextsLandscape() {
    return Row(
      children: [
        Expanded(
            flex: 1,
            child: Container(
                height: double.infinity,
                child: RotatedBox(
                  quarterTurns: 1,
                  child: Text(
                    BartenderLocalizations.of(context).actionLogin,
                    style: TextStyle(
                        fontSize: 48,
                        color: Colors.white,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500),
                  ),
                ))),
        Expanded(
            flex: 3,
            child: Stack(
              children: [
                Text(
                  BartenderLocalizations.of(context).bartenderOffer,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontFamily: 'Poppins',
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: _buildSignInButton(),
                )
              ],
            ))
      ],
    );
  }

  Widget _buildSignInButton() {
    return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          width: double.infinity,
          margin: EdgeInsets.only(top: 24, bottom: 24, left: 8, right: 8),
          child: RaisedButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40.0),
                side: BorderSide(color: Colors.red, width: 2)),
            padding: EdgeInsets.only(left: 8, right: 8, top: 16, bottom: 16),
            onPressed: () => {_handleSignIn()},
            color: Colors.white,
            child: PlatformText(
              BartenderLocalizations.of(context).actionGoogle,
              style: TextStyle(
                fontSize: 16,
                color: Colors.red,
                fontFamily: 'Poppins',
              ),
            ),
          ),
        ));
  }

  Widget _buildPortraitBody() {
    return Container(
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          children: [
            Container(
                height: MediaQuery.of(context).size.height * 0.8,
                child: Stack(
                  children: [
                    Image.asset(
                      'assets/images/drink.jpg',
                      fit: BoxFit.cover,
                    ),
                    _buildWelcomeTextsPortrait(),
                  ],
                )),
            Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                    padding: EdgeInsets.all(24),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.4,
                      child: Material(
                        elevation: 2.0,
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(20.0),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Padding(
                                padding: EdgeInsets.only(top: 24),
                                child: Icon(
                                  Icons.account_circle_sharp,
                                  size: 64,
                                )),
                            Text(
                              BartenderLocalizations.of(context).titleWelcome,
                              style: TextStyle(
                                  fontSize: 28,
                                  color: Colors.black,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500),
                            ),
                            Spacer(),
                            Padding(
                                padding: EdgeInsets.only(left: 24, right: 24),
                                child: _buildSignInButton())
                          ],
                        ),
                      ),
                    )))
          ],
        ));
  }

  Widget _buildLandscapeBody() {
    return Container(
        padding: EdgeInsets.all(48),
        decoration: BoxDecoration(gradient: blueGradient),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: _buildWelcomeImage(),
            ),
            Expanded(
                flex: 3,
                child: Container(
                  margin: EdgeInsets.only(top: 24, bottom: 24),
                  child: _buildWelcomeTextsLandscape(),
                ))
          ],
        ));
  }
}
