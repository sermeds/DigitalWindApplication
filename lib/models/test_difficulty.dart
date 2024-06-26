enum Difficulty{
  easy, medium, hard;

  @override
  String toString(){
    switch(this){
      
      case Difficulty.easy:
        return "легко";
      case Difficulty.medium:
        return "средне";
      case Difficulty.hard:
        return "тяжело";
    }
  }

  factory Difficulty.fromJson(int index) => Difficulty.values[index];

  int toJson() => index;
}

