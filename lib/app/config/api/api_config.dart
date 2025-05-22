class ApiConfig {
  static const String baseUrl = 'https://reqres.in';
  static const String apiKey = 'reqres-free-v1';

  // API endpoints
  static const String login = '$baseUrl/api/login';
  static const String listUsers = '$baseUrl/api/users?page=2';
  static const String postData = 'https://jsonplaceholder.typicode.com/posts';
}
