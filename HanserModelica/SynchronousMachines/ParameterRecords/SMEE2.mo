within HanserModelica.SynchronousMachines.ParameterRecords;
record SMEE2 "Machine parameters of electrical excited synchronous machine with rotor saliency"
  import Modelica.Constants.pi;
  extends MoveTo_Modelica.Electrical.Machines.Utilities.SynchronousMachineData(
    SNominal=30e3,
    VsNominal=100,
    fsNominal=50,
    IeOpenCircuit=10,
    x0=0.1,
    xd=1.6,
    xq=1.6,
    xdTransient=0.1375,
    xdSubtransient=0.121428571,
    xqSubtransient=0.148387097,
    Ta=0.014171268,
    Td0Transient=0.261177343,
    Td0Subtransient=0.006963029,
    Tq0Subtransient=0.123345081,
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
end SMEE2;
