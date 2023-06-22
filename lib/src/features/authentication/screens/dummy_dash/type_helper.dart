class TypesHelper {
  static int toInt(int val) {
    try {
      if (val == null) {
        return 0;
      }
      // ignore: unnecessary_type_check
      if (val is int) {
        return val;
      } else {
        return val.toInt();
      }
    } catch (error) {
      print('Error');
      return 0;
    }
  }
}
