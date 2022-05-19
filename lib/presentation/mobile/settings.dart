import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passmanager_diplom/domain/model/user.dart';
import 'package:passmanager_diplom/domain/state/settings/settings_cubit.dart';
import 'package:passmanager_diplom/presentation/widgets/edit_personal_data_user.dart';
import 'package:pinput/pin_put/pin_put.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key, required this.user}) : super(key: key);

  final User user;

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool isEditUserName = false;
  bool isEditLogin = false;

  final _formKeyUserName = GlobalKey<FormState>();
  final _formKeyLogin = GlobalKey<FormState>();
  final _formKeyPassword = GlobalKey<FormState>();

  @override
  void initState() {
    context.read<SettingsCubit>().init(widget.user.userName, widget.user.email);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Настройки'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Card(
              elevation: 10,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Имя пользователя',
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 7.5),
                      child: BlocConsumer<SettingsCubit, SettingsState>(
                        listener: (context, state) {
                          if (state is SettingsNewUserName) {
                            if (_formKeyUserName.currentState!.validate()) {}
                          }
                          if (_formKeyLogin.currentState!.validate()) {}
                        },
                        builder: (context, state) {
                          return Form(
                            key: _formKeyUserName,
                            child: EditPersonalDataUser(
                              maxLength: 30,
                              validation: (value) => context
                                          .read<SettingsCubit>()
                                          .validationNewUserName ==
                                      null
                                  ? null
                                  : context
                                      .read<SettingsCubit>()
                                      .validationNewUserName!
                                      .userName,
                              isChange: context
                                  .read<SettingsCubit>()
                                  .isChangeUserName,
                              isLoad:
                                  context.read<SettingsCubit>().isLoadUserName,
                              save: context.read<SettingsCubit>().saveUserName,
                              content: context
                                  .read<SettingsCubit>()
                                  .userNameController
                                  .text,
                              onSave: () {
                                context
                                    .read<SettingsCubit>()
                                    .newUserName(widget.user.id, context);
                              },
                              controller: context
                                  .read<SettingsCubit>()
                                  .userNameController,
                            ),
                          );
                        },
                      ),
                    ),
                    const Text(
                      'Логин / Почта пользователя',
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 7.5),
                      child: BlocBuilder<SettingsCubit, SettingsState>(
                        builder: (context, state) {
                          return Column(
                            children: [
                              Form(
                                key: _formKeyLogin,
                                child: EditPersonalDataUser(
                                  save: context.read<SettingsCubit>().saveLogin,
                                  validation: (value) => context
                                              .read<SettingsCubit>()
                                              .validationNewLogin ==
                                          null
                                      ? null
                                      : context
                                          .read<SettingsCubit>()
                                          .validationNewLogin!
                                          .login,
                                  maxLength: 30,
                                  content: widget.user.email,
                                  isChange: context
                                      .read<SettingsCubit>()
                                      .isChangeLogin,
                                  isLoad:
                                      context.read<SettingsCubit>().isLoadLogin,
                                  onSave: () {
                                    context
                                        .read<SettingsCubit>()
                                        .confirmationNewLogin(
                                            widget.user.id, context);
                                  },
                                  controller: context
                                      .read<SettingsCubit>()
                                      .loginController,
                                ),
                              ),
                              context.read<SettingsCubit>().isPinCode
                                  ? Container()
                                  : _code(context.read<SettingsCubit>().code,
                                      context)
                            ],
                          );
                        },
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: BlocConsumer<SettingsCubit, SettingsState>(
                            listener: (context, state) {
                              if (_formKeyPassword.currentState!.validate()) {}
                            },
                            builder: (context, state) {
                              return ElevatedButton(
                                onPressed: () {
                                  _shoModal(context);
                                  context
                                      .read<SettingsCubit>()
                                      .newPassword
                                      .text = '';
                                  context
                                      .read<SettingsCubit>()
                                      .oldPassword
                                      .text = '';
                                },
                                child: const Text('Смена пароля'),
                              );
                            },
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _shoModal(BuildContext context) {
    showModalBottomSheet<void>(
      isScrollControlled: true,
      elevation: 5,
      context: context,
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(15),
          child: SizedBox(
            child: Form(
              key: _formKeyPassword,
              child: Wrap(
                children: [
                  TextFormField(
                    validator: (value) =>
                        context.read<SettingsCubit>().validationNewPassword ==
                                null
                            ? null
                            : context
                                .read<SettingsCubit>()
                                .validationNewPassword!
                                .oldPassword,
                    controller: context.read<SettingsCubit>().oldPassword,
                    maxLength: 16,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.lock),
                      border: OutlineInputBorder(),
                      label: Text('Старый пароль'),
                    ),
                  ),
                  const Padding(padding: EdgeInsets.all(4.0)),
                  TextFormField(
                    validator: (value) =>
                        context.read<SettingsCubit>().validationNewPassword ==
                                null
                            ? null
                            : context
                                .read<SettingsCubit>()
                                .validationNewPassword!
                                .newPassword,
                    controller: context.read<SettingsCubit>().newPassword,
                    maxLength: 16,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.lock),
                      border: OutlineInputBorder(),
                      label: Text('Новый пароль'),
                    ),
                  ),
                  const Padding(padding: EdgeInsets.all(4.0)),
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          child: ElevatedButton(
                            child: const Text('Изменить пароль'),
                            onPressed: () {
                              context
                                  .read<SettingsCubit>()
                                  .newPassoword(context, widget.user.id);
                            },
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _code(String code, BuildContext context) {
    return Container(
      width: 250,
      child: PinPut(
        controller: context.read<SettingsCubit>().pinPut,
        fieldsCount: 5,
        onSubmit: (String pin) {
          if (pin == code) {
            setState(() {
              context.read<SettingsCubit>().isPinCode = true;
              context.read<SettingsCubit>().isChangeLogin = true;
              context.read<SettingsCubit>().newLogin(widget.user.id, context);
            });
          } else {
            context.read<SettingsCubit>().pinPut.text = '';
            context.read<SettingsCubit>().pinPut.selection =
                TextSelection(baseOffset: 0, extentOffset: 0);
          }
        },
        focusNode: FocusNode(),
        keyboardType: TextInputType.phone,
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
    );
  }
}
