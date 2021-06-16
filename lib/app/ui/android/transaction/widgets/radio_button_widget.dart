import 'package:despesas_pessoais/app/controller/transaction_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RadioButtonWidget extends GetWidget {
  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GetBuilder<TransactionController>(
            init: TransactionController(),
            builder: (_) {
              return ButtonBar(
                alignment: MainAxisAlignment.center,
                children: [
                  Text('Receita'),
                  Radio(
                    value: TransactionType.recipes,
                    groupValue: _.selectedRadioButton,
                    onChanged: (TransactionType value) {
                      _.selectedRadioButton = value;
                    },
                  ),
                  Text('Despesa'),
                  Radio(
                    value: TransactionType.expenses,
                    groupValue: _.selectedRadioButton,
                    onChanged: (TransactionType value) {
                      _.selectedRadioButton = value;
                    },
                  ),
                ],
              );
            },
          )
        ],
      ),
    );
  }
}
