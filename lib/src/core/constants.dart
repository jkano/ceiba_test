const String kAppTitle = 'Prueba de Ingreso';

// API
const String kBaseUrl = 'https://jsonplaceholder.typicode.com';
const String kUserUri = '/users';
const String kPostsUri = '/posts';
String kGetUserPosts(int userId) => '/posts?userId=$userId';

// Database
const String kUsersTableName = 'users_table';
const String kDatabaseName = 'app_database.db';
