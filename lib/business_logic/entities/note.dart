

class Note{
  Note(this.text, this.time, this.id) : isEdited=false;
  setText(String text){
    this.text = text;
    isEdited = true;
  }
  String text;
  DateTime time;
  int id;
  bool isEdited;
}