enum Role {
  admin,
  user;
}

extension RoleEx on String {
  Role toRole() {
    if (this == 'admin') {
      return Role.admin;
    } else {
      return Role.user;
    }
  }
}
