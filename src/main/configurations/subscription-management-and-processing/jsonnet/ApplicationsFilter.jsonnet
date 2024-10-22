local applications = std.parseJson(applicationConfig).Applications;
local appIds = [row.APP_ID for row in payload.rowset];

{
   urls: [app.url for app in applications if std.member(appIds, app.appId)]
}