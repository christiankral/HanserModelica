within HanserModelica.SynchronousMachines.ParameterRecords;
record SMPM1 "Machine parameters of magnetically symmetric permanent magnet synchronous machine"
  import Modelica.Constants.pi;
  extends MoveTo_Modelica.Electrical.Machines.Utilities.ParameterRecords.SM_PermanentMagnetData(
    useDamperCage=false,
    effectiveStatorTurns=0.925*64,
    fsNominal=50,
    Lssigma=0.1/(2*pi*fsNominal),
    Lmd=0.3/(2*pi*fsNominal),
    Lmq=0.3/(2*pi*fsNominal),
    TsRef=373.15,
    TrRef=373.15);
   annotation (
    defaultComponentName="smpmData",
    defaultComponentPrefixes="parameter");
end SMPM1;
