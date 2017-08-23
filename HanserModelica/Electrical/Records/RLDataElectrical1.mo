within HanserModelica.Electrical.Records;
record RLDataElectrical1 "Parameter data used in Electrical1"
  extends RLData(final R=10,final L=2,final componentName="RLDataElectrical1");
  annotation(defaultComponentName = "rlData", defaultComponentPrefixes = "parameter");
end RLDataElectrical1;
