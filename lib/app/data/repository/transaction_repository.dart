import 'package:despesas_pessoais/app/data/model/transaction_model.dart';
import 'package:despesas_pessoais/app/data/provider/data_base_helper.dart';


class TransactionRepository {
  DatabaseHelper _instance = DatabaseHelper.instance;

  Future < int > insert( TransactionModel transaction ) async {
    return await _instance.insert(transaction);
  }

   Future < List < Map < String, dynamic > > > query( ) async {
    return await _instance.query( );
  }

  Future < int > delete( int id ) async{
    return await _instance.delete( id );
  }

  Future < int > update( TransactionModel transaction ) async {
    return await _instance.update( transaction );
  }
}