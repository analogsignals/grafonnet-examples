local g = import 'github.com/grafana/grafonnet/gen/grafonnet-latest/main.libsonnet';

g.dashboard.new('RED Dashboard')
+ g.dashboard.withUid('grafonnet-demo')
+ g.dashboard.withDescription('Sample RED Dashboard')
+ g.dashboard.graphTooltip.withSharedCrosshair()
+ g.dashboard.time.withFrom(value="now-5m")
+ g.dashboard.withPanels([
  g.panel.timeSeries.new('Requests')
  + g.panel.timeSeries.queryOptions.withTargets([
    g.query.prometheus.new(
      'mimir',
      '(sum by (http_target)(rate(traces_spanmetrics_latency_sum{http_target=~"/beholder|/illithid|/manticore|/owlbear|/unicorn"}[1m]))) / (sum by (http_target)(rate(traces_spanmetrics_latency_count{http_target=~"/beholder|/illithid|/manticore|/owlbear|/unicorn"}[1m]))) * 55',
    ),
  ])
  + g.panel.timeSeries.standardOptions.withUnit('reqps')
  + g.panel.timeSeries.fieldConfig.defaults.custom.withLineWidth(1)
  + g.panel.timeSeries.fieldConfig.defaults.custom.withFillOpacity(57)
  + g.panel.timeSeries.gridPos.withW(24)
  + g.panel.timeSeries.gridPos.withH(8),

  g.panel.timeSeries.new('Error Rate')
  + g.panel.timeSeries.queryOptions.withTargets([
    g.query.prometheus.new(
      'mimir',
      'sum(rate(traces_spanmetrics_calls_total{span_kind="SPAN_KIND_SERVER",http_target!~"/debug/pprof.*",status_code="STATUS_CODE_ERROR",http_target=~"/beholder|/illithid|/manticore|/owlbear|/unicorn"}[1m])) by (http_target)'
),
  ])
  + g.panel.timeSeries.standardOptions.withUnit('reqps')
  + g.panel.timeSeries.gridPos.withW(24)
  + g.panel.timeSeries.gridPos.withH(8),





])
