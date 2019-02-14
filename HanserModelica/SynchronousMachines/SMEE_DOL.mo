within HanserModelica.SynchronousMachines;
model SMEE_DOL "Electrical excited synchronous machine starting direct on line"
  extends Modelica.Icons.Example;
  parameter Integer m=3 "Number of phases";
  parameter Modelica.SIunits.Voltage VNominal=100 "Nominal RMS voltage per phase";
  parameter Modelica.SIunits.Frequency fNominal=50 "Nominal frequency";
  parameter Modelica.SIunits.Voltage Ve=smeeData.Re*smeeData.IeOpenCircuit "Excitation current";
  parameter Modelica.SIunits.Angle gamma0(displayUnit="deg") = 0 "Initial rotor displacement angle";
  Modelica.SIunits.Current irRMS = sqrt(smee.ir[1]^2+smee.ir[2]^2)/sqrt(2) "Quasi RMS rotor current";
  Modelica.SIunits.Angle theta = rotorDisplacementAngle.rotorDisplacementAngle "Rotor displacement angle";
  Modelica.Magnetic.FundamentalWave.BasicMachines.SynchronousInductionMachines.SM_ElectricalExcited smee(
    phiMechanical(start=-(Modelica.Constants.pi + gamma0)/smee.p, fixed=true),
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
    p=2,
    Jr=0.29,
    Js=0.29,
    useDamperCage=true,
    statorCoreParameters(VRef=100),
    strayLoadParameters(IRef=100),
    brushParameters(ILinear=0.01),
    ir(each fixed=true),
    wMechanical(fixed=true),
    m=m,
    Rs=smeeData.Rs*m/3,
    Lssigma=smeeData.Lssigma*m/3,
    Lmd=smeeData.Lmd*m/3,
    Lmq=smeeData.Lmq*m/3,
    sigmae=smeeData.sigmae*m/3,
    effectiveStatorTurns=smeeData.effectiveStatorTurns,
    TsOperational=smeeData.TsRef,
    alpha20s=smeeData.alpha20s,
    alpha20r=smeeData.alpha20r,
    TrOperational=smeeData.TrRef,
    TeOperational=smeeData.TeRef,
    alpha20e=smeeData.alpha20e)
      annotation (Placement(transformation(extent={{-20,-50},{0,-30}})));
  Modelica.Electrical.Machines.Sensors.RotorDisplacementAngle rotorDisplacementAngle(p=smee.p, m=m) annotation (Placement(transformation(
        origin={20,-40},
        extent={{-10,10},{10,-10}},
        rotation=270)));
  Modelica.Electrical.Analog.Basic.Ground groundExcitation annotation (
      Placement(transformation(
        origin={-40,-70},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Mechanics.Rotational.Sensors.MultiSensor mechanicalSensor annotation (Placement(transformation(extent={{40,-50},{60,-30}})));
  MoveTo_Modelica.Electrical.MultiPhase.Sensors.MultiSensor multiSensor(m=m) annotation (Placement(transformation(
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
    final freqHz=fill(fNominal, m)) annotation (Placement(transformation(
          extent={{-10,40},{-30,60}})));
  Modelica.Electrical.MultiPhase.Basic.Star star(final m=m) annotation (
      Placement(transformation(extent={{-40,40},{-60,60}})));
  Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
        transformation(
        origin={-60,30},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Electrical.Analog.Sources.RampVoltage rampVoltage(
    duration=0.1,
    V=Ve,
    offset=0,
    startTime=0.5) annotation (Placement(transformation(
        origin={-40,-40},
        extent={{10,-10},{-10,10}},
        rotation=90)));
  Modelica.Electrical.Machines.Utilities.TerminalBox terminalBox(terminalConnection="Y", m=m) annotation (Placement(transformation(extent={{-20,-34},{0,-14}})));

  Modelica.Electrical.MultiPhase.Ideal.IdealClosingSwitch switch(
    final m=m,
    Ron=fill(1e-5*m/3, m),
    Goff=fill(1e-5*m/3, m)) annotation (Placement(transformation(
        origin={10,50},
        extent={{-10,10},{10,-10}},
        rotation=0)));
  Modelica.Blocks.Sources.BooleanStep booleanStep(startTime=0) annotation (Placement(transformation(extent={{-50,0},{-30,20}})));
  Modelica.Blocks.Routing.BooleanReplicator booleanReplicator(nout=m) annotation (Placement(transformation(extent={{-20,20},{0,0}})));
  Modelica.Mechanics.Rotational.Sources.TorqueStep torqueStep(
    offsetTorque=0,
    stepTorque=50,
    startTime=1.5) annotation (Placement(transformation(extent={{90,-50},{70,-30}})));
  parameter ParameterRecords.SMEE1 smeeData "Synchronous machine data" annotation (Placement(transformation(extent={{-20,-80},{0,-60}})));
initial equation
  // sum(smee.is) = 0;
  smee.is[1:2] = zeros(2);
  smee.ie = 0;
  //conditional damper cage currents are defined as fixed start values
equation
  connect(rotorDisplacementAngle.plug_n, smee.plug_sn) annotation (Line(
        points={{26,-30},{26,-20},{-16,-20},{-16,-30}}, color={0,0,255}));
  connect(rotorDisplacementAngle.plug_p, smee.plug_sp)
    annotation (Line(points={{14,-30},{-4,-30}}, color={0,0,255}));
  connect(star.pin_n, ground.p)
    annotation (Line(points={{-60,50},{-60,40}}, color={0,0,255}));
  connect(star.plug_p, sineVoltage.plug_n)
    annotation (Line(points={{-40,50},{-30,50}}, color={0,0,255}));
  connect(terminalBox.plugSupply, currentRMSSensor.plug_n) annotation (Line(points={{-10,-28},{-10,-10},{40,-10}}, color={0,0,255}));
  connect(terminalBox.plug_sn, smee.plug_sn) annotation (Line(
      points={{-16,-30},{-16,-30}},
      color={0,0,255}));
  connect(terminalBox.plug_sp, smee.plug_sp) annotation (Line(
      points={{-4,-30},{-4,-30}},
      color={0,0,255}));
  connect(smee.flange, rotorDisplacementAngle.flange) annotation (Line(
      points={{0,-40},{10,-40}}));
  connect(smee.flange, mechanicalSensor.flange_a) annotation (Line(points={{0,-40},{40,-40}}));
  connect(sineVoltage.plug_p, switch.plug_p) annotation (Line(points={{-10,50},{0,50}}, color={0,0,255}));
  connect(booleanReplicator.y, switch.control) annotation (Line(points={{1,10},{10,10},{10,43}}, color={255,0,255}));
  connect(booleanStep.y, booleanReplicator.u)
    annotation (Line(points={{-29,10},{-22,10}}, color={255,0,255}));
  connect(groundExcitation.p, rampVoltage.n)
    annotation (Line(points={{-40,-60},{-40,-60},{-40,-56},{-40,-56},{-40,-50},{-40,-50}},
                                                   color={0,0,255}));
  connect(rampVoltage.n, smee.pin_en) annotation (Line(points={{-40,-50},{-30,-50},{-30,-46},{-20,-46}},
                                          color={0,0,255}));
  connect(rampVoltage.p, smee.pin_ep) annotation (Line(points={{-40,-30},{-30,-30},{-30,-34},{-20,-34}},
                                          color={0,0,255}));
  connect(mechanicalSensor.flange_b, torqueStep.flange) annotation (Line(points={{60,-40},{70,-40}}, color={0,0,0}));
  connect(switch.plug_n, multiSensor.pc) annotation (Line(points={{20,50},{40,50},{40,40}}, color={0,0,255}));
  connect(multiSensor.nv, terminalBox.plug_sn) annotation (Line(points={{30,30},{20,30},{20,-20},{-16,-20},{-16,-30}}, color={0,0,255}));
  connect(multiSensor.nc, currentRMSSensor.plug_p) annotation (Line(points={{40,20},{40,10}}, color={0,0,255}));
  connect(multiSensor.pv, multiSensor.pc) annotation (Line(points={{50,30},{50,40},{40,40}}, color={0,0,255}));
  annotation (experiment(StopTime=2.5,Interval=0.0001,Tolerance=1e-006),
    Documentation(info="<html>

<h4>Description</h4>

<p>An electrically excited synchronous generator is started direct on line utilizing the damper cage 
(and the shorted excitation winding) at 0 seconds. 
At t = 0.5 seconds, the excitation voltage is raised to achieve the no-load excitation current. 
Note, that reactive power of the stator goes to zero.
At t = 2 second, a driving torque step is applied to the shaft (i.e. the turbine is activated). 
Note, that the active (and the reactive) power of the stator change. 
To drive at higher torque, i.e., produce more electric power, excitation has to be adapted.
</p>

<h5>Note</h5>
<p>The mains switch is closed at time = 0 in order to avoid non physical noise calculated by the <code>rotorDisplacementAngle</code>. 
This noise is caused by the interaction of the high resistance of the switch and the machine, see 
<a href=\"https://github.com/modelica/Modelica/issues/2388\">#2388</a>. 
</p>

<h4>Plot the following variable(s)</h4>

<ul>
<li><code>smee.wMechanical</code>: mechanical speed</li>
<li><code>smee.ie</code>: excitation current</li>
<li><code>smee.tauElectrical</code>: electromagnetic torque</li>
<li><code>currentRMSSensor.I</code>: quasi RMS stator current</li>
<li><code>irRMS</code>: quasi RMS rotor current</li>
<li><code>theta</code>: rotor displacement angle</li>
<li><code>electricalSensor.powerTotal</code>: total electric real power</li>
</ul>

</html>"),
    Diagram(graphics={                      Text(
                  extent={{10,-72},{90,-80}},
                  lineColor={0,0,0},
                  fillColor={255,255,170},
                  fillPattern=FillPattern.Solid,
                  textStyle={TextStyle.Bold},
          textString="%m phase transient")}));
end SMEE_DOL;
