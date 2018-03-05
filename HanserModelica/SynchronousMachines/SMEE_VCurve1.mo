within HanserModelica.SynchronousMachines;
model SMEE_VCurve1 "V curves of electrical excited synchronous machine operated as generator at Pmech = 0"
  extends Modelica.Icons.Example;
  import Modelica.Constants.pi;
  parameter Integer m=3 "Number of stator phases";
  parameter Integer p=2 "Number of poles";
  parameter Modelica.SIunits.Voltage VsNominal=100
    "Nominal RMS voltage per phase";
  parameter Modelica.SIunits.Frequency fsNominal=smeeData.fsNominal "Nominal frequency";
  parameter Modelica.SIunits.AngularVelocity wNominal=2*pi*fsNominal/p "Nominal speed";
  parameter Modelica.SIunits.Current IeMax=31 "Maximum excitation current";
  parameter Modelica.SIunits.Current Ie0=10 "No load excitation current";
  parameter Modelica.SIunits.Torque tauMax=smeeData.SNominal/wNominal "Maximum torque at power factor = 1";
  parameter Modelica.SIunits.Angle gamma0(displayUnit="deg") = 0 "Initial rotor displacement angle";
  output Modelica.SIunits.Power P=powerSensor.apparentPowerTotal.re " real power";
  output Modelica.SIunits.ReactivePower Q=powerSensor.apparentPowerTotal.im " reactive power";
  Modelica.SIunits.Angle theta=rotorAngle.rotorDisplacementAngle "Rotor displacement angle";

 Modelica.Magnetic.QuasiStatic.FundamentalWave.BasicMachines.SynchronousMachines.SM_ElectricalExcited smee(
    phiMechanical(start=-(pi + gamma0)/p, fixed=true),
    gammar(fixed=true, start=pi/2),
    fsNominal=smeeData.fsNominal,
    TsRef=smeeData.TsRef,
    alpha20s(displayUnit="1/K") = smeeData.alpha20s,
    Jr=0.29,
    Js=0.29,
    frictionParameters(PRef=0),
    statorCoreParameters(PRef=0, VRef=100),
    strayLoadParameters(PRef=0, IRef=100),
    Lrsigmad=smeeData.Lrsigmad,
    Rrd=smeeData.Rrd,
    Rrq=smeeData.Rrq,
    alpha20r(displayUnit="1/K") = smeeData.alpha20r,
    VsNominal=smeeData.VsNominal,
    IeOpenCircuit=smeeData.IeOpenCircuit,
    Re=smeeData.Re,
    TeRef=smeeData.TeRef,
    alpha20e(displayUnit="1/K") = smeeData.alpha20e,
    brushParameters(V=0, ILinear=0.01),
    Lrsigmaq=smeeData.Lrsigmaq,
    TrRef=smeeData.TrRef,
    m=m,
    wMechanical(fixed=true,start=wNominal),
    Rs=smeeData.Rs*m/3,
    Lssigma=smeeData.Lssigma*m/3,
    Lmd=smeeData.Lmd*m/3,
    Lmq=smeeData.Lmq*m/3,
    effectiveStatorTurns=smeeData.effectiveStatorTurns,
    p=p,
    useDamperCage=true,
    TsOperational=smeeData.TsRef,
    TrOperational=smeeData.TrRef,
    TeOperational=smeeData.TeRef) annotation (Placement(transformation(extent={{-10,10},{10,30}})));
  Modelica.Electrical.Analog.Basic.Ground groundr annotation (
      Placement(transformation(
        origin={-50,2},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Analog.Sources.SignalCurrent   currentSource
       annotation (Placement(transformation(
        origin={-28,20},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Modelica.Electrical.Machines.Sensors.MechanicalPowerSensor
    mechanicalPowerSensor annotation (Placement(transformation(extent={{40,10},{60,30}})));
  Modelica.Mechanics.Rotational.Sources.ConstantTorque constantTorque(useSupport=false, tau_constant=0) annotation (Placement(transformation(extent={{90,10},{70,30}})));

  Modelica.Electrical.QuasiStationary.MultiPhase.Sources.VoltageSource
    voltageSource(
    m=m,
    phi=-Modelica.Electrical.MultiPhase.Functions.symmetricOrientation(
        m),
    V=fill(VsNominal, m),
    f=fsNominal) annotation (Placement(transformation(
        origin={-30,80},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Star star(m=m)
    annotation (Placement(transformation(
        origin={-60,80},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Ground
    grounde annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-90,80})));
  MoveTo_Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.MultiSensor powerSensor(m=m) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,60})));
  Modelica.Magnetic.QuasiStatic.FundamentalWave.Utilities.MultiTerminalBox terminalBox(m=m, terminalConnection="Y") annotation (Placement(transformation(extent={{-10,26},{10,46}})));
  Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Star
    starMachine(m=
        Modelica.Electrical.MultiPhase.Functions.numberOfSymmetricBaseSystems(m))
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={-20,40})));
  Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Ground
    groundMachine annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-50,40})));
  MoveTo_Modelica.Magnetic.QuasiStatic.FundamentalWave.Sensors.RotorDisplacementAngle rotorAngle(m=m, p=smee.p) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={30,20})));

  Modelica.Blocks.Sources.Ramp ramp(
    height=-IeMax,
    offset=IeMax,
    duration=200,
    startTime=0)  annotation (Placement(transformation(extent={{-80,10},{-60,30}})));
  parameter ParameterRecords.SMEE smeeData annotation (Placement(transformation(extent={{20,72},{40,92}})));
