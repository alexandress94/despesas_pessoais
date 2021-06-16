import 'package:despesas_pessoais/app/data/model/transaction_model.dart';
import 'package:despesas_pessoais/app/data/repository/transaction_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

enum TransactionType {
  recipes,
  expenses,
}

extension TransactionTypeExtension on TransactionType {
  bool get isRecipes => this == TransactionType.recipes;
  bool get isExpenses => this == TransactionType.expenses;
}

class TransactionController extends GetxController {
  @override
  void onReady() {
    // LIMPANDO CAMPO
    clearText();
    // CHAMANDO A LISTA DE TRANSAÇÕES
    getList();
    // SETANDO O VALOR PADRÃO DO RADIO BUTTON AO INICIAR
    _selectedRadio = TransactionType.recipes;
    super.onReady();
  }

  // INSTANCIA DE VARIAVEIS
  final _repository               = TransactionRepository();
  final descriptionTextController = TextEditingController();
  final valueTextController       = TextEditingController();
  TransactionType _selectedRadio  = TransactionType.recipes;
  String _selectedDate            = DateFormat('dd/MM/yyy').format(DateTime.now());
  // RxList transactionModelList     = List<TransactionModel>().obs;
  RxList transactionModelList     = <TransactionModel>[].obs;
  TransactionModel removedTransactions;
  TransactionModel  indexTransaction;

  // SETTER, INFORMANDO A DATA SELECIONADA PELO USÁRIO
  set selectedDate(String date) {
    this._selectedDate = date;
    update(['date']);
  }

  // GETTER, RECEBENDO O VALOR DA DATA SELECIONADA PELO USÁRIO
  get selectedDate => this._selectedDate;

  // SETTER, SETANDO O VALOR DO RADIO BUTTON PELO USÁRIO
  set selectedRadioButton(TransactionType value) {
    this._selectedRadio = value;
    update();
  }

  // GEETER, RECEBENDO O VALOR DO RADIO BUTTON SELECIONADO
  TransactionType get selectedRadioButton => this._selectedRadio;

  // VERIFICANDO SE O VALOR SELECIONADO É 0 OU 1.
  int get isSelected => _selectedRadio == TransactionType.recipes ? 0 : 1;

  // ACUMULANDO O VALOR DA TRANSAÇÃO INFORMADO PELO USUÁRIO
  get totalValue {
    double accumulator = 0.0;
    for (var item in transactionModelList) {
      accumulator += item.value;
    }
    return accumulator;
  }

  // VERIFICANDO SE RECEITA FOI SELECIONADO E ACUMULANDO O VALOR DA TRANSAÇÃO
  get recipes {
    double accumulator = 0.0;
    for (var item in transactionModelList) {
      if (item.radio == 0) {
        accumulator += item.value;
      }
    }
    return accumulator;
  }

  // VERIFICANDO SE DESPESA FOI SELECIONADO E ACUMULANDO O VALOR DA TRANSAÇÃO
  get expenses {
    double accumulator = 0.0;
    for (var item in transactionModelList) {
      if (item.radio == 1) {
        accumulator += item.value;
      }
    }
    return accumulator;
  }

  // INSERIR TRANSAÇÃO CADASTRADA PELO USUÁRIO
  Future<void> savedTransaction(  ) async {
      await this._repository.insert(
          TransactionModel(
            description:  this.descriptionTextController.text,
            value:        double.parse(this.valueTextController.text),
            date:         this._selectedDate,
            radio:        this.isSelected,
            recipes:      this.recipes,
            expenses:     this.expenses,
          ),
        );    
    }


  // INSERI TRANSAÇÃO APÓS USUÁRIO REVETER A REMOVOÇÃO
  Future<void> insertTransactionRemoved() async {
    await this._repository.insert(
          TransactionModel(
            id:           removedTransactions.id,
            description:  removedTransactions.description,
            value:        removedTransactions.value,
            date:         removedTransactions.date,
            radio:        removedTransactions.radio,
            recipes:      removedTransactions.recipes,
            expenses:     removedTransactions.expenses,
          ),
        );
    getList();
  }

  // DELETA TRANSAÇÃO PELO USUÁRIO
  void deleteTransaction(int id) async {
    await _repository.delete(id);
    getList();
  }

  // ATUALIZAR DADOS DA TRANSAÇÃO INFORMADA PELO USUÁRIO
  void updateTransaction(TransactionModel transaction) async {
    await _repository.update(transaction);
    getList();
  }

  
  // LISTA DE TRANSAÇÕES INSERIDAS NO BANCO
  void getList() async {
    // LIMPAR CAMPOS
    clearText();
    List<Map<String, dynamic>> transactionList = await _repository.query();
    this.transactionModelList.value = transactionList
        .map(
          (data) => TransactionModel.fromMap(data),
        )
        .toList();
  }

  // LIMPA OS CAMPOS APÓS INCLUSÃO DE UMA TRANSAÇÃO
  clearText() {
    this.descriptionTextController.text   = '';
    this.valueTextController.text         = '';
    this._selectedDate                    = DateFormat('dd/MM/yyy').format(DateTime.now());
    this._selectedRadio                   = TransactionType.recipes;
  }
}
