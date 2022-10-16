const String paneParam = 'pane';

enum RoutesData {
  root('/'),
  login('/login'),
  loading('/loading'),
  error('/error'),
  nav('/:pane(dash|users)'),
  dash('/dash'),
  dashInfo('dash_info/:name'),
  users('/users');

  const RoutesData(this.path);
  final String path;
}
