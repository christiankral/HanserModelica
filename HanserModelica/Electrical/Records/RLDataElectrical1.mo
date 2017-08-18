within HanserModelica.Electrical.Records;
record RLDataElectrical1 "Parameter data used in Electrical1"
  extends RLData(R=10,L=2,componentName="RLDataElectrical1");
  annotation(defaultComponentName = "rlData", defaultComponentPrefixes = "parameter");
end RLDataElectrical1;
