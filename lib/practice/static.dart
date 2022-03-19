void main() {
  Square mySquare = Square();
  mySquare.color = 'red';
  // print(Square().numberOfSquares);
  print(Square.numberOfSquares);
  print(Icosagon.numberOfSquares);

  Circle.workOurCircumference(radius: 20.0);
}

class Square {
  static int numberOfSquares = 4;

  String color;
}

class Icosagon {
  static int numberOfSquares = 20;
}

class Circle {
  static const double pi = 3.1415926;

  static void workOurCircumference({double radius}) {
    double circumference = 2 * pi * radius;

    print(circumference);
  }
}
