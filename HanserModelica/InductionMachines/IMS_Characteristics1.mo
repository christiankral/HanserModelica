within HanserModelica.InductionMachines;
model IMS_Characteristics1 "Characteristic curves of induction machine with slip rings"
  extends Modelica.Icons.Example;
  import Modelica.Constants.pi;
  parameter Integer m=3 "Number of stator phases";
  parameter Integer mr=3 "Number of rotor phases";
  parameter Integer mBase=Modelica.Electrical.MultiPhase.Functions.numberOfSymmetricBaseSystems(m)
    "Number of base systems";
  parameter Modelica.SIunits.Voltage VsNominal=100 "Nominal RMS voltage per phase";
  parameter Modelica.SIunits.Current IsNominal=100 "Nominal RMS current per phase";
  parameter Modelica.SIunits.Frequency fsNominal=imsData.fsNominal "Nominal frequency";
  parameter Modelica.SIunits.Resistance Rr=0/imsData.turnsRatio^2 "Starting resistance";
  parameter Integer p=imsData.p "Number of pole pairs";
  parameter Modelica.SIunits.AngularVelocity w_Load(displayUnit="rev/min")=
       Modelica.SIunits.Conversions.from_rpm(1440.45)
    "Nominal load speed";
  Real speedPerUnit = p*ims.wMechanical/(2*pi*fsNominal) "Per unit speed";
  Real slip = 1-speedPerUnit "Slip";
  output Modelica.SIunits.Current I=currentSensor.I " RMS current";
  Modelica.Magnetic.QuasiStatic.FundamentalWave.Utilities.MultiTerminalBox terminalBox(m=m, terminalConnection="Y") annotation (Placement(transformation(extent={{20,46},{40,66}})));
  Modelica.Magnetic.QuasiStatic.FundamentalWave.BasicMachines.InductionMachines.IM_SlipRing ims(
    p=imsData.p,
    fsNominal=imsData.fsNominal,
    TsRef=imsData.TsRef,
    alpha20s(displayUnit="1/K") = imsData.alpha20s,
    Jr=imsData.Jr,
    Js=imsData.Js,
    frictionParameters=imsData.frictionParameters,
    statorCoreParameters=imsData.statorCoreParameters,
    strayLoadParameters=imsData.strayLoadParameters,
    TrRef=imsData.TrRef,
    alpha20r(displayUnit="1/K") = imsData.alpha20r,
    useTurnsRatio=imsData.useTurnsRatio,
    VsNominal=imsData.VsNominal,
    VrLockedRotor=imsData.VrLockedRotor,
    rotorCoreParameters=imsData.rotorCoreParameters,
    Rs=imsData.Rs*m/3,
    Lssigma=imsData.Lssigma*m/3,
    Lm=imsData.Lm*m/3,
    gammar(fixed=true, start=pi/2),
    TurnsRatio=imsData.turnsRatio,
    Lrsigma=imsData.Lrsigma*mr/3,
    Rr=imsData.Rr*mr/3,
    mr=mr,
    m=m,
    TsOperational=imsData.TsRef,
    effectiveStatorTurns=imsData.effectiveStatorTurns,
    TrOperational=imsData.TrRef)
                         annotation (Placement(transformation(extent={{20,30},{40,50}})));
  Modelica.Electrical.QuasiStationary.MultiPhase.Sources.VoltageSource voltageSource(
    m=m,
    phi=-Modelica.Electrical.MultiPhase.Functions.symmetricOrientation(m),
    f=fsNominal,
    V=fill(VsNominal, m)) annotation (Placement(transformation(
        origin={-80,60},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Star star(m=m)
    annotation (Placement(transformation(
        origin={-80,30},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Ground ground
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-80,10})));
  Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.PowerSensor powerSensor(m=m) annotation (Placement(transformation(extent={{-70,70},{-50,90}})));
  MoveTo_Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.CurrentQuasiRMSSensor currentSensor(m=m) annotation (Placement(transformation(extent={{-10,70},{10,90}})));
  Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Star
    starMachine(m=mBase)
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={-40,30})));
  Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Ground
    groundMachine annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        origin={-40,10})));

  Modelica.Mechanics.Rotational.Sources.Speed speed(exact=true) annotation (Placement(transformation(extent={{70,30},{50,50}})));
  Modelica.Blocks.Sources.Ramp ramp(
    height=3*2*pi*fsNominal/p,
    duration=1,
    offset=-2*pi*fsNominal/p) annotation (Placement(transformation(extent={{100,30},{80,50}})));
  Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Ground groundRotor annotation (Placement(transformation(extent={{-10,-10},{10,10}}, origin={-10,10})));
  Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Star starRotor(m=mr) annotation (Placement(transformation(
        origin={-10,30},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Resistor resistor(m=mr, R_ref=fill(Rr, mr)) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={10,36})));
  parameter ParameterRecords.IMS imsData "Induction machine parameters" annotation (Placement(transformation(extent={{70,70},{90,90}})));
