abstract class QuotesDatasource {
  Future<Stream<Map<String, dynamic>>> retrieveQuotes();
  dispose();
}
