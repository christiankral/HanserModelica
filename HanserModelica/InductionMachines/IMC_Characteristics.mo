within HanserModelica.InductionMachines;
model IMC_Characteristics "Characteristic curves of Induction machine with squirrel cage"
  extends Modelica.Icons.Example;
  import Modelica.Constants.pi;
  parameter Integer m=3 "Number of phases";
  parameter Modelica.Units.SI.Voltage VsNominal=100
    "Nominal stator RMS voltage per phase";
  parameter Modelica.Units.SI.Current IsNominal=100
    "Nominal stator RMS voltage per phase";
  parameter Modelica.Units.SI.Frequency fsNominal=imcData.fsNominal
    "Nominal frequency";
  parameter Modelica.Units.SI.AngularVelocity w_Load(displayUnit="rev/min") =
    1440.45*2*Modelica.Constants.pi/60 "Nominal load speed";
  parameter Integer p=imcData.p "Number of pole pairs";
  Real speedPerUnit = p*imc.wMechanical/(2*pi*fsNominal) "Per unit speed";
  Real slip = 1-speedPerUnit "Slip";
  output Modelica.Units.SI.Current I=currentRMSSensor.I " RMS current";
  Modelica.Electrical.QuasiStatic.Polyphase.Sources.VoltageSource voltageSource(
    m=m,
    f=fsNominal,
    V=fill(VsNominal, m),
    phi=-Modelica.Electrical.Polyphase.Functions.symmetricOrientation(m))
    annotation (Placement(transformation(
        origin={-60,40},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.QuasiStatic.Polyphase.Basic.Star star(m=m) annotation (
      Placement(transformation(
        origin={-70,20},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  Modelica.Electrical.QuasiStatic.SinglePhase.Basic.Ground ground annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-90,20})));
  Modelica.Electrical.QuasiStatic.Polyphase.Sensors.PowerSensor powerSensor(m=m)
    annotation (Placement(transformation(extent={{-40,70},{-20,90}})));
  Modelica.Electrical.QuasiStatic.Polyphase.Sensors.CurrentQuasiRMSSensor
    currentRMSSensor(m=m)
    annotation (Placement(transformation(extent={{-10,70},{10,90}})));
  Modelica.Magnetic.QuasiStatic.FundamentalWave.BasicMachines.InductionMachines.IM_SquirrelCage imc(
    Js=imcData.Js,
    p=imcData.p,
    fsNominal=imcData.fsNominal,
    TsRef=imcData.TsRef,
    alpha20s(displayUnit="1/K") = imcData.alpha20s,
    frictionParameters=imcData.frictionParameters,
    gammar(fixed=true, start=-pi/2),
    statorCoreParameters=imcData.statorCoreParameters,
    strayLoadParameters=imcData.strayLoadParameters,
    alpha20r(displayUnit="1/K") = imcData.alpha20r,
    Rs=imcData.Rs*m/3,
    Lssigma=imcData.Lssigma*m/3,
    Lm=imcData.Lm*m/3,
    Lrsigma=imcData.Lrsigma*m/3,
    Rr=imcData.Rr*m/3,
    TrRef=imcData.TrRef,
    m=m,
    Jr=0*imcData.Jr,
    TsOperational=imcData.TsRef,
    effectiveStatorTurns=imcData.effectiveStatorTurns,
    TrOperational=imcData.TrRef) annotation (Placement(transformation(extent={{20,30},{40,50}})));
  Modelica.Electrical.QuasiStatic.SinglePhase.Basic.Ground groundMachine
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, origin={-10,
            10})));
  Modelica.Electrical.QuasiStatic.Polyphase.Basic.Star starMachine(m=
        Modelica.Electrical.Polyphase.Functions.numberOfSymmetricBaseSystems(m))
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={-10,30})));
  Modelica.Magnetic.QuasiStatic.FundamentalWave.Utilities.MultiTerminalBox terminalBox(m=m, terminalConnection="Y") annotation (Placement(transformation(extent={{20,46},{40,66}})));
  Modelica.Mechanics.Rotational.Sources.Speed speed(exact=true) annotation (Placement(transformation(extent={{70,30},{50,50}})));
  Modelica.Blocks.Sources.Ramp ramp(
    height=3*2*pi*fsNominal/p,
    duration=1,
    offset=-2*pi*fsNominal/p) annotation (Placement(transformation(extent={{100,30},{80,50}})));
  parameter ParameterRecords.IMC imcData "Induction machine parameters" annotation (Placement(transformation(extent={{70,70},{90,90}})));
