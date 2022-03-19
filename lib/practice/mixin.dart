void main() {
  // Animal().move();
  // Duck().move();
  Duck().swim();
  AirPlane().fly();
}

class Animal with canSwim {
  void move() {
    print('Changed position');
  }
}

class Fish extends Animal with canSwim {}
// class Fish extends Animal {
//   @override
//   void move() {
//     super.move();
//     print('by swimming');
//   }
// }

class Bird extends Animal {
  @override
  void move() {
    // TODO: implement move
    super.move();
    print('by flying');
  }
}

mixin canSwim {
  void swim() {
    print('change position by swimming');
  }
}

mixin canFly {
  void fly() {
    print('change position by flying');
  }
}

//with mixin
class Duck extends Animal with canFly, canSwim {}

//without mixin
// class Duck extends Bird {
//   @override
//   void move() {
//   // TODO: implement move
//     super.move();
//     print('swim and fly');
//   }
// }

class AirPlane with canFly {}
