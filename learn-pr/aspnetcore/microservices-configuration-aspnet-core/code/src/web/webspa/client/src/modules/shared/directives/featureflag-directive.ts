import { Directive, Input, ViewContainerRef, TemplateRef } from "@angular/core";
import { FeatureFlagService } from "../services/featureFlag.service";
import { IFeatureFlag } from "../models/featureFlag.model";

@Directive({
  selector: "[featureFlag]",
})
export class FeatureFlagDirective {
  @Input() featureFlag: string | string[];

  constructor(
    private vcr: ViewContainerRef,
    private tpl: TemplateRef<any>,
    private featureFlagService: FeatureFlagService
  ) {}

  ngOnInit() {
    this.featureFlagService.getFeatures(this.featureFlag).subscribe((features: IFeatureFlag[]) => {
      if (features.some(f => f.enabled)) {
        this.vcr.createEmbeddedView(this.tpl);
      }
    });
  }
}
