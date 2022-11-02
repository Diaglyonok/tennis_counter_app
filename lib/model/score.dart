enum Score {
  score0('0'),
  score15('15'),
  score30('30'),
  score40('40'),
  scoreA('A'),
  scoreWin('Win');

  const Score(this.name);
  final String name;

  Score getNext() {
    if (index < values.length - 1) {
      return values[index + 1];
    }
    return this;
  }
}
