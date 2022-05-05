import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passmanager_diplom/domain/model/validation_notes.dart';
import 'package:passmanager_diplom/domain/state/notes/notes_cubit.dart';

class NotesAdd extends StatefulWidget {
  const NotesAdd({Key? key, required this.userId}) : super(key: key);
  final int userId;

  @override
  State<NotesAdd> createState() => _NotesAddState();
}

class _NotesAddState extends State<NotesAdd> {
  ValidationNotes? _valid;
  String _notesName = '';
  String _content = '';
  String _description = '';
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Добавление заметки'),
      ),
      body: BlocConsumer<NotesCubit, NotesState>(
        listener: (context, state) {
          if (state is NotesAddResponse) {
            if (state.isSeccus) Navigator.pop(context);
            _valid = state.notes.validationNotes;
          }
          if (_formKey.currentState!.validate()) {}
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(children: [
              _form(),
              (state is NotesLoad)
                  ? CircularProgressIndicator()
                  : Container(
                      height: 45,
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        onPressed: () {
                          context.read<NotesCubit>().notesCreate(
                                notesName: _notesName,
                                content: _content,
                                description: _description,
                                userId: widget.userId,
                              );
                        },
                        child: const Text('Добавить заметку'),
                      ),
                    )
            ]),
          );
        },
      ),
    );
  }

  Widget _form() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            validator: (value) => _valid == null ? null : _valid!.notesName,
            onChanged: (value) => _notesName = value,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Купить в магазине*',
              label: Text('Название'),
            ),
            maxLength: 30,
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
          TextFormField(
            validator: (value) => _valid == null ? null : _valid!.content,
            onChanged: (value) => _content = value,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Молоко. Сахар. Конфеты',
              label: Text('Содержимое заметки'),
            ),
            minLines: 1,
            maxLines: 3,
            maxLength: 512,
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
          TextFormField(
            onChanged: (value) => _description = value,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              label: Text('Описание'),
            ),
            minLines: 1,
            maxLines: 3,
            maxLength: 256,
          ),
        ],
      ),
    );
  }
}