equation
  connect(terminalBox.plug_sn, ims.plug_sn)
    annotation (Line(points={{24,50},{24,50}}, color={0,0,255}));
  connect(terminalBox.plug_sp, ims.plug_sp)
    annotation (Line(points={{36,50},{36,50}}, color={0,0,255}));
  connect(ground.pin, star.pin_n)
    annotation (Line(points={{-80,20},{-80,20}}, color={85,170,255}));
  connect(star.plug_p, voltageSource.plug_n) annotation (Line(points={{-80,40},{-80,50}}, color={85,170,255}));
  connect(powerSensor.currentN, currentSensor.plug_p) annotation (Line(points={{-50,80},{-10,80}}, color={85,170,255}));
  connect(powerSensor.voltageP, powerSensor.currentP) annotation (Line(points={{-60,90},{-70,90},{-70,80}}, color={85,170,255}));
  connect(powerSensor.voltageN, star.plug_p) annotation (Line(points={{-60,70},{-60,40},{-80,40}}, color={85,170,255}));
  connect(currentSensor.plug_n, terminalBox.plugSupply) annotation (Line(points={{10,80},{30,80},{30,52}}, color={85,170,255}));
  connect(starMachine.pin_n, groundMachine.pin) annotation (Line(
      points={{-40,20},{-40,20}},
      color={85,170,255}));
  connect(starMachine.plug_p, terminalBox.starpoint) annotation (
      Line(
      points={{-40,40},{-40,52},{21,52}},
      color={85,170,255}));
  connect(voltageSource.plug_p, powerSensor.currentP) annotation (Line(points={{-80,70},{-80,80},{-70,80}}, color={85,170,255}));
  connect(ramp.y,speed. w_ref) annotation (Line(points={{79,40},{72,40}}, color={0,0,127}));
  connect(ims.flange, speed.flange) annotation (Line(points={{40,40},{50,40}}, color={0,0,0}));
  connect(starRotor.pin_n, groundRotor.pin) annotation (Line(points={{-10,20},{-10,20}}, color={85,170,255}));
  connect(resistor.plug_n, ims.plug_rn) annotation (Line(points={{10,26},{20,26},{20,34}}, color={85,170,255}));
  connect(ims.plug_rp, resistor.plug_p) annotation (Line(points={{20,46},{10,46}}, color={85,170,255}));
  connect(starRotor.plug_p, resistor.plug_n) annotation (Line(points={{-10,40},{-10,46},{2,46},{2,26},{10,26}}, color={85,170,255}));
  annotation (
    experiment(Interval=0.001, StopTime=1, Tolerance=1e-06),
    Documentation(info="<html>

<h4>Description</h4>

<p>
This examples allows the investigation of characteristic curves of quasi static multi phase induction machines with slip ring rotor
against rotor speed. The intention is to compare the results of the simulation models 
IMS_Characteristic1, 
<a href=\"modelica://HanserModelica.InductionMachines.IMS_Characteristics2\">IMS_Characteristics2</a> and
<a href=\"modelica://HanserModelica.InductionMachines.IMS_Characteristics3\">IMS_Characteristics3</a> in one plot.</p>

<h4>Plot the following variable(s)</h4>

<ul>
<li><code>ims.tauElectrical</code>: machine torque</li>
<li><code>currentSensor.I</code>: RMS stator current</li>
<li><code>ims.powerBalance.lossPower</code>: total loss</li>
<li><code>ims.powerBalance.powerStator</code>: stator power</li>
<li><code>ims.powerBalance.powerMechanical</code>: mechanical power</li>
</ul>
</html>"),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}),
                         graphics={         Text(
                  extent={{20,8},{100,0}},
                  lineColor={0,0,0},
                  fillColor={255,255,170},
                  fillPattern=FillPattern.Solid,
                  textStyle={TextStyle.Bold},
          textString="%m phase quasi static")}));
end IMS_Characteristics1;
