# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

## [0.14.0] - 2024-12-17
### Fixed
- `CI` integration tests for k8s.

### Changed
- Run unit tests for both **PromQL** and **MetricsQL**.

### Added
- `cmd/sloth/commands/k8scontroller` add **--victoriametrics** flag support.

## [0.13.1] - 2024-12-16
### Changed
- Update dependencies versions a bit further.

## [0.13.0] - 2024-12-16
### Changed
- Update dependencies versions.
- `CI` do not build Docker images with branch names, use **development** tag for all builds w/o tag.

## [0.12.2] - 2024-09-10
### Added
- `./scripts/read_changelog.sh` a script to get tag's changes from CHANGELOG.

### Changed
- `CI` **tagged-release-binaries** job makes `softprops/action-gh-release@v2` action.

## [0.12.1] - 2024-09-10
### Fixed
- `CI` do not run **rolling-release-images** job on tags.
- `scripts/build/bin/build-raw.sh` add **-buildvcs=false** flag (`Use -buildvcs=false to always omit version control information`).

## [0.12.0] - 2024-09-09
**WARNING!**
`integration-test-k8s` CI job is disabled because tests don't pass and I've failed to realise why it is so. We don't use Kubernetes related stuff for the time being, so I'm going to address this later in next releases.

### Regression
- Probably generation from [Kebernetes spec](https://sloth.dev/specs/kubernetes/) won't work as expected.

### Fixed
- Recording rules generation after labels changes. Fix was cherry-picked from [kolonialno/sloth](https://github.com/kolonialno/sloth) fork.

### Added
- Support of prometheus expressions validation using [metricsql](https://github.com/VictoriaMetrics/metricsql) from VictoriaMetrics.

### Changed
- Update to **Go 1.23**.
- `docker/dev/Dockerfile` Update **golangci** to **1.60.3**, **mokery** to **2.45.0**, **gomarkdoc** to **1.1.0**.
- Retarget URLs and imports from [slok/sloth](https://github.com/slok/sloth/tree/main) to [ostrovok-tech/sloth](https://github.com/ostrovok-tech/sloth) repository.
- `CI` actions updated, docker build version changed.

## [v0.11.0] - 2022-10-22

### Changed

- Optimized SLI recording rules now have the same labels as the non-optimized ones, avoiding promtool check warnings.
- Update to Go 1.19.
- Update to Kubernetes v1.25.
- `sloth_window` is ignored in alerts reducing the noise of refiring alerts.

## [v0.10.0] - 2022-03-22

## Added

- Support Kubernetes v1.23
- Allow disabling optimized rules using `--disable-optimized-rules`. These will disable the period window (e.g 30d) to be as the other window rules and not be optimized.
- `generate` command now accepts a directory that will discover SLOs and generate with the same structure in an output directory.
- Added `--fs-exclude` and `--fs-include` flags to `generate` command, that will be used when generate inputs are a directory.
- Update Go 1.18

## [v0.9.0] - 2021-11-15

### Added

- Added spec for declaring custom SLO period windows.
- Added `--slo-period-windows-path` flag to load custom SLO period windows from a directory.

### Changed

- (BREAKING) `--window-days` flag renamed to `--default-slo-period` and now is a time.Duration instead of an integer.
- (BREAKING) `-w` short flag has been removed.
- Default 30 and 28 day windows are now loaded from spec files.

## [v0.8.0] - 2021-10-12

### Changed

- OpenSLO fallbacks to Sloths time window if not set.
- Migrated container images from dockerhub to ghcr.io.

### Added

- Time window validation.
- Default time window is 30 day (same as before but was hardcoded, now can be set to a different one).
- Support 28 day time windows.
- Flag to select default time window.

## [v0.7.0] - 2021-10-05

### Added

- Helm chart.
- Kustomize.
- Support Kubernetes 1.22
- The SLO `info` metric has SLO objective as a label.

### Changed

- Update Kubernetes deploy manifests to v0.7.0

## [v0.6.0] - 2021-07-11

### Added

- Model validates SLI event queries (error and total) are different.
- On K8s controller Label selector to shard resources handling by labels.
- On K8s controller Kubernetes dry-run mode for development.
- On K8s controller Kubernetes fake mode for development without Kubernetes cluster.

### Changed

- Generate and validate commands now infer the spec type instead of bruteforce loading every spec type.
- `--development` flag has been renamed to `--kube-local`.

## [v0.5.0] - 2021-06-30

### Added

- OpenSLO support on validate command.
- OpenSLO support on generate command.
- Hot-reload SLI plugins file loader.
- Trigger hot-reload by HTTP webhook.
- Trigger hot-reload by SIGHUP OS signal.
- Added `hot-reload-addr` flag with the hot reload http server address.
- Added `hot-reload-path` flag with the hot reload http server webhookpath webhook.

### Changed

- (Internal) SLI Plugins are retrieved from a repository service instead of getting them from a `map`.

## [v0.4.0] - 2021-06-24

### Added

- Support multiple services per YAML file (multifile).
- Validate cmd.
- Validation SLO spec files autodiscovery.
- Validation include and exclude filter regex for files.

## [v0.3.1] - 2021-06-14

### Added

- Support multi-arch docker images.

### Changed

- Fix CLI `--extra-labels` not being used.

## [v0.3.0] - 2021-06-10

### Added

- SLI plugins support.
- SLI `prometheus/v1` plugins.
- Add SLI plugin settings to `prometheus/v1` spec.
- Add SLI plugin settings to `PrometheusServiceLevel` CRD.
- Make optional alerting `name` field on `PrometheusServiceLevel` CRD.

## [v0.2.0] - 2021-05-24

### Added

- SLO spec `description` field.
- Kubernetes Prometheus CRD status.
- Kubernetes Prometheus CRD status data print for Kubectl.
- Kubernetes controller mode to generate Prometheus-operator CRs from Sloth CRs.
- `controller` command to start Kubernetes controller.
- `version` command to return the app version to stdout.
- `service` and SLO `name` validation.
- Kubernetes controller mode documentation.
- Description field on Prometheus Kubernetes and regular SLO specs.
- Prometheus metrics for Kubernetes controller mode.

### Changed

- (BREAKING) Kubernetes Prometheus CRD manifests uses camelcase instead of snakecase.

### Deleted

- `--version` flag.

## [v0.1.0] - 2021-05-05

### Added

- Extra labels on all prometheus rules at generation cmd execution.
- Specs as an importable API library under `pkg`.
- Prometheus SLO spec.
- Cli for Prometheus generation.
- Generic Multi window multi burn alert generation.
- Prometheus SLI error recording rules.
- Prometheus SLO Metadata recording rules.
- Prometheus Multi window multi burn alert rules.
- Improve 30d SLI error recording rule.
- Disable recording rules generation using flags.
- Disable alert rules generation using flags.
- Support events based SLI.
- Support raw query based SLI.
- Kubernetes (prometheus-operator) CRD generation support.
