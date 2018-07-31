within HanserModelica.SynchronousMachines;
model SMEE_Synchronization1 "Electrical excited synchronous machine synchronized to grid"
  extends Modelica.Icons.Example;
  import Modelica.Constants.pi;
  parameter Integer m=3 "Number of phases";
  parameter Integer p=2 "Number of poles";
  parameter Modelica.SIunits.Angle phi=Modelica.SIunits.Conversions.from_deg(0)
    "Phase angle lag of mains voltages over machine voltages";
  parameter Modelica.SIunits.Voltage VNominal=100 "Nominal RMS voltage per phase";
  parameter Modelica.SIunits.Frequency fNominal=50 "Nominal frequency";
  parameter Modelica.SIunits.Voltage Ve=smeeData.Re*smeeData.IeOpenCircuit "Excitation current";
  parameter Modelica.SIunits.Angle gamma0(displayUnit="deg") = 0 "Initial rotor displacement angle";
  parameter Modelica.SIunits.AngularVelocity wNominal=2*pi*smeeData.fsNominal/p "Nominal angular velocity";
  Modelica.SIunits.Current irRMS = sqrt(smee.ir[1]^2+smee.ir[2]^2)/sqrt(2) "Quasi RMS rotor current";
  output Modelica.SIunits.Current ie = smee.ie "Excitation current";
  Modelica.Magnetic.FundamentalWave.BasicMachines.SynchronousInductionMachines.SM_ElectricalExcited smee(
    phiMechanical(start=-(pi + gamma0)/smee.p, fixed=true),
    fsNominal=smeeData.fsNominal,
    TsRef=smeeData.TsRef,
    Lrsigmad=smeeData.Lrsigmad,
    Lrsigmaq=smeeData.Lrsigmaq,
    Rrd=smeeData.Rrd,
    Rrq=smeeData.Rrq,
    TrRef=smeeData.TrRef,
    VsNominal=smeeData.VsNominal,
    IeOpenCircuit=smeeData.IeOpenCircuit,
    Re=smeeData.Re,
    TeRef=smeeData.TeRef,
    p=p,
    Jr=0.29,
    Js=0.29,
    useDamperCage=true,
    statorCoreParameters(VRef=100),
    strayLoadParameters(IRef=100),
    brushParameters(ILinear=0.01),
    ir(fixed=true),
    wMechanical(fixed=true,start=wNominal),
    m=m,
    Rs=smeeData.Rs*m/3,
    Lssigma=smeeData.Lssigma*m/3,
    Lmd=smeeData.Lmd*m/3,
    Lmq=smeeData.Lmq*m/3,
    sigmae=smeeData.sigmae*m/3,
    TsOperational=smeeData.TsRef,
    alpha20s=smeeData.alpha20s,
    effectiveStatorTurns=smeeData.effectiveStatorTurns,
    alpha20r=smeeData.alpha20r,
    TrOperational=smeeData.TrRef,
    TeOperational=smeeData.TeRef,
    alpha20e=smeeData.alpha20e)
      annotation (Placement(transformation(extent={{30,-40},{50,-20}})));
  Modelica.Electrical.Analog.Basic.Ground groundExcitation annotation (
      Placement(transformation(
        origin={10,-60},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  MoveTo_Modelica.Electrical.MultiPhase.Sensors.MultiSensor electricalSensor(m=m) annotation (Placement(transformation(
        origin={40,30},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.MultiPhase.Sensors.CurrentQuasiRMSSensor currentRMSSensor(m=m) annotation (Placement(transformation(
        origin={40,0},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.MultiPhase.Sources.SineVoltage sineVoltage(
    final m=m,
    final V=fill(VNominal*sqrt(2), m),
    final freqHz=fill(fNominal, m),
    phase=-Modelica.Electrical.MultiPhase.Functions.symmetricOrientation(m) - fill(phi, m))
                                    annotation (Placement(transformation(
          extent={{-10,40},{-30,60}})));
  Modelica.Electrical.MultiPhase.Basic.Star star(final m=m) annotation (
      Placement(transformation(extent={{-40,40},{-60,60}})));
  Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
        transformation(
        origin={-60,30},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Electrical.Analog.Sources.ConstantCurrent constantCurrent(I=smeeData.IeOpenCircuit) annotation (Placement(transformation(
        origin={10,-30},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Modelica.Electrical.Machines.Utilities.TerminalBox terminalBox(terminalConnection="Y", m=m) annotation (Placement(transformation(extent={{30,-24},{50,-4}})));

  Modelica.Electrical.MultiPhase.Ideal.IdealClosingSwitch switch(
    final m=m,
    Ron=fill(1e-5*m/3, m),
    Goff=fill(1e-5*m/3, m)) annotation (Placement(transformation(
        origin={10,50},
        extent={{-10,10},{10,-10}},
        rotation=0)));
  Modelica.Blocks.Sources.BooleanStep booleanStep(startTime=0.1)
                                                               annotation (Placement(transformation(extent={{-50,0},{-30,20}})));
  Modelica.Blocks.Routing.BooleanReplicator booleanReplicator(nout=m) annotation (Placement(transformation(extent={{-20,20},{0,0}})));
  Modelica.Mechanics.Rotational.Sources.ConstantTorque constantTorque(tau_constant=0) annotation (Placement(transformation(extent={{80,-40},{60,-20}})));
  parameter ParameterRecords.SMEE1 smeeData "Synchronous machine data" annotation (Placement(transformation(extent={{-50,-40},{-30,-20}})));
initial equation
  // sum(smee.is) = 0;
  smee.is[1:2] = zeros(2);
  //conditional damper cage currents are defined as fixed start values
equation
  connect(star.pin_n, ground.p)
    annotation (Line(points={{-60,50},{-60,40}}, color={0,0,255}));
  connect(star.plug_p, sineVoltage.plug_n)
    annotation (Line(points={{-40,50},{-30,50}}, color={0,0,255}));
  connect(terminalBox.plugSupply, currentRMSSensor.plug_n) annotation (Line(points={{40,-18},{40,-10}},            color={0,0,255}));
  connect(terminalBox.plug_sn, smee.plug_sn) annotation (Line(
      points={{34,-20},{34,-20}},
      color={0,0,255}));
  connect(terminalBox.plug_sp, smee.plug_sp) annotation (Line(
      points={{46,-20},{46,-20}},
      color={0,0,255}));
  connect(sineVoltage.plug_p, switch.plug_p) annotation (Line(points={{-10,50},{0,50}}, color={0,0,255}));
  connect(booleanReplicator.y, switch.control) annotation (Line(points={{1,10},{10,10},{10,43}}, color={255,0,255}));
  connect(booleanStep.y, booleanReplicator.u)
    annotation (Line(points={{-29,10},{-22,10}}, color={255,0,255}));
  connect(switch.plug_n, electricalSensor.pc) annotation (Line(points={{20,50},{40,50},{40,40}}, color={0,0,255}));
  connect(electricalSensor.nv, terminalBox.plug_sn) annotation (Line(points={{30,30},{20,30},{20,-8},{34,-8},{34,-20}},     color={0,0,255}));
  connect(electricalSensor.nc, currentRMSSensor.plug_p) annotation (Line(points={{40,20},{40,10}}, color={0,0,255}));
  connect(electricalSensor.pv, electricalSensor.pc) annotation (Line(points={{50,30},{50,40},{40,40}}, color={0,0,255}));
  connect(constantCurrent.p, groundExcitation.p) annotation (Line(points={{10,-40},{10,-50}},   color={0,0,255}));
  connect(constantCurrent.p, smee.pin_en) annotation (Line(points={{10,-40},{20,-40},{20,-36},{30,-36}},     color={0,0,255}));
  connect(smee.pin_ep, constantCurrent.n) annotation (Line(points={{30,-24},{20,-24},{20,-20},{10,-20}},     color={0,0,255}));
  connect(smee.flange, constantTorque.flange) annotation (Line(points={{50,-30},{60,-30}}, color={0,0,0}));
  annotation (experiment(StopTime=0.3,Interval=0.0001,Tolerance=1e-08),
    Documentation(info="<html>

<h4>Description</h4>

<p>
n electrically excited synchronous machine is running with synchrous speed. 
The RMS values of the open circuit machine voltages and mains voltage are equal. 
Tha phase shift if the machine and mains voltages are euqal. 
The intention is to compare the results of the following simulation models in one plot:</p>

<ul>
<li>SMEE_Synchronization1: all synchronization conditions are fulfilled</li>
<li><a href=\"modelica://HanserModelica.SynchronousMachines.SMEE_Synchronization2\">SMEE_Synchronization2</a>:
    phi = 10° is used to cause lagging phase angles of the mains voltage</li>
<li><a href=\"modelica://HanserModelica.SynchronousMachines.SMEE_Synchronization3\">SMEE_Synchronization3</a>:
    excitation current is 5 percent greater than in 
    <a href=\"modelica://HanserModelica.SynchronousMachines.SMEE_Synchronization1\">SMEE_Synchronization1</a>; 
    this causes the stator voltages to be 5 percent greater than the nominal voltage</li>
</ul>

<p>After 0.1 seconds the synchronization switch closes. The shaft of the synchronous
machine is mechanically not connected, such that neither mechanical speed nor torque are fixed. As the machine and mains 
voltages are equal for each phase, there are neither electrical nor mechanical reactions
of the machine on the closing switch.
</p>

<h4>Plot the following variable(s)</h4>

<ul>
<li><code>currentRMSSensor.I</code>: quasi RMS stator current</li>
<li><code>smee.tauElectrical</code>: electromagnetic torque</li>
<li><code>smee.wMechanical</code>: speed</li>
</ul>
</html>"),
    Diagram(graphics={                      Text(
                  extent={{-60,-8},{20,-16}},
                  lineColor={0,0,0},
                  fillColor={255,255,170},
                  fillPattern=FillPattern.Solid,
                  textStyle={TextStyle.Bold},
          textString="%m phase")}));
end SMEE_Synchronization1;
