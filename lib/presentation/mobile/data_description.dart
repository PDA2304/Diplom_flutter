import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passmanager_diplom/constant/type_table.dart';
import 'package:passmanager_diplom/domain/state/data_description/data_information_cubit.dart';
import 'package:passmanager_diplom/internal/dependencies/generate_color.dart';

class DataDescription extends StatefulWidget {
  const DataDescription(
      {Key? key, required this.dataId, required this.typeTable})
      : super(key: key);
  final int dataId;
  final TypeTable typeTable;
  @override
  State<DataDescription> createState() => _DataDescriptionState();
}

class _DataDescriptionState extends State<DataDescription> {
  @override
  void initState() {
    context.read<DataDescriptionCubit>().init(
          dataId: widget.dataId,
          typeTable: widget.typeTable,
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Описание'),
        centerTitle: true,
      ),
      body: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(
          dragDevices: {
            PointerDeviceKind.touch,
            PointerDeviceKind.mouse,
          },
        ),
        child: SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocBuilder<DataDescriptionCubit, DataDescriptionState>(
                  builder: (context, state) {
                    return Card(
                      elevation: 5.0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 10),
                        child: Container(
                            width: double.infinity,
                            child: state is! DataDescriptionResponse
                                ? Center(child: CircularProgressIndicator())
                                : ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: state
                                        .dataInformation.informationText.length,
                                    itemBuilder: (context, index) => _text(
                                        state.dataInformation
                                            .informationText[index].title,
                                        state.dataInformation
                                            .informationText[index].content),
                                  )

                            // Column(
                            //     mainAxisSize: MainAxisSize.max,
                            //     crossAxisAlignment: CrossAxisAlignment.start,
                            //     children: [
                            //       _text(
                            //           "Владелец", "state.dataInfo.userName!"),
                            //       _text("Дата создания",
                            //           "state.dataInfo.created!"),
                            //       _text("Дата изменения",
                            //           "state.dataInfo.update!"),
                            //     ],
                            //   ),
                            ),
                      ),
                    );
                  },
                ),
                BlocBuilder<DataDescriptionCubit, DataDescriptionState>(
                  builder: (context, state) {
                    return Card(
                      elevation: 5.0,
                      child: InkWell(
                        onDoubleTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const Text(
                                'Управление доступом',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.black),
                              ),
                              state is! DataDescriptionResponse
                                  ? const Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Center(
                                          child: CircularProgressIndicator()),
                                    )
                                  : Row(
                                      children: [
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              68,
                                          height: 50,
                                          child: state.userShareList.isEmpty
                                              ? const Center(
                                                  child: Text(
                                                      'Нет ни одного пользователя'),
                                                )
                                              : ListView.builder(
                                                  shrinkWrap: true,
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  itemCount: state
                                                      .userShareList.length,
                                                  physics:
                                                      const BouncingScrollPhysics(),
                                                  itemBuilder:
                                                      (context, index) {
                                                    return Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 5),
                                                      child: CircleAvatar(
                                                        backgroundColor:
                                                            GenerateColor
                                                                .generate(state
                                                                    .userShareList[
                                                                        index]
                                                                    .userId),
                                                        radius: 20,
                                                        child: Text(
                                                          state
                                                              .userShareList[
                                                                  index]
                                                              .userName[0],
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                        ),
                                      ],
                                    ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
                BlocBuilder<DataDescriptionCubit, DataDescriptionState>(
                  builder: (context, state) {
                    return Card(
                      elevation: 5.0,
                      child: state is! DataDescriptionResponse
                          ? const Padding(
                              padding: EdgeInsets.symmetric(vertical: 15.0),
                              child: Center(child: CircularProgressIndicator()),
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              itemCount: state.historyActionList.length,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    ListTile(
                                      title: Text(state
                                          .historyActionList[index].typeAction),
                                      subtitle: Text(state
                                          .historyActionList[index].userName),
                                      trailing: Text(state
                                          .historyActionList[index].actionDate),
                                      leading: CircleAvatar(
                                        backgroundColor: GenerateColor.generate(
                                            state.historyActionList[index]
                                                .userId),
                                        radius: 20,
                                        child: Text(
                                          state.historyActionList[index]
                                              .userName[0],
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Container(
                                        height: 1,
                                        color: Colors.grey[400],
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _text(String header, String content) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            header,
            style: const TextStyle(fontSize: 18, color: Colors.black),
          ),
          Text(content)
        ],
      ),
    );
  }
}
