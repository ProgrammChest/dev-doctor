import 'dart:convert';

import 'package:animations/animations.dart';
import 'package:dev_doctor/editor/bloc/server.dart';
import 'package:dev_doctor/editor/create.dart';
import 'package:dev_doctor/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class EditorPage extends StatefulWidget {
  @override
  _EditorPageState createState() => _EditorPageState();
}

class _EditorPageState extends State<EditorPage> {
  Box<String> _box = Hive.box<String>('editor');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(title: 'editor.title'.tr()),
        body: ValueListenableBuilder(
            valueListenable: _box.listenable(),
            builder: (context, value, child) => Scrollbar(
                child: ListView.builder(
                    itemCount: _box.length,
                    itemBuilder: (context, index) {
                      var item = json.decode(_box.getAt(index));
                      var bloc = ServerEditorBloc.fromJson(item);
                      return Dismissible(
                          key: Key(_box.name),
                          background: Container(color: Colors.red),
                          onDismissed: (direction) {
                            _box.deleteAt(index);
                          },
                          child:
                              ListTile(title: Text(bloc.server.name), subtitle: Text(bloc.note)));
                    }))),
        floatingActionButton: OpenContainer(
            transitionType: ContainerTransitionType.fadeThrough,
            transitionDuration: Duration(milliseconds: 750),
            openBuilder: (context, _) => CreateServerPage(),
            closedShape: CircleBorder(),
            closedBuilder: (context, openContainer) => FloatingActionButton(
                onPressed: openContainer,
                child: Icon(Icons.add_outlined),
                tooltip: "editor.create.fab".tr())));
  }
}
