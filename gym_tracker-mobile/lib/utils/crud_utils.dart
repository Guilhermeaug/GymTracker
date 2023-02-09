import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../components/sheet_form.dart';
import '../models/record.dart';

Future<void> showSheetForm(
  BuildContext context, {
  required void Function() onRefresh,
  required Operation type,
  Record? record,
}) async {
  await showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) => SheetForm(
      type: type,
      onRefresh: onRefresh,
      record: record,
    ),
  );
}

void showCrudBottomSheet(
  BuildContext context, {
  required Future<void> Function() onRefresh,
  required Function() onEdit,
  required Future<void> Function() onDelete,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return Container(
        height: 150,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListTile(
              leading: const FaIcon(FontAwesomeIcons.penToSquare),
              title: const Text('Edit'),
              onTap: () => onEdit().then((_) => onRefresh()),
            ),
            ListTile(
              leading: const FaIcon(FontAwesomeIcons.trash),
              title: const Text('Delete'),
              onTap: () {
                onDelete().then((_) => onRefresh());
                context.pop();
              },
            ),
          ],
        ),
      );
    },
  );
}

Widget buildErrorWidget(DioError e) {
  return Center(
    child: Text(
      e.response != null
          ? e.response.toString()
          : 'Não foi possível comunicar com o servidor',
      style: const TextStyle(color: Colors.red),
    ),
  );
}
