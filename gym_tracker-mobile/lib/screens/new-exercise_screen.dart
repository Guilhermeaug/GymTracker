import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../mixins/validator_mixin.dart';
import '../models/exercise.dart';
import '../repository/client.dart';
import '../utils/form_utils.dart';

enum Operation { add, edit }

class NewExerciseScreen extends StatefulWidget with ValidatorMixin {
  final int recordId;
  final String recordName;
  final Operation operation;
  final Exercise? exercise;

  const NewExerciseScreen({
    Key? key,
    required this.recordId,
    required this.recordName,
    required this.operation,
    this.exercise,
  }) : super(key: key);

  @override
  State<NewExerciseScreen> createState() => _NewExerciseScreenState();
}

class _NewExerciseScreenState extends State<NewExerciseScreen> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _formData = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.operation == Operation.add
            ? 'Adicione um exercício'
            : 'Edite o exercício'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          key: _formKey,
          child: Wrap(
            runSpacing: 10,
            children: [
              TextFormField(
                initialValue: widget.exercise?.name,
                decoration: const InputDecoration(hintText: 'Nome...'),
                validator: (value) => widget.notEmpty(
                    value, 'Insira um identificador para o exercício'),
                onSaved: (value) => _formData['name'] = value!,
              ),
              TextFormField(
                initialValue: widget.exercise?.series.toString(),
                decoration: const InputDecoration(hintText: 'Series...'),
                keyboardType: TextInputType.number,
                validator: (value) => widget.combine([
                  () => widget.notEmpty(
                      value, 'Insira quantas séries serão feitas'),
                  () => widget.lessThan(value, 6, 'Insira números entre 1 e 5'),
                ]),
                onSaved: (value) => _formData['series'] = int.parse(value!),
              ),
              TextFormField(
                initialValue: widget.exercise?.repetitions.toString(),
                decoration: const InputDecoration(hintText: 'Repetições...'),
                keyboardType: TextInputType.number,
                validator: (value) => widget.notEmpty(
                    value, 'Insira quantas repetições erão feitas'),
                onSaved: (value) =>
                    _formData['repetitions'] = int.parse(value!),
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    FormUtils.resetForm(_formKey);
                    _formData['recordId'] = widget.recordId;

                    final client = GetIt.I.get<ApiClient>();
                    widget.operation == Operation.add
                        ? await client.createExercise(data: _formData)
                        : await client.updateExerciseById(widget.exercise!.id,
                            data: _formData);

                    if (context.mounted) context.pop();
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(widget.operation == Operation.add
                        ? 'Adicionar'
                        : 'Editar'),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
