within HanserModelica.SynchronousMachines.ParameterRecords;
record SMEE1 "Machine parameters of electrical excited synchronous machine with rotor saliency"
  import Modelica.Constants.pi;
  extends MoveTo_Modelica.Electrical.Machines.Utilities.SynchronousMachineData(
    SNominal = 30000,
    VsNominal = 100,
    fsNominal = 50,
    IeOpenCircuit = 10,
    x0 = 0.1,
    xd = 1.6,
    xq = 1.1,
    xdTransient = 0.1375,
    xdSubtransient = 0.121429,
    xqSubtransient = 0.109901,
    Ta = 0.0122419,
    Td0Transient = 0.261177,
    Td0Subtransient = 0.00696303,
    Tq0Subtransient = 0.0803732,
    alpha20s(displayUnit="1/K") = Modelica.Electrical.Machines.Thermal.Constants.alpha20Zero,
    alpha20r(displayUnit="1/K") = Modelica.Electrical.Machines.Thermal.Constants.alpha20Zero,
    alpha20e(displayUnit="1/K") = Modelica.Electrical.Machines.Thermal.Constants.alpha20Zero,
    effectiveStatorTurns=0.925*64,
    TsSpecification=373.15,
    TsRef=373.15,
    TrSpecification=373.15,
    TrRef=373.15,
    TeSpecification=373.15,
    TeRef=373.15);

   annotation (
    defaultComponentName="smeeData",
    defaultComponentPrefixes="parameter");
end SMEE1;
