within HanserModelica.Thermal;
model Coupling "Electro-thermal coupling"
  extends Modelica.Icons.Example;
  parameter Modelica.SIunits.Voltage v = 100 "DC supply voltage";
  parameter Modelica.SIunits.Resistance RRef = 10 "Resistance at TRef";
  parameter Modelica.SIunits.Temperature TRef = 20+273.15 "Reference temperature";
  parameter Modelica.SIunits.LinearTemperatureCoefficient alphaRef = 0.004
    "Linear temperature coefficient at reference temperature";
  parameter Modelica.SIunits.Temperature TAmbient = 20+273.15 "Ambient temperature";
  parameter Modelica.SIunits.ThermalResistance R = 0.08 "Thermal resistance";
  parameter Modelica.SIunits.HeatCapacity C = 1500 "Thermal capacitance";
  Modelica.Electrical.Analog.Basic.Resistor resistor(
    R=RRef,
    T_ref=TRef,
    alpha=alphaRef,
    useHeatPort=true)  annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={-10,-10})));
  Modelica.Electrical.Analog.Sources.ConstantVoltage constantVoltage(V=v)
                                                                     annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={-70,-10})));
  Modelica.Electrical.Analog.Basic.Ground ground
    annotation (Placement(transformation(extent={{-80,-50},{-60,-30}})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor(
      T(start=TAmbient), C=C)
                         annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={20,-30})));
  Modelica.Thermal.HeatTransfer.Components.ThermalResistor thermalResistor(R=R)
    annotation (Placement(transformation(extent={{40,-20},{60,0}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T=TAmbient)
    annotation (Placement(transformation(extent={{100,-20},{80,0}})));
  Modelica.Electrical.Analog.Ideal.IdealClosingSwitch switch annotation (Placement(transformation(extent={{-50,0},{-30,20}})));
  Modelica.Blocks.Sources.BooleanPulse booleanPulse(period=20, width=50) annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
equation
  connect(constantVoltage.n, resistor.n) annotation (Line(
      points={{-70,-20},{-70,-30},{-10,-30},{-10,-20}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(constantVoltage.n, ground.p) annotation (Line(
      points={{-70,-20},{-70,-30}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(resistor.heatPort,heatCapacitor. port) annotation (Line(
      points={{0,-10},{20,-10},{20,-20}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(resistor.heatPort,thermalResistor. port_a) annotation (Line(
      points={{0,-10},{40,-10}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(thermalResistor.port_b,fixedTemperature. port) annotation (Line(
      points={{60,-10},{80,-10}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(constantVoltage.p, switch.p) annotation (Line(points={{-70,-1.77636e-15},{-70,10},{-50,10}}, color={0,0,255}));
  connect(switch.n, resistor.p) annotation (Line(points={{-30,10},{-10,10},{-10,-1.77636e-15}}, color={0,0,255}));
  connect(booleanPulse.y, switch.control) annotation (Line(points={{-59,30},{-40,30},{-40,22}}, color={255,0,255}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})), experiment(
      StopTime=400,
      Interval=0.1,
      Tolerance=1e-06));
end Coupling;
