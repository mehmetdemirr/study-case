enum ApiItem {
  login,
  users,
}

extension ApiItems on ApiItem {
  String str() {
    switch (this) {
      case ApiItem.login:
        return "/api/login";
      case ApiItem.users:
        return "/api/users?page";
    }
  }
}
