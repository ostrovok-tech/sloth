package prometheus

import (
	"context"
	"fmt"
	"io"

	prommodel "github.com/prometheus/common/model"
	"github.com/prometheus/prometheus/pkg/rulefmt"
	"gopkg.in/yaml.v2"

	"github.com/slok/sloth/internal/log"
)

func NewIOWriterGroupedRulesYAMLRepo(writer io.Writer, logger log.Logger) IOWriterGroupedRulesYAMLRepo {
	return IOWriterGroupedRulesYAMLRepo{
		writer: writer,
		logger: logger.WithValues(log.Kv{"svc": "storage.IOWriter", "format": "yaml"}),
	}
}

// IOWriterGroupedRulesYAMLRepo knows to store all the SLO rules (recordings and alerts)
// grouped in an IOWriter in YAML format, that is compatible with Prometheus.
type IOWriterGroupedRulesYAMLRepo struct {
	writer io.Writer
	logger log.Logger
}

type StorageSLO struct {
	SLO   SLO
	Rules SLORules
}

// StoreSLOs will store the recording and alert prometheus rules, if grouped is false it will
// split and store as 2 different groups the alerts and the recordings, if true
// it will be save as a single group.
func (i IOWriterGroupedRulesYAMLRepo) StoreSLOs(ctx context.Context, slos []StorageSLO) error {
	err := i.storeGrouped(slos)
	if err != nil {
		return fmt.Errorf("could not store SLOS: %w", err)
	}

	return nil
}

func (i IOWriterGroupedRulesYAMLRepo) storeGrouped(slos []StorageSLO) error {
	if len(slos) == 0 {
		return fmt.Errorf("slo rules required")
	}

	ruleGroups := ruleGroupsYAMLv2{}
	for _, slo := range slos {
		if len(slo.Rules.SLIErrorRecRules) > 0 {
			ruleGroups.Groups = append(ruleGroups.Groups, ruleGroupYAMLv2{
				Name:  fmt.Sprintf("sloth-slo-sli-recordings-%s", slo.SLO.ID),
				Rules: slo.Rules.SLIErrorRecRules,
			})
		}

		if len(slo.Rules.MetadataRecRules) > 0 {
			ruleGroups.Groups = append(ruleGroups.Groups, ruleGroupYAMLv2{
				Name:  fmt.Sprintf("sloth-slo-meta-recordings-%s", slo.SLO.ID),
				Rules: slo.Rules.MetadataRecRules,
			})
		}

		if len(slo.Rules.AlertRules) > 0 {
			ruleGroups.Groups = append(ruleGroups.Groups, ruleGroupYAMLv2{
				Name:  fmt.Sprintf("sloth-slo-alerts-%s", slo.SLO.ID),
				Rules: slo.Rules.AlertRules,
			})
		}
	}

	// Convert to YAML (Prometheus rule format).
	rulesYaml, err := yaml.Marshal(ruleGroups)
	if err != nil {
		return fmt.Errorf("could not format rules: %w", err)
	}

	rulesYaml = writeTopDisclaimer(rulesYaml)
	_, err = i.writer.Write(rulesYaml)
	if err != nil {
		return fmt.Errorf("could not write top disclaimer: %w", err)
	}

	i.logger.WithValues(log.Kv{"groups": len(ruleGroups.Groups)}).Infof("Prometheus rules written")

	return nil
}

const disclaimer = `
# DO NOT EDIT.
# Autogenerated code by Sloth: https://github.com/slok/sloth.

`

func writeTopDisclaimer(bs []byte) []byte {
	return append([]byte(disclaimer), bs...)
}

// these types are defined to support yaml v2 (instead of the new Prometheus
// YAML v3 that has some problems with marshaling).
type ruleGroupsYAMLv2 struct {
	Groups []ruleGroupYAMLv2 `yaml:"groups"`
}

type ruleGroupYAMLv2 struct {
	Name     string             `yaml:"name"`
	Interval prommodel.Duration `yaml:"interval,omitempty"`
	Rules    []rulefmt.Rule     `yaml:"rules"`
}
