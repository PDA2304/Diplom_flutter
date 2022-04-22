import 'package:flutter/material.dart';
import 'package:passmanager_diplom/constant/url_pages.dart';
import 'package:pinput/pin_put/pin_put.dart';

class Confirmation extends StatefulWidget {
  const Confirmation({Key? key}) : super(key: key);

  @override
  State<Confirmation> createState() => _ConfirmationState();
}

class _ConfirmationState extends State<Confirmation> {
  TextEditingController _pinPutController = TextEditingController();

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
                children: const [
                  Text(
                    "Подтверждение регистрации",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Padding(padding: EdgeInsets.all(10)),
                  Center(
                    child: Text(
                      'На ващу почту  был выслан код подтверждения. Введите его в форму для подтверждении регистрации.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
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
                onSubmit: (String pin) {},
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
}
