public class CaptializeEachWord {

  //Method: To Captialize Every Word In Sentence.
  public static void CaptializeWord() {

    String s = 'iam sharan kumar kolluru';
    String finalString = '';
    Boolean prevCharIsBlank = false;
    String currentString;

    for (Integer i = 0; i < s.length(); i++) {
      currentString = i == 0 || prevCharIsBlank ? s.substring(i, i + 1).toUpperCase() : s.substring(i, i + 1);
      prevCharIsBlank = String.isBlank(currentString) ? true : false;
      finalString += currentString;
    }

    Syste, .debug('Final String :' + finalString);
  }
}
