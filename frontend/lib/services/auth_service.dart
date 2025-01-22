class AuthService {
  // Simulated user database with roles
  final Map<String, String> _users = {
    'mark': 'Customer', // Example: Mark is assigned as Project Manager
    'vendor': 'ProjectVendor',
    'executor': 'ProjectExecutor',
    'manager': 'ProjectManager',
    'fieldmen': 'FieldMen'
  };

  // Mock login function (replace this with real authentication)
  String? login(String username, String password) {
    if (username == 'mark' && password == '1234') {
      return 'Customer'; // Redirect Mark to ProjectManager page
    }
    if (_users.containsKey(username)) {
      return _users[username]; // Return user role for other users
    }
    return null; // Invalid login
  }
}
