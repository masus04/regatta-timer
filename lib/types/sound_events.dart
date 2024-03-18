enum SoundEvent {
  min5(activationTimeStep: Duration(minutes: 5)),
  min4(activationTimeStep: Duration(minutes: 4)),
  min3(activationTimeStep: Duration(minutes: 3)),
  min2(activationTimeStep: Duration(minutes: 2)),
  min1(activationTimeStep: Duration(minutes: 1)),
  sec30(activationTimeStep: Duration(seconds: 30)),
  sec20(activationTimeStep: Duration(seconds: 20)),
  sec10(activationTimeStep: Duration(seconds: 10)),
  sec5(activationTimeStep: Duration(seconds: 5)),
  sec4(activationTimeStep: Duration(seconds: 4)),
  sec3(activationTimeStep: Duration(seconds: 3)),
  sec2(activationTimeStep: Duration(seconds: 2)),
  sec1(activationTimeStep: Duration(seconds: 1)),
  start(activationTimeStep: Duration.zero);

  const SoundEvent({
    required this.activationTimeStep,
  });

  final Duration activationTimeStep;

  get assetName => "sounds/$name.mp3";
}
