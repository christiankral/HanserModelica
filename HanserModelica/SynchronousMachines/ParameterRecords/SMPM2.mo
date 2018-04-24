within HanserModelica.SynchronousMachines.ParameterRecords;
record SMPM2 "Machine parameters of permanent magnet synchronous machine with rotor saliency"
  import Modelica.Constants.pi;
  parameter Real xi = 4 "Saliency of rotor";
  extends MoveTo_Modelica.Electrical.Machines.Utilities.ParameterRecords.SM_PermanentMagnetData(
    Rs=0.03,
    Lssigma=0.13/(2*pi*fsNominal),
    Lmd=0.2/(2*pi*fsNominal),
    Lmq=(Lmd+Lssigma)*xi-Lssigma,
    p=2,
    fsNominal=50,
    VsOpenCircuit=32,
    effectiveStatorTurns=59.2,
    Jr=0.29,
    useDamperCage=false,
    TsRef=373.15,
    TrRef=373.15);
   annotation (
    defaultComponentName="smpmData",
    defaultComponentPrefixes="parameter");
end SMPM2;
