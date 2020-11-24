import { Injectable } from "@angular/core";
import { Observable, throwError } from "rxjs";
import { IFeatureFlag } from "../models/featureFlag.model";
import { DataService } from "../services/data.service";
import { tap } from "rxjs/operators";

@Injectable()
export class FeatureFlagService {
  constructor(private service: DataService) {}

  // <snippet_getFeatures>
  getFeatures(featureName: string | string[]): Observable<IFeatureFlag[]> {
    let url: string = "features";
    if (Array.isArray(featureName)) {
      featureName.forEach((feature, index) => {
        url = url + `${index == 0 ? "?" : "&"}featureName=${feature}`;
      });
    } 
    else {
      url = url + `?featureName=${featureName}`;
    }
    return this.service.get(url).pipe<IFeatureFlag[]>(
      tap((response: any) => {
        return response;
      })
    );
  }
  // </snippet_getFeatures>
}
