import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../mixins/validator_mixin.dart';
import '../models/record.dart';
import '../repository/client.dart';
import '../utils/form_utils.dart';

enum Operation { create, edit }

class SheetForm extends StatefulWidget with ValidatorMixin {
  final Operation type;
  final Record? record;
  final Function() onRefresh;

  const SheetForm({
    Key? key,
    required this.type,
    this.record,
    required this.onRefresh,
  }) : super(key: key);

  @override
  State<SheetForm> createState() => _SheetFormState();
}

class _SheetFormState extends State<SheetForm> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _formData = {};

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
        top: 16,
        left: 16,
        right: 16,
      ),
      child: Form(
        key: _formKey,
        child: Wrap(
          runSpacing: 10,
          children: [
            Text(
              widget.type == Operation.create
                  ? 'Criar nova ficha'
                  : 'Editar ficha',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextFormField(
              initialValue: widget.record?.name,
              decoration: const InputDecoration(hintText: 'Nome...'),
              validator: (value) =>
                  widget.notEmpty(value, 'Insira um nome para sua ficha'),
              onSaved: (value) => _formData['name'] = value!,
            ),
            TextFormField(
              initialValue: widget.record?.bodyParts,
              decoration: const InputDecoration(hintText: 'Objetivo...'),
              validator: (value) =>
                  widget.notEmpty(value, 'Insira o foco dessa ficha'),
              onSaved: (value) => _formData['bodyParts'] = value!,
            ),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  FormUtils.resetForm(_formKey);

                  final client = GetIt.I.get<ApiClient>();
                  widget.type == Operation.edit
                      ? await client.updateRecordById(widget.record!.id,
                          data: _formData)
                      : await client.createRecord(data: _formData);

                  widget.onRefresh();
                  if (context.mounted) context.pop();
                }
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
              ),
              child: const Text('Salvar treino'),
            ),
          ],
        ),
      ),
    );
  }
}
