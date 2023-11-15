local grr = import 'grizzly/grizzly.libsonnet';
local red = import 'sample-dashboard.jsonnet';

{
  dashboard2: [
    grr.dashboard.new('RED', red)
    + grr.resource.addMetadata('folder', 'General'),
  ],

}