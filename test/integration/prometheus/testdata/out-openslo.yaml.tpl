
---
# Code generated by Sloth ({{ .version }}): https://github.com/ostrovok-tech/sloth.
# DO NOT EDIT.

groups:
- name: sloth-slo-sli-recordings-svc01-slo1-0
  rules:
  - record: slo:sli_error:ratio_rate5m
    expr: |-
      (
        1 - (
          (
            sum(rate(http_request_duration_seconds_count{job="myservice",code!~"(5..|429)"}[5m]))
          )
          /
          (
            sum(rate(http_request_duration_seconds_count{job="myservice"}[5m]))
          )
        )
      )
    labels:
      sloth_id: svc01-slo1-0
      sloth_service: svc01
      sloth_slo: slo1-0
      sloth_window: 5m
  - record: slo:sli_error:ratio_rate30m
    expr: |-
      (
        1 - (
          (
            sum(rate(http_request_duration_seconds_count{job="myservice",code!~"(5..|429)"}[30m]))
          )
          /
          (
            sum(rate(http_request_duration_seconds_count{job="myservice"}[30m]))
          )
        )
      )
    labels:
      sloth_id: svc01-slo1-0
      sloth_service: svc01
      sloth_slo: slo1-0
      sloth_window: 30m
  - record: slo:sli_error:ratio_rate1h
    expr: |-
      (
        1 - (
          (
            sum(rate(http_request_duration_seconds_count{job="myservice",code!~"(5..|429)"}[1h]))
          )
          /
          (
            sum(rate(http_request_duration_seconds_count{job="myservice"}[1h]))
          )
        )
      )
    labels:
      sloth_id: svc01-slo1-0
      sloth_service: svc01
      sloth_slo: slo1-0
      sloth_window: 1h
  - record: slo:sli_error:ratio_rate2h
    expr: |-
      (
        1 - (
          (
            sum(rate(http_request_duration_seconds_count{job="myservice",code!~"(5..|429)"}[2h]))
          )
          /
          (
            sum(rate(http_request_duration_seconds_count{job="myservice"}[2h]))
          )
        )
      )
    labels:
      sloth_id: svc01-slo1-0
      sloth_service: svc01
      sloth_slo: slo1-0
      sloth_window: 2h
  - record: slo:sli_error:ratio_rate6h
    expr: |-
      (
        1 - (
          (
            sum(rate(http_request_duration_seconds_count{job="myservice",code!~"(5..|429)"}[6h]))
          )
          /
          (
            sum(rate(http_request_duration_seconds_count{job="myservice"}[6h]))
          )
        )
      )
    labels:
      sloth_id: svc01-slo1-0
      sloth_service: svc01
      sloth_slo: slo1-0
      sloth_window: 6h
  - record: slo:sli_error:ratio_rate1d
    expr: |-
      (
        1 - (
          (
            sum(rate(http_request_duration_seconds_count{job="myservice",code!~"(5..|429)"}[1d]))
          )
          /
          (
            sum(rate(http_request_duration_seconds_count{job="myservice"}[1d]))
          )
        )
      )
    labels:
      sloth_id: svc01-slo1-0
      sloth_service: svc01
      sloth_slo: slo1-0
      sloth_window: 1d
  - record: slo:sli_error:ratio_rate3d
    expr: |-
      (
        1 - (
          (
            sum(rate(http_request_duration_seconds_count{job="myservice",code!~"(5..|429)"}[3d]))
          )
          /
          (
            sum(rate(http_request_duration_seconds_count{job="myservice"}[3d]))
          )
        )
      )
    labels:
      sloth_id: svc01-slo1-0
      sloth_service: svc01
      sloth_slo: slo1-0
      sloth_window: 3d
  - record: slo:sli_error:ratio_rate30d
    expr: |
      sum_over_time(slo:sli_error:ratio_rate5m{sloth_id="svc01-slo1-0", sloth_service="svc01", sloth_slo="slo1-0"}[30d])
      / ignoring (sloth_window)
      count_over_time(slo:sli_error:ratio_rate5m{sloth_id="svc01-slo1-0", sloth_service="svc01", sloth_slo="slo1-0"}[30d])
    labels:
      sloth_id: svc01-slo1-0
      sloth_service: svc01
      sloth_slo: slo1-0
      sloth_window: 30d
- name: sloth-slo-meta-recordings-svc01-slo1-0
  rules:
  - record: slo:objective:ratio
    expr: vector(0.9990000000000001)
    labels:
      sloth_id: svc01-slo1-0
      sloth_service: svc01
      sloth_slo: slo1-0
  - record: slo:error_budget:ratio
    expr: vector(1-0.9990000000000001)
    labels:
      sloth_id: svc01-slo1-0
      sloth_service: svc01
      sloth_slo: slo1-0
  - record: slo:time_period:days
    expr: vector(30)
    labels:
      sloth_id: svc01-slo1-0
      sloth_service: svc01
      sloth_slo: slo1-0
  - record: slo:current_burn_rate:ratio
    expr: |
      slo:sli_error:ratio_rate5m{sloth_id="svc01-slo1-0", sloth_service="svc01", sloth_slo="slo1-0"}
      / on(sloth_id, sloth_slo, sloth_service) group_left
      slo:error_budget:ratio{sloth_id="svc01-slo1-0", sloth_service="svc01", sloth_slo="slo1-0"}
    labels:
      sloth_id: svc01-slo1-0
      sloth_service: svc01
      sloth_slo: slo1-0
  - record: slo:period_burn_rate:ratio
    expr: |
      slo:sli_error:ratio_rate30d{sloth_id="svc01-slo1-0", sloth_service="svc01", sloth_slo="slo1-0"}
      / on(sloth_id, sloth_slo, sloth_service) group_left
      slo:error_budget:ratio{sloth_id="svc01-slo1-0", sloth_service="svc01", sloth_slo="slo1-0"}
    labels:
      sloth_id: svc01-slo1-0
      sloth_service: svc01
      sloth_slo: slo1-0
  - record: slo:period_error_budget_remaining:ratio
    expr: 1 - slo:period_burn_rate:ratio{sloth_id="svc01-slo1-0", sloth_service="svc01",
      sloth_slo="slo1-0"}
    labels:
      sloth_id: svc01-slo1-0
      sloth_service: svc01
      sloth_slo: slo1-0
  - record: sloth_slo_info
    expr: vector(1)
    labels:
      sloth_id: svc01-slo1-0
      sloth_mode: cli-gen-openslo
      sloth_objective: "99.9"
      sloth_service: svc01
      sloth_slo: slo1-0
      sloth_spec: openslo/v1alpha
      sloth_version: {{ .version }}
