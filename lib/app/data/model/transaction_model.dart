class TransactionModel {
  int     id;
  String  description;
  double  value;
  String  date;
  int     radio;
  double  recipes;
  double  expenses;

  TransactionModel({
    this.id,
    this.description,
    this.value,
    this.date,
    this.radio,
    this.recipes,
    this.expenses,
  });

  // Para incluir dados no SQLite, precisa converter para um MAP
  Map < String, dynamic > toMap() {
    var map = {
      'id':           id,
      'description':  description,
      'value':        value,
      'date':         date,
      'radio':        radio,
      'recipes':      recipes,
      'expenses':     expenses,
    };
    return map;
  }

  // Para retornar dados no SQLite, precisa converter de MAP para um Objeto
  TransactionModel.fromMap( Map < String, dynamic > map ) {
    id          = map['id'];
    description = map['description'];
    value       = map['value'];
    date        = map['date'];
    radio       = map['radio'];
    recipes     = map['recipes'];
    expenses    = map['expenses'];
  }
}
