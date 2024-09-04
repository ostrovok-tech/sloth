package generate

import (
	"context"

	"github.com/ostrovok-tech/sloth/internal/alert"
	"github.com/ostrovok-tech/sloth/internal/info"
	"github.com/ostrovok-tech/sloth/internal/prometheus"
	"github.com/prometheus/prometheus/model/rulefmt"
)

type noopSLIRecordingRulesGenerator bool

const NoopSLIRecordingRulesGenerator = noopSLIRecordingRulesGenerator(false)

func (noopSLIRecordingRulesGenerator) GenerateSLIRecordingRules(_ context.Context, _ prometheus.SLO, _ alert.MWMBAlertGroup) ([]rulefmt.Rule, error) {
	return nil, nil
}

type noopMetadataRecordingRulesGenerator bool

const NoopMetadataRecordingRulesGenerator = noopMetadataRecordingRulesGenerator(false)

func (noopMetadataRecordingRulesGenerator) GenerateMetadataRecordingRules(_ context.Context, _ info.Info, _ prometheus.SLO, _ alert.MWMBAlertGroup) ([]rulefmt.Rule, error) {
	return nil, nil
}

type noopSLOAlertRulesGenerator bool

const NoopSLOAlertRulesGenerator = noopSLOAlertRulesGenerator(false)

func (noopSLOAlertRulesGenerator) GenerateSLOAlertRules(_ context.Context, _ prometheus.SLO, _ alert.MWMBAlertGroup) ([]rulefmt.Rule, error) {
	return nil, nil
}
