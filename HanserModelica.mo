within ;
package HanserModelica

  extends Modelica.Icons.ExamplesPackage;

  model Electrical1
    extends Modelica.Icons.Example;
    // Parameters are constant variables
    parameter Real R = 10 "Resistance";
    parameter Real L = 2 "Inductance";
    parameter Real v = 20 "Total DC voltage";
    Real vR "Voltage drop of resistor";
    Real vL "Voltage drop of inductor";
    Real i "Current";
  initial equation
    i = 0;
  equation
    // 3 equation, 3 unknowns
    v = vR + vL;
    vR = R*i;
    vL = L*der(i);
  end Electrical1;

  model Electrical2
    extends Modelica.Icons.Example;
    // Parameters are constant variables
    parameter Real R(quantity="resistance",unit="Ohm") = 10 "Resistance";
    parameter Real L(quantity="inductance",unit="H") = 2 "Inductance";
    parameter Real v(quantity="voltage",unit="V") = 20 "Total DC voltage";
    Real vR(quantity="voltage",unit="V") "Voltage drop of resistor";
    Real vL(quantity="voltage",unit="V") "Voltage drop of inductor";
    Real i(quantity="current",unit="A") "Current";
  initial equation
    i = 0;
  equation
    // 3 equation, 3 unknowns
    v = vR + vL;
    vR = R*i;
    vL = L*der(i);
  end Electrical2;

  model Electrical3
    extends Modelica.Icons.Example;
    // Parameters are constant variables
    parameter Modelica.SIunits.Resistance R = 10 "Resistance";
    parameter Modelica.SIunits.Inductance L = 2 "Inductance";
    parameter Modelica.SIunits.Voltage v = 20 "Total DC voltage";
    Modelica.SIunits.Voltage vR "Voltage drop of resistor";
    Modelica.SIunits.Voltage vL "Voltage drop of inductor";
    Modelica.SIunits.Current i "Current";
  initial equation
    i = 0;
  equation
    // 3 equation, 3 unknowns
    v = vR + vL;
    vR = R*i;
    vL = L*der(i);
  end Electrical3;

  model Electrical4
    extends Modelica.Icons.Example;
    // Parameters are constant variables
    parameter Modelica.SIunits.Resistance R = 10 "Resistance";
    parameter Modelica.SIunits.Inductance L = 2 "Inductance";
    parameter Modelica.SIunits.Voltage v = 20 "Total DC voltage";
    Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(transformation(extent={{-50,-20},{-30,0}})));
    Modelica.Electrical.Analog.Sources.ConstantVoltage constantVoltage(V=v)
                                                                       annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-40,20})));
    Modelica.Electrical.Analog.Basic.Resistor resistor(R=R) annotation (Placement(transformation(extent={{-20,30},{0,50}})));
    Modelica.Electrical.Analog.Basic.Inductor inductor(L=L) annotation (Placement(transformation(extent={{20,30},{40,50}})));
  initial equation
    inductor.i = 0;
  equation
    connect(constantVoltage.n, ground.p) annotation (Line(points={{-40,10},{-40,0}}, color={0,0,255}));
    connect(constantVoltage.p, resistor.p) annotation (Line(points={{-40,30},{-40,40},{-20,40}}, color={0,0,255}));
    connect(resistor.n, inductor.p) annotation (Line(points={{0,40},{20,40}}, color={0,0,255}));
    connect(inductor.n, ground.p) annotation (Line(points={{40,40},{60,40},{60,0},{-40,0}}, color={0,0,255}));
  end Electrical4;

  model Aliasing
    extends Modelica.Icons.Example;
    Modelica.Blocks.Sources.Sine sine(freqHz=500)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  equation

  end Aliasing;

  model Exercise01a
    extends Modelica.Icons.Example;
    parameter Modelica.SIunits.SpecificHeatCapacity c = 4180
      "Specific heat capacity of water";
    parameter Modelica.SIunits.Mass m = 100 "Mass of water";
    parameter Modelica.SIunits.HeatFlowRate Q_flow = 10E3 "Heat flow rate";
    parameter Modelica.SIunits.Temperature TStart = 20+273.15
      "Start temperature of water";
    parameter Modelica.SIunits.Temperature TAmbient = 20+273.15
      "Ambient temperature";

    Modelica.Thermal.HeatTransfer.Components.HeatCapacitor water(C=c*m, T(start=
            TStart)) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={-20,-10})));
    Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlow(
                  T_ref=TAmbient, Q_flow=Q_flow)
      annotation (Placement(transformation(extent={{-60,0},{-40,20}})));
  equation

    connect(fixedHeatFlow.port, water.port) annotation (Line(
        points={{-40,10},{-20,10},{-20,0}},
        color={191,0,0},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics));
  end Exercise01a;

  model Exercise01b
    extends Modelica.Icons.Example;
    parameter Modelica.SIunits.SpecificHeatCapacity c = 4180
      "Specific heat capacity of water";
    parameter Modelica.SIunits.Mass m = 100 "Mass of water";
    parameter Modelica.SIunits.HeatFlowRate Q_flow = 10E3 "Heat flow rate";
    parameter Modelica.SIunits.Temperature TStart = 20+273.15
      "Start temperature of water";
    parameter Modelica.SIunits.Temperature TAmbient = 20+273.15
      "Ambient temperature";
    parameter Modelica.SIunits.ThermalResistance R = 0.0012
      "Thermal resistance";

    Modelica.Thermal.HeatTransfer.Components.HeatCapacitor water(C=c*m, T(start=
            TStart)) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={-20,-10})));
    Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlow(
                  T_ref=TAmbient, Q_flow=Q_flow)
      annotation (Placement(transformation(extent={{-60,0},{-40,20}})));
    Modelica.Thermal.HeatTransfer.Components.ThermalResistor thermalResistor(R=R)
      annotation (Placement(transformation(extent={{0,0},{20,20}})));
    Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T=
          TAmbient)
      annotation (Placement(transformation(extent={{60,0},{40,20}})));
  equation

    connect(fixedHeatFlow.port, water.port) annotation (Line(
        points={{-40,10},{-20,10},{-20,0}},
        color={191,0,0},
        smooth=Smooth.None));
    connect(water.port, thermalResistor.port_a) annotation (Line(
        points={{-20,0},{-20,10},{-4.44089e-16,10}},
        color={191,0,0},
        smooth=Smooth.None));
    connect(thermalResistor.port_b, fixedTemperature.port) annotation (Line(
        points={{20,10},{40,10}},
        color={191,0,0},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics));
  end Exercise01b;

  model Exercise02a
    extends Modelica.Icons.Example;
    Modelica.Electrical.Analog.Basic.Ground ground
      annotation (Placement(transformation(extent={{-70,-40},{-50,-20}})));
    Modelica.Electrical.Analog.Basic.Resistor r1(R=1) annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={-30,20})));
    Modelica.Electrical.Analog.Basic.Resistor r2(R=1) annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={40,0})));
    Modelica.Electrical.Analog.Sources.ConstantVoltage v2(V=10) annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-60,0})));
    Modelica.Electrical.Analog.Sources.ConstantCurrent i1(I=10) annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={0,0})));
    Modelica.Electrical.Analog.Basic.Resistor rL(R=4.5) annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={80,0})));
  equation
    connect(v2.n, ground.p) annotation (Line(
        points={{-60,-10},{-60,-20}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(v2.p, r1.p) annotation (Line(
        points={{-60,10},{-60,20},{-40,20}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(r1.n, r2.p) annotation (Line(
        points={{-20,20},{40,20},{40,10}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(r1.n, i1.n) annotation (Line(
        points={{-20,20},{0,20},{0,10}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(ground.p, i1.p) annotation (Line(
        points={{-60,-20},{0,-20},{0,-10}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(i1.p, r2.n) annotation (Line(
        points={{0,-10},{0,-20},{40,-20},{40,-10}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(r2.p, rL.p) annotation (Line(
        points={{40,10},{40,20},{80,20},{80,10}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(r2.n, rL.n) annotation (Line(
        points={{40,-10},{40,-20},{80,-20},{80,-10}},
        color={0,0,255},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{
              -100,-100},{100,100}}), graphics={Rectangle(
            extent={{-80,40},{60,-40}},
            lineColor={0,0,0},
            pattern=LinePattern.Dash,
            fillColor={255,255,170},
            fillPattern=FillPattern.Solid)}));
  end Exercise02a;
  annotation (uses(Modelica(version="3.2.2")));
end HanserModelica;
