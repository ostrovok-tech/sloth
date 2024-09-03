
---
# Code generated by Sloth ({{ .version }}): https://github.com/ostrovok-tech/sloth.
# DO NOT EDIT.

groups:
- name: sloth-slo-alerts-svc01-slo1
  rules:
  - alert: myServiceAlert
    expr: |
      (
          max(slo:sli_error:ratio_rate5m{sloth_id="svc01-slo1", sloth_service="svc01", sloth_slo="slo1"} > (14.4 * 0.0009999999999999432)) without (sloth_window)
          and
          max(slo:sli_error:ratio_rate1h{sloth_id="svc01-slo1", sloth_service="svc01", sloth_slo="slo1"} > (14.4 * 0.0009999999999999432)) without (sloth_window)
      )
      or
      (
          max(slo:sli_error:ratio_rate30m{sloth_id="svc01-slo1", sloth_service="svc01", sloth_slo="slo1"} > (6 * 0.0009999999999999432)) without (sloth_window)
          and
          max(slo:sli_error:ratio_rate6h{sloth_id="svc01-slo1", sloth_service="svc01", sloth_slo="slo1"} > (6 * 0.0009999999999999432)) without (sloth_window)
      )
    labels:
      alert01k1: alert01v1
      alert03k1: alert03v1
      sloth_severity: page
    annotations:
      alert02k1: alert02k2
      summary: '{{"{{$labels.sloth_service}}"}} {{"{{$labels.sloth_slo}}"}} SLO error budget burn
        rate is over expected.'
      title: (page) {{"{{$labels.sloth_service}}"}} {{"{{$labels.sloth_slo}}"}} SLO error budget
        burn rate is too fast.
  - alert: myServiceAlert
    expr: |
      (
          max(slo:sli_error:ratio_rate2h{sloth_id="svc01-slo1", sloth_service="svc01", sloth_slo="slo1"} > (3 * 0.0009999999999999432)) without (sloth_window)
          and
          max(slo:sli_error:ratio_rate1d{sloth_id="svc01-slo1", sloth_service="svc01", sloth_slo="slo1"} > (3 * 0.0009999999999999432)) without (sloth_window)
      )
      or
      (
          max(slo:sli_error:ratio_rate6h{sloth_id="svc01-slo1", sloth_service="svc01", sloth_slo="slo1"} > (1 * 0.0009999999999999432)) without (sloth_window)
          and
          max(slo:sli_error:ratio_rate3d{sloth_id="svc01-slo1", sloth_service="svc01", sloth_slo="slo1"} > (1 * 0.0009999999999999432)) without (sloth_window)
      )
    labels:
      alert01k1: alert01v1
      alert04k1: alert04v1
      sloth_severity: ticket
    annotations:
      alert02k1: alert02k2
      summary: '{{"{{$labels.sloth_service}}"}} {{"{{$labels.sloth_slo}}"}} SLO error budget burn
        rate is over expected.'
      title: (ticket) {{"{{$labels.sloth_service}}"}} {{"{{$labels.sloth_slo}}"}} SLO error budget
        burn rate is too fast.
