within HanserModelica.Machines;
model EquivalentCircuit "Comparison of equivalent circuits of electric and magnetic circuits"
  extends Modelica.Icons.Example;
  constant Integer m=3 "Number of phases";
  parameter Modelica.SIunits.Voltage VNominal = 400 "Nominal phase voltage";
  parameter Modelica.SIunits.Frequency fNominal = 50 "Nominal frequency";
  // Equivalent electric circuit
  parameter Modelica.SIunits.Resistance R=0.56 "Winding resistance";
  parameter Modelica.SIunits.Inductance Lsigma=4.848E-3 "Stray inductance";
  parameter Modelica.SIunits.Inductance Lm=0.2114 "Magnetizing inductance";
  parameter Real effectiveTurns = 135.0 "Number of effective turns";
  parameter Modelica.SIunits.Conductance Gc=908.2E-6 "Electric loss conductance";
  // Equivalent magnetic circuit
  parameter Modelica.SIunits.Conductance G=m*effectiveTurns^2*Gc/2 "Magnetic loss conductance";
  parameter Modelica.SIunits.Reluctance R_msigma=m*effectiveTurns^2/2/Lsigma "Stray reluctance";
  parameter Modelica.SIunits.Reluctance R_m=m*effectiveTurns^2/2/Lm "Main field reluctance";
  Modelica.SIunits.ComplexCurrent i_e[m] = resistor_e.i "Current of electric circuit";
  Modelica.SIunits.ComplexCurrent i_m[m] = resistor_m.i "Current of magnetic circuit";
  Modelica.SIunits.Power coreLoss_e=sum(core_e.conductor.LossPower);
  Modelica.SIunits.Power coreLoss_m=core_m.lossPower;
  Modelica.Electrical.QuasiStationary.MultiPhase.Sources.VoltageSource
    sineVoltage_e(m=m,phi=-Modelica.Electrical.MultiPhase.Functions.symmetricOrientation(m),
    gamma(fixed=true, start=0),f=fNominal,V=fill(VNominal, m))
    annotation (Placement(transformation(extent={{-10,10},{10,-10}},rotation=270,origin={-70,70})));
  Modelica.Electrical.QuasiStationary.MultiPhase.Sources.VoltageSource
    sineVoltage_m(m=m,phi=-Modelica.Electrical.MultiPhase.Functions.symmetricOrientation(m),
    gamma(fixed=true, start=0),f=fNominal,V=fill(VNominal, m))
    annotation (Placement(transformation(extent={{-10,10},{10,-10}},rotation=270,origin={-70,-30})));
  Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Resistor
    resistor_e(m=m, R_ref=fill(R, m))
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},origin={-50,80})));
  Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Resistor
    resistor_m(m=m, R_ref=fill(R, m))
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},origin={-50,-20})));
  Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Conductor core_e(
     m=m, G_ref=fill(Gc, m))
     annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation=270,origin={10,70})));
  Modelica.Magnetic.QuasiStatic.FundamentalWave.Components.MultiPhaseElectroMagneticConverter
    converter_m(m=m, effectiveTurns=effectiveTurns)
    annotation (Placement(transformation(extent={{0,-40},{20,-20}})));
  Modelica.Magnetic.QuasiStatic.FundamentalWave.Components.EddyCurrent core_m(G=G)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},origin={40,-20})));
  Modelica.Magnetic.QuasiStatic.FundamentalWave.Components.Reluctance main_m(
    R_m(d=R_m, q=R_m))
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation=270,origin={90,-30})));
  Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Inductor stray_e(m=m, L=fill(Lsigma, m))
    annotation (Placement(transformation(extent={{20,70},{40,90}})));
  Modelica.Magnetic.QuasiStatic.FundamentalWave.Components.Reluctance stray_m(R_m(d=R_msigma, q=R_msigma))
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation=270,origin={60,-30})));
  Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Inductor main_e(m=m, L=fill(Lm, m))
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation=270,origin={50,70})));
  Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.PowerSensor powerb_e(m=m)
    annotation (Placement(transformation(extent={{-30,70},{-10,90}})));
  Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.PowerSensor powerb_m(m=m)
    annotation (Placement(transformation(extent={{-30,-30},{-10,-10}})));
  Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Ground ground_e
    annotation (Placement(transformation(extent={{-80,10},{-60,30}})));
  Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Ground ground_m
    annotation (Placement(transformation(extent={{-80,-90},{-60,-70}})));
  Modelica.Magnetic.QuasiStatic.FundamentalWave.Components.Ground mground_m
    annotation (Placement(transformation(extent={{10,-90},{30,-70}})));
  Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Star star_e(m=m)
    annotation (Placement(transformation(extent={{-10,10},{10,-10}},rotation=270,origin={-70,40})));
  Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Star star_m(m=m)
    annotation (Placement(transformation(extent={{-10,10},{10,-10}},rotation=270,origin={-70,-60})));
