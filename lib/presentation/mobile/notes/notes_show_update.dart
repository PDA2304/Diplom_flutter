import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passmanager_diplom/domain/model/notes.dart';
import 'package:passmanager_diplom/domain/model/validation_notes.dart';
import 'package:passmanager_diplom/domain/state/notes/notes_cubit.dart';
import 'package:passmanager_diplom/presentation/widgets/custom_filed.dart';

class NotesShowUpdate extends StatefulWidget {
  const NotesShowUpdate({Key? key, required this.notes}) : super(key: key);
  final Notes notes;

  @override
  State<NotesShowUpdate> createState() => _NotesShowUpdateState();
}

class _NotesShowUpdateState extends State<NotesShowUpdate> {
  TextEditingController notesNameController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  ValidationNotes? _validNotes;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    notesNameController.text = widget.notes.notesName;
    contentController.text = widget.notes.content;
    descriptionController.text = widget.notes.description;
    super.initState();
  }

  void cancel() {
    setState(() {
      notesNameController.text = widget.notes.notesName;
      TextPosition(offset: notesNameController.text.length);
      contentController.text = widget.notes.content;
      TextPosition(offset: contentController.text.length);
      descriptionController.text = widget.notes.description;
      TextPosition(offset: descriptionController.text.length);
      if (_formKey.currentState!.validate()) {}
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Просмотр / Изменнение заметки'),
        actions: [
          PopupMenuButton(
              itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 0,
                      child: Row(
                        children: const [
                          Padding(
                            padding: EdgeInsets.only(right: 10),
                            child: Icon(
                              Icons.info_outline,
                              color: Colors.blue,
                            ),
                          ),
                          Text('Описание')
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 1,
                      child: Row(
                        children: const [
                          Padding(
                            padding: EdgeInsets.only(right: 10),
                            child: Icon(
                              Icons.group_add_sharp,
                              color: Colors.blue,
                            ),
                          ),
                          Text('Поделиться данными')
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 2,
                      child: Row(
                        children: const [
                          Padding(
                            padding: EdgeInsets.only(right: 10),
                            child: Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          ),
                          Text('Удалить')
                        ],
                      ),
                    )
                  ],
              onSelected: (item) {
                switch (item) {
                  case 0:
                    {
                      break;
                    }
                  case 1:
                    {
                      break;
                    }
                  case 2:
                    {
                      context
                          .read<NotesCubit>()
                          .notesDelete(id: widget.notes.id);
                      Navigator.pop(context);
                      break;
                    }
                  default:
                    {
                      break;
                    }
                }
              },
              icon: const Icon(Icons.more_vert_outlined))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: BlocConsumer<NotesCubit, NotesState>(
          listener: (context, state) {
            if (state is NotesUpdate) {
              state.isSeccus
                  ? Navigator.pop(context)
                  : _validNotes = state.notes.validationNotes;
            }
            if (_formKey.currentState!.validate()) {}
          },
          builder: (context, state) {
            return Column(
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomField(
                        validation: (value) =>
                            _validNotes == null ? null : _validNotes!.notesName,
                        controller: notesNameController,
                        labelText: 'Название заметки',
                        maxLength: 30,
                      ),
                      const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                      CustomField(
                        validation: (value) =>
                            _validNotes == null ? null : _validNotes!.content,
                        controller: contentController,
                        labelText: 'Содержимое заметки',
                        minLines: 1,
                        maxLines: 3,
                        maxLength: 512,
                      ),
                      const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                      CustomField(
                        validation: (value) => _validNotes == null
                            ? null
                            : _validNotes!.description,
                        controller: descriptionController,
                        labelText: 'Описание',
                        minLines: 1,
                        maxLines: 3,
                        maxLength: 256,
                      ),
                    ],
                  ),
                ),
                const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                Row(
                  children: [
                    Expanded(child: Container()),
                    SizedBox(
                      height: 35,
                      child: ElevatedButton(
                        onPressed: () => cancel(),
                        child: const Text(
                          'Отмена',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                    const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10)),
                    SizedBox(
                      height: 35,
                      child: ElevatedButton(
                        onPressed: () {
                          context.read<NotesCubit>().notesUpdate(
                                notesId: widget.notes.id,
                                notesName: notesNameController.text,
                                content: contentController.text,
                                description: descriptionController.text,
                              );
                        },
                        child: const Text(
                          'Сохранить',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
