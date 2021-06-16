import 'package:despesas_pessoais/app/controller/transaction_controller.dart';
import 'package:despesas_pessoais/app/ui/android/global_widgets/raised_button_widget.dart';
import 'package:despesas_pessoais/app/ui/android/transaction/widgets/radio_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AlertDialogWidget extends StatelessWidget {
  final String title;
  final String buttonBack;
  final String buttonAciton;

  AlertDialogWidget({this.title, this.buttonAciton, this.buttonBack});

  final _controller = Get.find<TransactionController>();
  static final _formKey = GlobalKey<FormState>();
  

  _showDatePicker(BuildContext context) {
    showDatePicker(
      initialDate: DateTime.now(),
      context: context,
      firstDate: DateTime.now().subtract(Duration(days: 365)),
      lastDate: DateTime.now(),
    ).then(
      (value) {
        if (value == null) {
          return;
        }
        _controller.selectedDate = DateFormat('dd/MM/yyy').format(value);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                textInputAction: TextInputAction.next,
                controller: _controller.descriptionTextController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    labelText: 'Descrição',
                    icon: Icon(Icons.create),
                    hintText: 'Informe uma descrição'),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Informe uma descrição';
                  }
                  return null;
                },
              ),
              TextFormField(
                textInputAction: TextInputAction.send,
                controller: _controller.valueTextController,
                keyboardType: TextInputType.numberWithOptions(),
                decoration: InputDecoration(
                    labelText: 'R\$ 0.00',
                    icon: Icon(Icons.attach_money),
                    hintText: 'Informe uma valor'),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Informe um valor';
                  }
                  return null;
                },
              ),
              RadioButtonWidget(),
              GetBuilder<TransactionController>(
                id: 'date',
                init: TransactionController(),
                builder: (_) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Período',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    FlatButton.icon(
                      onPressed: () => _showDatePicker(context),
                      label: Text('${_.selectedDate}'),
                      icon: Icon(Icons.calendar_today),
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RaisedButtonWidget(
                    iconData: Icons.arrow_back,
                    label: buttonBack,
                    onPressed: () async {
                      await _controller.clearText();
                      Get.back();
                    },
                  ),
                  RaisedButtonWidget(
                    iconData: Icons.check_rounded,
                    label: buttonAciton,
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        _controller.savedTransaction();
                        _controller.getList();
                        Get.back();
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