equation
  connect(ground.pin, star.pin_n)
    annotation (Line(points={{-80,20},{-80,20}}, color={85,170,255}));
  connect(star.plug_p, voltageSource.plug_n) annotation (Line(points={{-60,20},{-60,30}}, color={85,170,255}));
  connect(powerSensor.currentN, currentRMSSensor.plug_p) annotation (Line(points={{-20,80},{-10,80}}, color={85,170,255}));
  connect(powerSensor.voltageP, powerSensor.currentP) annotation (Line(points={{-30,90},{-40,90},{-40,80}}, color={85,170,255}));
  connect(powerSensor.voltageN, star.plug_p) annotation (Line(points={{-30,70},{-30,20},{-60,20}}, color={85,170,255}));
  connect(terminalBox.plug_sn, imc.plug_sn) annotation (Line(
      points={{24,50},{24,50}},
      color={85,170,255}));
  connect(terminalBox.plug_sp, imc.plug_sp) annotation (Line(
      points={{36,50},{36,50}},
      color={85,170,255}));
  connect(starMachine.plug_p, terminalBox.starpoint) annotation (
      Line(
      points={{-10,40},{-10,52},{21,52}},
      color={85,170,255}));
  connect(currentRMSSensor.plug_n, terminalBox.plugSupply) annotation (Line(points={{10,80},{30,80},{30,52}}, color={85,170,255}));
  connect(starMachine.pin_n, groundMachine.pin) annotation (Line(
      points={{-10,20},{-10,20}},
      color={85,170,255}));
  connect(imc.flange, speed.flange) annotation (Line(points={{40,40},{50,40}}, color={0,0,0}));
  connect(ramp.y, speed.w_ref) annotation (Line(points={{79,40},{72,40}}, color={0,0,127}));
  connect(voltageSource.plug_p, powerSensor.currentP) annotation (Line(points={{-60,50},{-60,80},{-40,80}}, color={85,170,255}));
  annotation (experiment(Interval=0.0001, Tolerance=1e-06),
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
        Text(
          extent={{20,8},{100,0}},
                  textStyle={TextStyle.Bold},
          textString="%m phase quasi static",
          lineColor={0,0,0})}),
    Documentation(info="<html>

<h4>Description</h4>

<p>
This examples allows the investigation of characteristic curves of quasi static multi phase induction machines with squirrel cage rotor 
against per unit rotor speed.
</p>

<h4>Plot the following variable(s)</h4>

<ul>
<li><code>imc.powerBalance.powerStator</code> against <code>perUnitSpeed</code>: active electrical stator power</li>
<li><code>imc.powerBalance.powerMechanical</code> against <code>perUnitSpeed</code>: mechanical power</li>
<li><code>imc.powerBalance.lossPowerTotal</code> as a f unction of <code>perUnitSpeed</code>: total loss power</li>
<li><code>imc.tauElectrical</code> against <code>perUnitSpeed</code>: electromagnetic torque</li>
<li><code>imc.abs_is[1]</code> against <code>perUnitSpeed</code>: RMS stator current of phase 1</li>
<li><code>imc.abs_ir[1]</code> against <code>perUnitSpeed</code>: RMS rotor current of phase 1 (equivalent rotor cage with <code>m</code> phases)</li>
<li><code>imc.is[1].im</code> against <code>imc.is[1].re</code>: stator current locus of phase 1</li>
<li><code>imc.ir[1].im</code> against <code>imc.ir[1].re</code>: rotor current locus of phase 1</li>
<li><code>imc.stator.electroMagneticConverter.Phi.im</code> against <code>imc.stator.electroMagneticConverter.Phi.re</code>: stator flux locus</li>
<li><code>imc.airGap.Phi_s.im</code> against <code>imc.airGap.Phi_s.re</code>: main (air gap) flux locus</li>
<li><code>imc.rotorCage.electroMagneticConverter.Phi.im</code> against <code>imc.rotorCage.electroMagneticConverter.Phi.re</code>: rotor flux locus</li>



</ul>
</html>"));
end IMC_Characteristics;
