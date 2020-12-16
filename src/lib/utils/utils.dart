
bool matchDate(String t){
  RegExp regExp = new RegExp(
    r"^[0-9][0-9]-[0-9][0-9]-[0-9][0-9][0-9][0-9]",
    caseSensitive: false,
    multiLine: false,
  );
  return regExp.hasMatch(t);
}

bool matchHour(String t){
  RegExp regExp = new RegExp(
    r"^[0-9][0-9]:[0-9][0-9]",
    caseSensitive: false,
    multiLine: false,
  );
  return regExp.hasMatch(t);
}

bool matchRatio(String t){
  RegExp regExp = new RegExp(
    r"^[0-9]:[0-9]",
    caseSensitive: false,
    multiLine: false,
  );
  return regExp.hasMatch(t);
}

