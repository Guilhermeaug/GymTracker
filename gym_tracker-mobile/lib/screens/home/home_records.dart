import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../components/record_item.dart';
import '../../components/sheet_form.dart';
import '../../models/record.dart';
import '../../repository/client.dart';
import '../../utils/crud_utils.dart';

class Records extends StatelessWidget {
  final Result<List<Record>, DioError>? records;
  final Future<void> Function() onRefresh;
  final bool isLoading;

  const Records({
    super.key,
    this.records,
    required this.onRefresh,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SizedBox(
      width: size.width * 0.9,
      child: isLoading
          ? const Padding(
              padding: EdgeInsets.all(8.0),
              child: Center(child: CircularProgressIndicator()),
            )
          : records?.when(
              (records) {
                return ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: records.length,
                  itemBuilder: (context, index) {
                    final record = records[index];
                    return InkWell(
                      onTap: () => context.pushNamed(
                        'record',
                        params: {'id': record.id.toString()},
                        queryParams: {'name': record.name},
                      ),
                      onLongPress: () => showCrudBottomSheet(
                        context,
                        onRefresh: onRefresh,
                        onEdit: () => showSheetForm(
                          context,
                          onRefresh: onRefresh,
                          type: Operation.edit,
                          record: record,
                        ),
                        onDelete: () => GetIt.I
                            .get<ApiClient>()
                            .deleteRecordById(record.id),
                      ),
                      child: RecordItem(
                        id: record.id,
                        name: record.name,
                        bodyParts: record.bodyParts,
                      ),
                    );
                  },
                );
              },
              (DioError e) =>
                 buildErrorWidget(e),

            ),
    );
  }
}
