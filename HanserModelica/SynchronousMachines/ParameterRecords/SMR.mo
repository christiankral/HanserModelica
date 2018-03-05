within HanserModelica.SynchronousMachines.ParameterRecords;
record SMR "Permanent magnet synchronous reluctance machine parameters"
  import Modelica.Constants.pi;
  extends MoveTo_Modelica.Electrical.Machines.Utilities.ParameterRecords.SM_ReluctanceRotorData(
    useDamperCage=true,
    effectiveStatorTurns=0.925*64,
    fsNominal=50,
    Lssigma=0.1/(2*pi*fsNominal),
    Lmd = 2.9 / (2 * pi * fsNominal),
    Lmq = 0.36 / (2 * pi * fsNominal),
    TsRef=373.15,
    TrRef=373.15);
     annotation (
    defaultComponentName="smrData",
    defaultComponentPrefixes="parameter");
end SMR;
