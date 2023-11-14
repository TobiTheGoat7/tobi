class LocationSuggestion {
  final String placeId;
  final String description;
  final double latitude;
  final double longitude;

  LocationSuggestion(
      this.placeId, this.description, this.latitude, this.longitude);

  @override
  String toString() {
    return 'Suggestion(description: $description, placeId: $placeId)';
  }
}
