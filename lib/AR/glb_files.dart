import '../services/github_glb_fetcher.dart';

Future<List<GlbFile>> fetchGlbFilesForCategory(String category) {
return GitHubGlbFetcher(
      username: 'AmanyYaseen16',
      repoName: 'ar_data',
      folderPath: 'models/${category.toLowerCase()}', // e.g. 'assets/models'
      token: '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',
    ).fetchGlbFiles();
  }
