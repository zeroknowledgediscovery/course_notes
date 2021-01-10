#  Datasets

<img src="../logo1.png" alt="drawing" style="width:200px;"/>

---

## Cardiac Event Monitoring: Predicting Appropriate and Inappropriate Shocks from Wearable Medical Device


### Description

+ Each patient is monitored for a set of bio/cardio-relevant variables, as specified within the `fieldkey.txt`
+ Monitoring is done remotely via a device attached to the wrist, which is also equipped to "shock" teh patient if intervention is deemed to be required automatically
+ We want to compute a model for appropriate shocks (see `labeled_metadata_only_appropriate.csv`, column label *treatment*, where 0 implies no shock, and 2 implies appropriate shocks
+ We also want to figure out eventially when inappropriate shocks are administered.

---