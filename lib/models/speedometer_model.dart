class Speedometer{

  int time10_30;
  int time30_10;
  int range;
  double currentSpeed;

  Speedometer({
    required this.time10_30,
    required this.time30_10,
    this.range= LESS_10,
    required this.currentSpeed,
});
}

const FROM_10_TO_30 = 1;
const FROM_30_TO_10 =2;
const LESS_10 = 0;
const OVER_30 = 3;
const SPEED_10 =10;
const SPEED_30 = 30;