import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/models/task.dart';

class TaskDialog extends StatefulWidget {
  final Task task;

  TaskDialog({this.task});

  @override
  _TaskDialogState createState() => _TaskDialogState();
}

class _TaskDialogState extends State<TaskDialog> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priorityController = TextEditingController();

  Task _currentTask = Task();

  @override
  void initState() {
    super.initState();

    if (widget.task != null) {
      _currentTask = Task.fromMap(widget.task.toMap());
    }

    _titleController.text = _currentTask.title;
    _descriptionController.text = _currentTask.description;
    _priorityController.text = _currentTask.priority;
  }

  @override
  void dispose() {
    super.dispose();
    _titleController.clear();
    _descriptionController.clear();
    _priorityController.clear();
  }

  String cor;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: AlertDialog(
        title: Text(widget.task == null ? 'Nova tarefa' : 'Editar tarefas'),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Título'),
                autofocus: true),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Descrição'),
              keyboardType: TextInputType.multiline,
              maxLines: 2,
            ),
            TextField(
              controller: _priorityController,
              keyboardType: TextInputType.numberWithOptions(),
              maxLength: 1,
              decoration: InputDecoration(labelText: 'Prioridade de 1 a 5'),
            ),
          ],
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('Cancelar'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          FlatButton(
            child: Text('Salvar'),
            onPressed: () {
              if (_titleController.value.text != "" &&
                  (int.tryParse(_priorityController.text) > 0 &&
                      int.tryParse(_priorityController.text) < 6)) {
                if (int.tryParse(_priorityController.text) == 1) {
                  cor = "#FFFFFF";
                } else if (int.tryParse(_priorityController.text) == 2) {
                  cor = "#CCFFCC";
                } else if (int.tryParse(_priorityController.text) == 3) {
                  cor = "#66CCFF";
                } else if (int.tryParse(_priorityController.text) == 4) {
                  cor = "#0099CC";
                } else if (int.tryParse(_priorityController.text) == 5) {
                  cor = "#4682B4";
                }
                _currentTask.priority = cor ;
                _currentTask.title = _titleController.value.text;
                _currentTask.description = _descriptionController.text;
                Navigator.of(context).pop(_currentTask);
              } else {
                Flushbar(
                  title: "Entrada invalida",
                  message: "Verifique todos os campos",
                  margin: EdgeInsets.all(8),
                  borderRadius: 8,
                  duration: Duration(seconds: 3),
                )..show(context);
              }
            },
          ),
        ],
      ),
    );
  }
}
