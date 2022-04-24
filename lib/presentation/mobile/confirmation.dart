import 'package:flutter/material.dart';
import 'package:passmanager_diplom/constant/url_pages.dart';
import 'package:passmanager_diplom/domain/model/confirmation.dart'
    as modelConfirmaion;
import 'package:passmanager_diplom/internal/dependencies/repository_module.dart';
import 'package:pinput/pin_put/pin_put.dart';

class Confirmation extends StatefulWidget {
  final modelConfirmaion.Confirmation confirmation;

  const Confirmation({Key? key, required this.confirmation}) : super(key: key);

  @override
  State<Confirmation> createState() =>
      _ConfirmationState(confirmation: confirmation);
}

class _ConfirmationState extends State<Confirmation> {
  final modelConfirmaion.Confirmation confirmation;
  final TextEditingController _pinPutController = TextEditingController();

  _ConfirmationState({required this.confirmation});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
                context, UrlPage.singUp, (route) => false);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.blue,
          ),
        ),
      ),
      body: Builder(builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Подтверждение регистрации",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const Padding(padding: EdgeInsets.all(10)),
                  Center(
                    child: Text(
                      'На ващу почту ${confirmation.login} был выслан код подтверждения. Введите его в форму для подтверждении регистрации.',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  )
                ],
              ),
            ),
            const Padding(padding: EdgeInsets.all(10)),
            SizedBox(
              width: 300,
              height: 45,
              child: PinPut(
                fieldsCount: 5,
                onSubmit: (String pin) {
                  if (pin == confirmation.number.toString()) {
                    RepositoryModule.authRepository()
                        .singUp(
                            userName: confirmation.userName,
                            login: confirmation.login,
                            password: confirmation.password)
                        .then((value) {
                      RepositoryModule.crudRepository().create(user: value);
                      Navigator.pushNamedAndRemoveUntil(
                          context, UrlPage.home, (route) => false);
                    });
                  } else {
                    _showSnackBar(context);
                  }
                },
                focusNode: FocusNode(),
                keyboardType: TextInputType.phone,
                controller: _pinPutController,
                submittedFieldDecoration: BoxDecoration(
                  border: Border.all(color: Colors.blue),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                selectedFieldDecoration: BoxDecoration(
                  border: Border.all(color: Colors.blue),
                  borderRadius: BorderRadius.circular(15),
                ),
                followingFieldDecoration: BoxDecoration(
                  border: Border.all(color: Colors.orange),
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  void _showSnackBar(BuildContext context) {
    const snackBar = SnackBar(
      duration: Duration(seconds: 3),
      content: SizedBox(
        height: 40.0,
        child: Center(
          child: Text(
            'Код не совпадает',
            style: TextStyle(fontSize: 25.0, color: Colors.black),
          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
    Scaffold.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
