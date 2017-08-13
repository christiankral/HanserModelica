within HanserModelica.Depot;
model Rectifier12pulse "12-pulse rectifier with two transformers"
  extends Modelica.Icons.Example;
  constant Integer m=3 "Number of phases";
  parameter Modelica.SIunits.Voltage V=100*sqrt(2/3)
    "Amplitude of star-voltage";
  parameter Modelica.SIunits.Frequency f=50 "Frequency";
  parameter Modelica.SIunits.Resistance RL=0.4 "Load resistance";
  parameter Modelica.SIunits.Capacitance C=0.005 "Total DC-capacitance";
  parameter Modelica.SIunits.Voltage VC0=sqrt(3)*V
    "Initial voltage of capacitance";
  Modelica.Electrical.MultiPhase.Sources.SineVoltage source(
    m=m,
    V=fill(V, m),
    freqHz=fill(f, m)) annotation (Placement(transformation(
        origin={-90,-10},
        extent={{-10,10},{10,-10}},
        rotation=270)));
  Modelica.Electrical.MultiPhase.Basic.Star starAC(m=m) annotation (
      Placement(transformation(
        origin={-90,-40},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Analog.Basic.Ground groundAC annotation (Placement(
        transformation(extent={{-100,-80},{-80,-60}})));
  Modelica.Electrical.MultiPhase.Sensors.CurrentSensor currentSensor(m=m)
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
  Modelica.Electrical.Analog.Basic.Resistor loadResistor(R=RL) annotation (Placement(transformation(
        origin={50,0},
        extent={{-10,10},{10,-10}},
        rotation=270)));
  Modelica.Electrical.Analog.Basic.Capacitor cDC1(C=2*C, v(start=VC0/2))
    annotation (Placement(transformation(
        origin={70,20},
        extent={{-10,10},{10,-10}},
        rotation=270)));
  Modelica.Electrical.Analog.Basic.Capacitor cDC2(C=2*C, v(start=VC0/2))
    annotation (Placement(transformation(
        origin={70,-20},
        extent={{-10,10},{10,-10}},
        rotation=270)));
  Modelica.Electrical.Analog.Basic.Ground groundDC annotation (Placement(
        transformation(extent={{80,-20},{100,0}})));
  parameter Modelica.Electrical.Machines.Utilities.TransformerData transformerData1(
    C1=Modelica.Utilities.Strings.substring(
        transformer1.VectorGroup,
        1,
        1),
    C2=Modelica.Utilities.Strings.substring(
        transformer1.VectorGroup,
        2,
        2),
    f=50,
    V1=100,
    V2=100,
    SNominal=30E3,
    v_sc=0.05,
    P_sc=300) annotation (Placement(transformation(extent={{-60,60},{-40,80}})));
  Modelica.Electrical.Machines.BasicMachines.Transformers.Dy.Dy01 transformer1(
    n=transformerData1.n,
    R1=transformerData1.R1,
    L1sigma=transformerData1.L1sigma,
    R2=transformerData1.R2,
    L2sigma=transformerData1.L2sigma,
    T1Ref=293.15,
    alpha20_1(displayUnit="1/K") = Modelica.Electrical.Machines.Thermal.Constants.alpha20Zero,
    T2Ref=293.15,
    alpha20_2(displayUnit="1/K") = Modelica.Electrical.Machines.Thermal.Constants.alpha20Zero,
    T1Operational=293.15,
    T2Operational=293.15) annotation (Placement(transformation(extent={{-50,30},{-30,50}})));

  Modelica.Electrical.Machines.BasicMachines.Transformers.Dd.Dd00
                                              transformer2(
    n=transformerData2.n,
    R1=transformerData2.R1,
    L1sigma=transformerData2.L1sigma,
    R2=transformerData2.R2,
    L2sigma=transformerData2.L2sigma,
    T1Ref=293.15,
    alpha20_1(displayUnit="1/K") = Modelica.Electrical.Machines.Thermal.Constants.alpha20Zero,
    T2Ref=293.15,
    alpha20_2(displayUnit="1/K") = Modelica.Electrical.Machines.Thermal.Constants.alpha20Zero,
    T1Operational=293.15,
    T2Operational=293.15) annotation (Placement(transformation(extent={{-50,
            -50},{-30,-30}})));
  parameter Modelica.Electrical.Machines.Utilities.TransformerData
                                               transformerData2(
    C1=Modelica.Utilities.Strings.substring(
              transformer2.VectorGroup,
              1,
              1),
    C2=Modelica.Utilities.Strings.substring(
              transformer2.VectorGroup,
              2,
              2),
    f=50,
    V1=100,
    V2=100,
    SNominal=30E3,
    v_sc=0.05,
    P_sc=300) annotation (Placement(transformation(extent={{-60,-80},{-40,
            -60}})));
  Modelica.Electrical.PowerConverters.ACDC.DiodeBridge2mPulse rectifier1 annotation (Placement(transformation(extent={{-10,30},{10,50}})));
  Modelica.Electrical.PowerConverters.ACDC.DiodeBridge2mPulse rectifier2 annotation (Placement(transformation(extent={{-8,-50},{12,-30}})));
initial equation
  transformer2.core.plug_p1.pin[1:3].i = zeros(3);
  cDC1.v = VC0/2;
  cDC2.v = VC0/2;
  transformer1.i2[1:2] = zeros(2);
equation
  connect(cDC1.n, cDC2.p)
    annotation (Line(points={{70,10},{70,-10}}, color={0,0,255}));
  connect(cDC1.n, groundDC.p)
    annotation (Line(points={{70,10},{70,0},{90,0}}, color={0,0,255}));
  connect(starAC.plug_p, source.plug_n)
    annotation (Line(points={{-90,-30},{-90,-20}}, color={0,0,255}));
  connect(starAC.pin_n, groundAC.p)
    annotation (Line(points={{-90,-50},{-90,-60}}, color={0,0,255}));
  connect(source.plug_p, currentSensor.plug_p)
    annotation (Line(points={{-90,0},{-85,0},{-80,0}}, color={0,0,255}));
  connect(loadResistor.p, cDC1.p) annotation (Line(points={{50,10},{50,30},{70,30}}, color={0,0,255}));
  connect(loadResistor.n, cDC2.n) annotation (Line(points={{50,-10},{50,-30},{70,-30}}, color={0,0,255}));
  connect(transformer1.plug1, currentSensor.plug_n) annotation (Line(
      points={{-50,40},{-60,40},{-60,0}}, color={0,0,255}));
  connect(currentSensor.plug_n, transformer2.plug1) annotation (Line(points={{-60,0},{-60,-40},{-50,-40}}, color={0,0,255}));
  connect(transformer1.plug2, rectifier1.ac) annotation (Line(points={{-30,40},{-10,40}}, color={0,0,255}));
  connect(transformer2.plug2, rectifier2.ac) annotation (Line(points={{-30,-40},{-8,-40}}, color={0,0,255}));
  connect(rectifier1.dc_p, cDC1.p) annotation (Line(points={{10,46},{30,46},{30,30},{70,30}}, color={0,0,255}));
  connect(rectifier2.dc_p, cDC1.p) annotation (Line(points={{12,-34},{22,-34},{22,-34},{30,-34},{30,30},{70,30}}, color={0,0,255}));
  connect(rectifier1.dc_n, loadResistor.n) annotation (Line(points={{10,34},{20,34},{20,-30},{50,-30},{50,-10}}, color={0,0,255}));
  connect(rectifier2.dc_n, loadResistor.n) annotation (Line(points={{12,-46},{16,-46},{16,-46},{20,-46},{20,-30},{50,-30},{50,-10}}, color={0,0,255}));
  annotation (Documentation(info="<html>
Test example with multiphase components:<br>
Star-connected voltage source feeds via a transformer a diode bridge rectifier with a DC burden.<br>
Using f=50 Hz, simulate for 0.1 seconds (5 periods) and compare voltages and currents of source and DC burden,
neglecting initial transient.
</html>"),
     experiment(StopTime=0.1, Interval=1E-4, Tolerance=1E-6));
end Rectifier12pulse;
