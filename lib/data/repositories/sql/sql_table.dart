class SqlTable {
  static String genreTableName = 'genre';
  static String projectTableName = 'project';
  static String folderTableName = 'folder';
  static String synopsisTableName = 'synopsis';
  static String noteTableName = 'note';
  static String memoTableName = 'memo';

  static String genreTable =
      '''
  CREATE TABLE IF NOT EXISTS $genreTableName (
    genreId TEXT PRIMARY KEY,
    genreName TEXT
  );
''';

  static String projectTable =
      ''' 
  CREATE TABLE IF NOT EXISTS $projectTableName (
    projectId TEXT PRIMARY KEY,
    projectName TEXT,
    genreId TEXT NOT NULL,
    FOREIGN KEY(genreId) REFERENCES genre(genreId) ON DELETE CASCADE
  );
  ''';

  static String folderTable =
      ''' 
  CREATE TABLE IF NOT EXISTS $folderTableName (
    folderId TEXT PRIMARY KEY,
    folderName TEXT,
    projectId TEXT NOT NULL,
    FOREIGN KEY(projectId) REFERENCES project(projectId) ON DELETE CASCADE
  );
  ''';

  static String synopsisTable =
      '''
  CREATE TABLE IF NOT EXISTS $synopsisTableName (
  synopsisId TEXT PRIMARY KEY,
  synopsisName TEXT,
  synopsisContent TEXT,
  createdAt TEXT,
  updatedAt TEXT,
  folderId TEXT NOT NULL,
  projectId TEXT NOT NULL,
  FOREIGN KEY(folderId) REFERENCES folder(folderId) ON DELETE CASCADE,
  FOREIGN KEY(projectId) REFERENCES project(projectId) ON DELETE CASCADE
  )
''';

  static String noteTable =
      ''' 
  CREATE TABLE IF NOT EXISTS $noteTableName (
    noteId TEXT PRIMARY KEY,
    noteName TEXT,
    noteContent TEXT,
    createdAt TEXT,
    updatedAt TEXT,
    folderId TEXT NOT NULL,
    projectId TEXT NOT NULL,
    FOREIGN KEY(folderId) REFERENCES folder(folderId) ON DELETE CASCADE,
    FOREIGN KEY(projectId) REFERENCES project(projectId) ON DELETE CASCADE
  );
  ''';

  static String memoTable =
      '''
  CREATE TABLE IF NOT EXISTS $memoTableName (
    memoId TEXT PRIMARY KEY,
    memoName TEXT,
    memoContent TEXT,
    createdAt TEXT,
    updatedAt TEXT,
    folderId TEXT NOT NULL,
    projectId TEXT NOT NULL,
    FOREIGN KEY(folderId) REFERENCES folder(folderId) ON DELETE CASCADE,
    FOREIGN KEY(projectId) REFERENCES project(projectId) ON DELETE CASCADE
  );
  ''';
}
