within HanserModelica.SynchronousMachines;
model SMEE_Synchronization "Electrical excited synchronous machine synchronized to grid"
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
    TsOperational=293.15,
    alpha20s=smeeData.alpha20s,
    alpha20r=smeeData.alpha20r,
    TrOperational=293.15,
    TeOperational=293.15,
    alpha20e=smeeData.alpha20e,
    sigmae=smeeData.sigmae*m/3)
      annotation (Placement(transformation(extent={{30,-42},{50,-22}})));
  Modelica.Electrical.Analog.Basic.Ground groundExcitation annotation (
      Placement(transformation(
        origin={10,-62},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Electrical.MultiPhase.Sensors.MultiSensor electricalSensor(m=m) annotation (Placement(transformation(
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
        origin={10,-32},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Modelica.Electrical.Machines.Utilities.TerminalBox terminalBox(terminalConnection="Y", m=m) annotation (Placement(transformation(extent={{30,-26},{50,-6}})));
  parameter Modelica.Electrical.Machines.Utilities.SynchronousMachineData smeeData(
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
    effectiveStatorTurns=1,
    TsSpecification=293.15,
    TsRef=293.15,
    TrSpecification=293.15,
    TrRef=293.15,
    TeSpecification=293.15,
    TeRef=293.15) annotation (Placement(transformation(extent={{-30,-40},{-10,-20}})));

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
initial equation
  // sum(smee.is) = 0;
  smee.is[1:2] = zeros(2);
  //conditional damper cage currents are defined as fixed start values
equation
  connect(star.pin_n, ground.p)
    annotation (Line(points={{-60,50},{-60,40}}, color={0,0,255}));
  connect(star.plug_p, sineVoltage.plug_n)
    annotation (Line(points={{-40,50},{-30,50}}, color={0,0,255}));
  connect(terminalBox.plugSupply, currentRMSSensor.plug_n) annotation (Line(points={{40,-20},{40,-10}},            color={0,0,255}));
  connect(terminalBox.plug_sn, smee.plug_sn) annotation (Line(
      points={{34,-22},{34,-22}},
      color={0,0,255}));
  connect(terminalBox.plug_sp, smee.plug_sp) annotation (Line(
      points={{46,-22},{46,-22}},
      color={0,0,255}));
  connect(sineVoltage.plug_p, switch.plug_p) annotation (Line(points={{-10,50},{0,50}}, color={0,0,255}));
  connect(booleanReplicator.y, switch.control) annotation (Line(points={{1,10},{10,10},{10,38}}, color={255,0,255}));
  connect(booleanStep.y, booleanReplicator.u)
    annotation (Line(points={{-29,10},{-22,10}}, color={255,0,255}));
  connect(switch.plug_n, electricalSensor.pc) annotation (Line(points={{20,50},{40,50},{40,40}}, color={0,0,255}));
  connect(electricalSensor.nv, terminalBox.plug_sn) annotation (Line(points={{30,30},{20,30},{20,-10},{34,-10},{34,-22}},   color={0,0,255}));
  connect(electricalSensor.nc, currentRMSSensor.plug_p) annotation (Line(points={{40,20},{40,10}}, color={0,0,255}));
  connect(electricalSensor.pv, electricalSensor.pc) annotation (Line(points={{50,30},{50,40},{40,40}}, color={0,0,255}));
  connect(constantCurrent.p, groundExcitation.p) annotation (Line(points={{10,-42},{10,-52}},   color={0,0,255}));
  connect(constantCurrent.p, smee.pin_en) annotation (Line(points={{10,-42},{20,-42},{20,-38},{30,-38}},     color={0,0,255}));
  connect(smee.pin_ep, constantCurrent.n) annotation (Line(points={{30,-26},{20,-26},{20,-22},{10,-22}},     color={0,0,255}));
  annotation (experiment(
      StopTime=0.5,
      Interval=0.0001,
      Tolerance=1e-08),
    Documentation(info="<html>
<p>An electrically excited synchronous generator is started direct on line utilizing the damper cage 
(and the shorted excitation winding) at 0 seconds.</p>
<p>At t = 0.5 seconds, the excitation voltage is raised to achieve the no-load excitation current. 
Note, that reactive power of the stator goes to zero.</p>
<p>At t = 2 second, a driving torque step is applied to the shaft (i.e. the turbine is activated). 
Note, that the active (and the reactive) power of the stator change. 
To drive at higher torque, i.e., produce more electric power, excitation has to be adapted.
</p>

<p>Simulate for 3 seconds and plot:</p>

<ul>
<li><code>smee.tauElectrical</code>: electric torque</li>
<li><code>smee.wMechanical</code>: mechanical speed</li>
<li><code>currentRMSSensor.I</code>: quasi RMS stator current</li>
<li><code>irRMS</code>: quasi RMS rotor current</li>
<li><code>smee.ie</code>: excitation current</li>
<li><code>rotorDisplacementAngle.rotorDisplacementAngle</code>: rotor displacement angle</li>
<li><code>electricalSensor.powerTotal</code>: total electric real power</li>
<li><code>mechanicalSensor.power</code>: mechanical power</li>
</ul>

<p>Default machine parameters are used.</p>

<h5>Note</h5>
<p>The mains switch is closed at time = 0 in order to avoid non physical noise calculated by the <code>rotorDisplacementAngle</code>. 
This noise is caused by the interaction of the high resistance of the switch and the machine, see 
<a href=\"https://github.com/modelica/Modelica/issues/2388\">#2388</a>. 
</p>
</html>"),
    Diagram(graphics={                      Text(
                  extent={{-60,-8},{20,-16}},
                  lineColor={0,0,0},
                  fillColor={255,255,170},
                  fillPattern=FillPattern.Solid,
                  textStyle={TextStyle.Bold},
          textString="%m phase quasi static")}));
end SMEE_Synchronization;
