class EventData {
  String _event_name = "",_event_hour="",_event_date="",_event_dur="",_event_rounds="",_event_a="",_event_b="",_event_ratio="";
  final String name;
  final String hour;
  final String date;
  final String duration;
  final String rounds;
  final String p_a;
  final String p_b;
  final String ratio;

  EventData(this.name, this.hour, this.date, this.duration, this.rounds, this.p_a, this.p_b, this.ratio);
  display(){
    print("Event Name: " + this.name);
    print("Event Date: " + this.date);
    print("Event Hour: " + this.hour);
    print("Event Duration: " + this.duration);
    print("Event Rounds: " + this.rounds);
    print("Event Participant A Number: " + this.p_a);
    print("Event Participant B Number: " + this.p_b);
    print("Event ParticipantRatio: " + this.ratio);

  }
}