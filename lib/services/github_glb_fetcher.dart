import 'package:github/github.dart';

class GlbFile {
  final String name;
  final String downloadUrl;
  final String? thumbnailUrl;

  GlbFile({required this.name, required this.downloadUrl, this.thumbnailUrl});
}

class GitHubGlbFetcher {
  final String username;
  final String repoName;
  final String folderPath;
  final String? token;

  GitHubGlbFetcher({
    required this.username,
    required this.repoName,
    required this.folderPath,
    this.token
  });

  Future<List<GlbFile>> fetchGlbFiles() async {
    final github = token != null
    ? GitHub(auth: Authentication.withToken(token!))
    : GitHub(); // Add auth if needed
    final slug = RepositorySlug(username, repoName);

    try {
      final RepositoryContents contents = await github.repositories.getContents(slug, folderPath);
      final files = contents.tree ?? [];
      
      final glbs = files.where((file) => file.name?.toLowerCase().endsWith('.glb') ?? false);
      final thumbs = Map.fromEntries(files
          .where((f) => f.name?.toLowerCase().endsWith('.png') ?? false)
          .map((f) => MapEntry(f.name!.toLowerCase(), f.downloadUrl)));

      return glbs.map((file) {
        final baseName = file.name!.replaceAll('.glb', '').toLowerCase();
        final thumbUrl = thumbs['$baseName.png'];


        return GlbFile(
          name: file.name!,
          downloadUrl: file.downloadUrl!,
          thumbnailUrl: thumbUrl,
        );
      }).toList();
      
    } catch (e) {
      print("Error fetching GLB files: $e");
      return [];
    }
  }
}