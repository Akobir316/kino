// ignore_for_file: prefer_const_constructors, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:kino/resources/resources.dart';
import 'package:kino/widgets/auth/auth_model.dart';

class AuthWidget extends StatefulWidget {
  const AuthWidget({Key? key}) : super(key: key);

  @override
  _AuthWidgetState createState() => _AuthWidgetState();
}

class _AuthWidgetState extends State<AuthWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(AppImages.logo),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            _HeaderWidget(),
          ],
        ),
      ),
    );
  }
}

class _HeaderWidget extends StatelessWidget {
  const _HeaderWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
      fontSize: 15,
    );
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          // ignore: prefer_const_constructors
          SizedBox(
            height: 25,
          ),
          Text('Войти в свою учётную запись',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              )),
          SizedBox(
            height: 15,
          ),
          _FormWidget(),
          SizedBox(
            height: 20,
          ),
          Text(
              'Чтобы пользоваться правкой и возможностями рейтинга TMDB, а также получить персональные рекомендации, необходимо войти в свою учётную запись. Если у вас нет учётной записи, её регистрация является бесплатной и простой.',
              style: textStyle),
          TextButton(
              onPressed: () {},
              child: Text(
                'Registration',
                style: TextStyle(fontSize: 16),
              )),
          Text(
            'Если Вы зарегистрировались, но не получили письмо для подтверждения, ',
            style: textStyle,
          ),
          TextButton(
              onPressed: () {},
              child: Text(
                'Verify email',
                style: TextStyle(fontSize: 16),
              )),
        ],
      ),
    );
  }
}

class _FormWidget extends StatelessWidget {
  const _FormWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = AuthProvider.read(context)?.model;
    const textStyle = TextStyle(
      fontSize: 16,
      color: Color(0xFF212529),
    );
    const textFieldDecoration = InputDecoration(
      isCollapsed: true,
      contentPadding: EdgeInsets.all(12),
      border: OutlineInputBorder(),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      // ignore: prefer_const_literals_to_create_immutables
      children: [
        const _ErrorMessageWidget(),
        Text(
          'Имя пользователя',
          style: textStyle,
        ),
        SizedBox(height: 5),
        TextField(
            controller: model?.loginTextController,
            style: TextStyle(fontSize: 18),
            decoration: textFieldDecoration),
        SizedBox(height: 20),
        Text(
          'Пароль',
          style: textStyle,
        ),
        SizedBox(height: 5),
        TextField(
            controller: model?.passwordTextController,
            obscureText: true,
            style: TextStyle(fontSize: 16),
            decoration: textFieldDecoration),
        SizedBox(
          height: 20,
        ),
        Row(
          children: [
            _AuthButtonWidget(),
            SizedBox(
              width: 30,
            ),
            TextButton(
                onPressed: () {},
                child: Text(
                  'Reset password',
                  style: TextStyle(fontSize: 16),
                )),
          ],
        )
      ],
    );
  }
}

class _AuthButtonWidget extends StatelessWidget {
  const _AuthButtonWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = AuthProvider.watch(context)?.model;
    final onPressed =
        model?.canAuth == true ? () => model?.auth(context) : null;
    final child = model?.isAuthProgress == true
        ? SizedBox(
            width: 15,
            height: 15,
            child: CircularProgressIndicator(
              strokeWidth: 3,
            ),
          )
        : Text(
            'Login',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          );
    return ElevatedButton(
      onPressed: onPressed,
      child: child,
    );
  }
}

class _ErrorMessageWidget extends StatelessWidget {
  const _ErrorMessageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final errorText = AuthProvider.watch(context)?.model.errorMessage;
    if (errorText != null) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 15),
        child: Text(
          '$errorText',
          style: TextStyle(color: Colors.red, fontSize: 17),
        ),
      );
    }
    return SizedBox.shrink();
  }
}