equation
  connect(sineVoltage_e.plug_n, star_e.plug_p) annotation (Line(
      points={{-70,60},{-70,50}}, color={85,170,255}));
  connect(resistor_e.plug_p, sineVoltage_e.plug_p) annotation (Line(
      points={{-60,80},{-70,80}}, color={85,170,255}));
  connect(core_e.plug_n, sineVoltage_e.plug_n) annotation (Line(
      points={{10,60},{-70,60}},color={85,170,255}));
  connect(resistor_e.plug_n, powerb_e.currentP) annotation (Line(
      points={{-40,80},{-30,80}}, color={85,170,255}));
  connect(star_e.pin_n, ground_e.pin) annotation (Line(
      points={{-70,30},{-70,30}}, color={85,170,255}));
  connect(powerb_e.currentP, powerb_e.voltageP) annotation (Line(
      points={{-30,80},{-30,90},{-20,90}}, color={85,170,255}));
  connect(powerb_e.voltageN, sineVoltage_e.plug_n) annotation (Line(
      points={{-20,70},{-20,60},{-70,60}}, color={85,170,255}));
  connect(sineVoltage_m.plug_n, star_m.plug_p) annotation (Line(
      points={{-70,-40},{-70,-50}}, color={85,170,255}));
  connect(sineVoltage_m.plug_n, converter_m.plug_n) annotation (Line(
      points={{-70,-40},{0,-40}},  color={85,170,255}));
  connect(converter_m.port_n, main_m.port_n) annotation (Line(points={{20,-40},{90,-40}}, color={255,170,85}));
  connect(converter_m.port_p,core_m. port_p) annotation (Line(
      points={{20,-20},{30,-20}}, color={255,170,85}));
  connect(core_m.port_n, main_m.port_p) annotation (Line(points={{50,-20},{90,-20}}, color={255,170,85}));
  connect(converter_m.port_n, mground_m.port_p) annotation (Line(
      points={{20,-40},{20,-70}}, color={255,170,85}));
  connect(sineVoltage_m.plug_p, resistor_m.plug_p) annotation (Line(
      points={{-70,-20},{-60,-20}}, color={85,170,255}));
  connect(resistor_m.plug_n, powerb_m.currentP) annotation (Line(
      points={{-40,-20},{-30,-20}}, color={85,170,255}));
  connect(powerb_m.currentN, converter_m.plug_p) annotation (Line(
      points={{-10,-20},{0,-20}},  color={85,170,255}));
  connect(star_m.pin_n, ground_m.pin) annotation (Line(
      points={{-70,-70},{-70,-70}}, color={85,170,255}));
  connect(powerb_m.currentP, powerb_m.voltageP) annotation (Line(
      points={{-30,-20},{-30,-10},{-20,-10}}, color={85,170,255}));
  connect(powerb_m.voltageN, sineVoltage_m.plug_n) annotation (Line(
      points={{-20,-30},{-20,-40},{-70,-40}}, color={85,170,255}));
  connect(powerb_e.currentN,core_e. plug_p) annotation (Line(points={{-10,80},{10,80}},      color={85,170,255}));
  connect(core_e.plug_p, stray_e.plug_p) annotation (Line(points={{10,80},{20,80}}, color={85,170,255}));
  connect(stray_e.plug_n, main_e.plug_p) annotation (Line(points={{40,80},{50,80}}, color={85,170,255}));
  connect(core_e.plug_n, main_e.plug_n) annotation (Line(points={{10,60},{50,60}}, color={85,170,255}));
  connect(core_m.port_n, stray_m.port_p) annotation (Line(points={{50,-20},{60,-20}}, color={255,170,85}));
  connect(stray_m.port_n, converter_m.port_n) annotation (Line(points={{60,-40},{20,-40}}, color={255,170,85}));
  annotation (experiment(StopTime=1, Interval=0.1, Tolerance=1E-6),
    Documentation(info="<html>
<p>
In this example the eddy current losses are implemented in two different ways. Compare the core losses <code>coreLoss_e</code> and <code>coreLoss_m</code>.</p>
</html>"),
    Diagram(coordinateSystem(extent={{-100,-100},{100,100}}, initialScale=0.1)),
    Icon(coordinateSystem(                                initialScale=0.1)));
end EquivalentCircuit;
