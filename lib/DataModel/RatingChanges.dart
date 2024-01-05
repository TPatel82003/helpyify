class RatingChanges {
  int OldRating;
  int NewRating;
  int Rank;
  String ContestName;
  int ContestId;
  RatingChanges({
    required this.NewRating,
    required this.OldRating,
    required this.Rank,
    required this.ContestName,
    required this.ContestId,
  });
}
