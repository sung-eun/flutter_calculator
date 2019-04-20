final String tableHistory = 'histories';
final String columnId = 'id';
final String columnExpression = 'expression';
final String columnResult = 'result';

class HistoryData {
  int id;
  String expression;
  String result;

  HistoryData(this.expression, this.result);

  // convenience constructor to create a Word object
  HistoryData.fromMap(Map<String, dynamic> map) {
    id = map[columnId];
    expression = map[columnExpression];
    result = map[columnResult];
  }

  // convenience method to create a Map from this Word object
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnExpression: expression,
      columnResult: result
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }
}
