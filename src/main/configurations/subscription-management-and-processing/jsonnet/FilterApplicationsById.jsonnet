local applications = applicationConfig.Applications;
local appIds = [applicationId];

{
   app: [app for app in applications if std.member(appIds, app.applicatie)]
}