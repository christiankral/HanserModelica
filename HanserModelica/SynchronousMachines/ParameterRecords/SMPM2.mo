within HanserModelica.SynchronousMachines.ParameterRecords;
record SMPM2 "Permanent magnet synchronous machine parameter set 2"
  import Modelica.Constants.pi;
  parameter Real xi = 4 "Saliency of rotor";
  extends Modelica.Electrical.Machines.Utilities.ParameterRecords.SM_PermanentMagnetData(
    Rs=0.03,
    Lssigma=0.13/(2*pi*fsNominal),
    Lmd=0.2/(2*pi*fsNominal),
    Lmq=(Lmd+Lssigma)*xi-Lssigma,
    p=2,
    fsNominal=50,
    VsOpenCircuit=32,
    effectiveStatorTurns=0.925*64,
    Jr=0.29,
    useDamperCage=false,
    TsRef=373.15,
    TrRef=373.15);
   annotation (
    defaultComponentName="smpmData",
    defaultComponentPrefixes="parameter");
end SMPM2;