algorithm
  when rotorAngle.rotorDisplacementAngle<-pi/2 then
    terminate("Exit of simulation");
  end when;
equation
  connect(mechanicalPowerSensor.flange_b, constantTorque.flange) annotation (Line(points={{60,20},{70,20}}));
  connect(currentSource.p, groundr.p) annotation (Line(points={{-28,10},{-28,2},{-40,2}},
                                           color={0,0,255}));
  connect(currentSource.p, smee.pin_en) annotation (Line(points={{-28,10},{-20,10},{-20,14},{-10,14}},
                                           color={0,0,255}));
  connect(currentSource.n, smee.pin_ep) annotation (Line(points={{-28,30},{-20,30},{-20,26},{-10,26}},
                                           color={0,0,255}));
  connect(grounde.pin, star.pin_n) annotation (Line(points={{-80,80},
          {-80,80},{-70,80}}, color={85,170,255}));
  connect(star.plug_p, voltageSource.plug_n) annotation (Line(
        points={{-50,80},{-50,80},{-40,80}}, color={85,170,255}));
  connect(terminalBox.plug_sn, smee.plug_sn) annotation (Line(
      points={{-6,30},{-6,30}},
      color={85,170,255}));
  connect(terminalBox.plug_sp, smee.plug_sp) annotation (Line(
      points={{6,30},{6,30}},
      color={85,170,255}));
  connect(starMachine.pin_n, groundMachine.pin) annotation (Line(
      points={{-30,40},{-40,40}},
      color={85,170,255}));
  connect(starMachine.plug_p, terminalBox.starpoint) annotation (
      Line(
      points={{-10,40},{-10,36},{-10,32},{-9,32}},
      color={85,170,255}));
  connect(terminalBox.plug_sp, rotorAngle.plug_p) annotation (Line(points={{6,30},{24,30}}, color={85,170,255}));
  connect(rotorAngle.plug_n, terminalBox.plug_sn) annotation (Line(points={{36,30},{36,36},{-6,36},{-6,30}}, color={85,170,255}));
  connect(smee.flange, rotorAngle.flange) annotation (Line(points={{10,20},{20,20}}, color={0,0,0}));
  connect(smee.flange, mechanicalPowerSensor.flange_a) annotation (Line(points={{10,20},{40,20}}, color={0,0,0}));
  connect(voltageSource.plug_p, powerSensor.pc) annotation (Line(points={{-20,80},{0,80},{0,70}}, color={85,170,255}));
  connect(powerSensor.pv, powerSensor.pc) annotation (Line(points={{10,60},{10,70},{0,70}}, color={85,170,255}));
  connect(powerSensor.nv, star.plug_p) annotation (Line(points={{-10,60},{-50,60},{-50,80}}, color={85,170,255}));
  connect(powerSensor.nc, terminalBox.plugSupply) annotation (Line(points={{0,50},{0,32}}, color={85,170,255}));
  connect(ramp.y, currentSource.i) annotation (Line(points={{-59,20},{-35,20}}, color={0,0,127}));
  annotation (
    experiment(StopTime=200,Interval=0.001,Tolerance=1e-06),
    Documentation(info="<html>
<p>
This example investigates a quasi static model of a electrically excited synchronous machine. 
The electrically excited synchronous generators are connected to the grid and driven with constant speed.
Since speed is slightly smaller than synchronous speed corresponding to mains frequency,
rotor angle is very slowly increased. This allows to see several characteristics dependent on rotor angle.
</p>

<p>
Simulate for 30 seconds and plot versus <code>rotorAngle|rotorAngle.rotorDisplacementAngle</code>:
</p>

<ul>
<li><code>smpm.tauElectrical</code>: machine torque</li>
</ul>
</html>"),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}),
                         graphics={         Text(
                  extent={{20,48},{100,40}},
                  lineColor={0,0,0},
                  fillColor={255,255,170},
                  fillPattern=FillPattern.Solid,
                  textStyle={TextStyle.Bold},
          textString="%m phase quasi static")}));
end SMEE_VCurve1;
