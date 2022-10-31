within HanserModelica.InductionMachines;
model IMC_withLosses "Induction machine with squirrel cage and losses"
  extends Modelica.Icons.Example;
  import Modelica.Constants.pi;
  constant Integer m=3 "Number of phases";
  Modelica.Units.SI.Power Ps=electricalPowerSensor.apparentPower.re
    "Stator active power";
  Modelica.Units.SI.ReactivePower Qs=electricalPowerSensor.apparentPower.im
    "Stator reactive power";
  Modelica.Units.SI.ApparentPower Ss=sqrt(Ps^2 + Qs^2) "Stator apparent power";
protected
  parameter Real Ptable[:]={1E-6,1845,3549,5325,7521,9372,11010,12930,
      14950,16360,18500,18560,20180,22170} "Table of measured power data";
  parameter Real Itable[:]={11.0,11.20,12.27,13.87,16.41,18.78,21.07,
      23.92,27.05,29.40,32.85,32.95,35.92,39.35} "Table of measured current data";
  parameter Real wtable[:]=Modelica.Units.Conversions.from_rpm(  {1500,1496,1493,1490,1486,1482,1479,1475,1471,
      1467,1462,1462,1458,1453}) "Table of measured speed data";
  parameter Real ctable[:]={0.085,0.327,0.506,0.636,0.741,0.797,0.831,
      0.857,0.875,0.887,0.896,0.896,0.902,0.906} "Table of measured power factor data";
  parameter Real etable[:]={0,0.7250,0.8268,0.8698,0.8929,0.9028,0.9064,
      0.9088,0.9089,0.9070,0.9044,0.9043,0.9008,0.8972} "Table of measured efficiency data";
public
  output Modelica.Units.SI.Power Pm=powerSensor.power "Mechanical output power";
  output Modelica.Units.SI.Power Ps_sim=sqrt(3)*imcData.VsNominal*I_sim*pfs_sim
    "Simulated stator power";
  output Modelica.Units.SI.Power Ps_meas=sqrt(3)*imcData.VsNominal*I_meas*
      pfs_meas "Simulated stator power";
  output Modelica.Units.SI.Power loss_sim=Ps_sim - Pm "Simulated total losses";
  output Modelica.Units.SI.Power loss_meas=Ps_meas - Pm "Measured total losses";
  output Modelica.Units.SI.Current I_sim=currentRMSSensor.I "Simulated current";
  output Modelica.Units.SI.Current I_meas=combiTable1Ds.y[1] "Measured current";
  output Modelica.Units.SI.AngularVelocity w_sim(displayUnit="rev/min") = imc.wMechanical
    "Simulated speed";
  output Modelica.Units.SI.AngularVelocity w_meas(displayUnit="rev/min") =
    combiTable1Ds.y[2] "Measured speed";
  output Real pfs_sim=if noEvent(Ss > Modelica.Constants.small) then Ps/
      Ss else 0 "Simulated power factor";
  output Real pfs_meas=combiTable1Ds.y[3] "Measured power factor";
  output Real eff_sim=if noEvent(abs(Ps) > Modelica.Constants.small)
       then Pm/Ps else 0 "Simulated efficiency";
  output Real eff_meas=combiTable1Ds.y[4] "Measured efficiency";

  Modelica.Magnetic.QuasiStatic.FundamentalWave.BasicMachines.InductionMachines.IM_SquirrelCage imc(
    p=imcData.p,
    fsNominal=imcData.fsNominal,
    TsRef=imcData.TsRef,
    alpha20s(displayUnit="1/K") = imcData.alpha20s,
    Jr=imcData.Jr,
    Js=imcData.Js,
    frictionParameters=imcData.frictionParameters,
    statorCoreParameters=imcData.statorCoreParameters,
    strayLoadParameters=imcData.strayLoadParameters,
    TrRef=imcData.TrRef,
    wMechanical(fixed=true, start=imcData.w0),
    gammar(fixed=true, start=pi/2),
    gamma(fixed=true, start=-pi/2),
    Rs=imcData.Rs*m/3,
    Lssigma=imcData.Lssigma*m/3,
    Lm=imcData.Lm*m/3,
    Lrsigma=imcData.Lrsigma*m/3,
    Rr=imcData.Rr*m/3,
    m=m,
    effectiveStatorTurns=imcData.effectiveStatorTurns,
    TsOperational=imcData.TNominal,
    alpha20r=imcData.alpha20r,
    TrOperational=imcData.TNominal)
                               annotation (Placement(transformation(extent={{-20,60},{0,80}})));
  Modelica.Magnetic.QuasiStatic.FundamentalWave.Utilities.MultiTerminalBox terminalBox(terminalConnection="D", m=m) annotation (Placement(transformation(extent={{-20,76},{0,96}})));
  Modelica.Electrical.QuasiStatic.Polyphase.Sensors.PowerSensor
    electricalPowerSensor(m=m) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-40,90})));
  Modelica.Electrical.QuasiStatic.Polyphase.Sensors.CurrentQuasiRMSSensor
    currentRMSSensor(m=m) annotation (Placement(transformation(
        origin={-70,90},
        extent={{-10,10},{10,-10}},
        rotation=0)));
  Modelica.Electrical.QuasiStatic.Polyphase.Sources.VoltageSource sineVoltage(
    final m=m,
    f=imcData.fsNominal,
    V=fill(imcData.VsNominal/sqrt(3), m)) annotation (Placement(transformation(
        origin={-90,70},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.QuasiStatic.Polyphase.Basic.Star star(final m=m)
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-90,40})));
  Modelica.Electrical.QuasiStatic.SinglePhase.Basic.Ground ground annotation (
      Placement(transformation(origin={-90,10}, extent={{-10,-10},{10,10}})));
  Modelica.Mechanics.Rotational.Sensors.PowerSensor powerSensor annotation (Placement(transformation(extent={{10,60},{30,80}})));
  Modelica.Mechanics.Rotational.Components.Inertia loadInertia(J=imcData.Jr) annotation (Placement(transformation(extent={{40,60},{60,80}})));
  Modelica.Mechanics.Rotational.Sources.Torque torque annotation (Placement(transformation(extent={{90,60},{70,80}})));
  Modelica.Blocks.Math.Gain gain(k=-1) annotation (Placement(transformation(extent={{70,0},{90,20}})));
  Modelica.Blocks.Continuous.PI PI(
    k=0.01,
    T=0.01,
    initType=Modelica.Blocks.Types.Init.InitialState) annotation (Placement(transformation(extent={{40,0},{60,20}})));
  Modelica.Blocks.Math.Feedback feedback annotation (Placement(transformation(extent={{10,20},{30,0}})));
  Modelica.Blocks.Sources.Ramp ramp(
    offset=0,
    startTime=4.5,
    duration=5.5,
    height=1.2*imcData.PmNominal)
                  annotation (Placement(transformation(extent={{-20,0},{0,20}})));
  Modelica.Blocks.Tables.CombiTable1Ds combiTable1Ds(table={{Ptable[j],Itable[j],wtable[j],ctable[j],etable[j]} for j in 1:size(Ptable, 1)}, smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative) annotation (Placement(transformation(extent={{40,30},{60,50}})));
  parameter ParameterRecords.IMC_withLosses imcData "Induction machine parameters" annotation (Placement(transformation(extent={{-60,0},{-40,20}})));
equation
  connect(star.pin_n, ground.pin) annotation (Line(points={{-90,30},{-90,20}}, color={85,170,255}));
  connect(sineVoltage.plug_n, star.plug_p) annotation (Line(points={{-90,60},{-90,50}}, color={85,170,255}));
  connect(terminalBox.plug_sn, imc.plug_sn) annotation (Line(points={{-16,80},{-16,80}}, color={85,170,255}));
  connect(terminalBox.plug_sp, imc.plug_sp) annotation (Line(points={{-4,80},{-4,80}}, color={85,170,255}));

  connect(imc.flange, powerSensor.flange_a) annotation (Line(points={{0,70},{10,70}}));
  connect(powerSensor.flange_b, loadInertia.flange_a) annotation (Line(points={{30,70},{40,70}}));
  connect(torque.flange, loadInertia.flange_b) annotation (Line(points={{70,70},{64,70},{64,70},{68,70},{68,70},{60,70}}));
  connect(sineVoltage.plug_p, currentRMSSensor.plug_p) annotation (Line(points={{-90,80},{-90,90},{-80,90}}, color={85,170,255}));
  connect(currentRMSSensor.plug_n, electricalPowerSensor.currentP) annotation (Line(points={{-60,90},{-50,90}}, color={85,170,255}));
  connect(electricalPowerSensor.currentN, terminalBox.plugSupply) annotation (Line(points={{-30,90},{-10,90},{-10,82}}, color={85,170,255}));
  connect(electricalPowerSensor.currentP, electricalPowerSensor.voltageP) annotation (Line(points={{-50,90},{-50,90},{-50,98},{-50,98},{-50,100},{-40,100},{-40,100}}, color={85,170,255}));
  connect(electricalPowerSensor.voltageN, star.plug_p) annotation (Line(points={{-40,80},{-40,50},{-90,50}}, color={85,170,255}));
  connect(powerSensor.power, combiTable1Ds.u) annotation (Line(points={{12,59},{12,40},{38,40}}, color={0,0,127}));
  connect(powerSensor.power, feedback.u2) annotation (Line(points={{12,59},{12,40},{20,40},{20,18}}, color={0,0,127}));
  connect(gain.y, torque.tau) annotation (Line(points={{91,10},{100,10},{100,70},{92,70}}, color={0,0,127}));
  connect(ramp.y, feedback.u1) annotation (Line(points={{1,10},{12,10}}, color={0,0,127}));
  connect(feedback.y, PI.u) annotation (Line(points={{29,10},{38,10}}, color={0,0,127}));
  connect(PI.y, gain.u) annotation (Line(points={{61,10},{68,10}}, color={0,0,127}));
  annotation (
    experiment(StopTime=10, Interval=0.0001, Tolerance=1e-06),
    Documentation(info="<html>

<h4>Description</h4>

<p>This example is intended to complare simulation and measurement results of a squirrel cage induction machine.</p>

<h4>Nominal machine data</h4>

<p>Machine parameters are taken from a standard 18.5 kW 400 V 50 Hz motor, simulation results are compared with measurements.</p>
<p>See:
Anton Haumer, Christian Kral, Hansj&ouml;rg Kapeller, Thomas B&auml;uml, Johannes V. Gragger
<a href=\"https://www.modelica.org/events/modelica2009/Proceedings/memorystick/pages/papers/0103/0103.pdf\">
The AdvancedMachines Library: Loss Models for Electric Machines</a>
Modelica 2009, 7<sup>th</sup> International Modelica Conference</p>

<br>

<table>
<tr><td>Nominal stator current            </td><td>     32.85  </td><td>A      </td></tr>
<tr><td>Power factor                      </td><td>      0.898 </td><td>       </td></tr>
<tr><td>Speed                             </td><td>   1462.5   </td><td>rpm    </td></tr>
<tr><td>Electrical input                  </td><td> 20,443.95  </td><td>W      </td></tr>
<tr><td>Stator copper losses              </td><td>    770.13  </td><td>W      </td></tr>
<tr><td>Stator core losses                </td><td>    410.00  </td><td>W      </td></tr>
<tr><td>Rotor  copper losses              </td><td>    481.60  </td><td>W      </td></tr>
<tr><td>Stray load losses                 </td><td>    102.22  </td><td>W      </td></tr>
<tr><td>Friction losses                   </td><td>    180.00  </td><td>W      </td></tr>
<tr><td>Mechanical output                 </td><td> 18,500.00  </td><td>W      </td></tr>
<tr><td>Efficiency                        </td><td>     90.49  </td><td>%      </td></tr>
<tr><td>Nominal torque                    </td><td>    120.79  </td><td>Nm     </td></tr>
</table>

<h4>Machine parameter</h4>

<p>In the simulation model the following machine parameters are used:</p>

<table>
<tr><td>Stator resistance per phase       </td><td>  0.56     </td><td>&Omega;</td></tr>
<tr><td>Temperature coefficient           </td><td> copper    </td><td>       </td></tr>
<tr><td>Reference temperature             </td><td> 20        </td><td>&deg;C </td></tr>
<tr><td>Operation temperature             </td><td> 90        </td><td>&deg;C </td></tr>
<tr><td>Stator leakage reactance at 50 Hz </td><td>  1.52     </td><td>&Omega;</td></tr>
<tr><td>Main  field    reactance at 50 Hz </td><td> 66.40     </td><td>&Omega;</td></tr>
<tr><td>Rotor  leakage reactance at 50 Hz </td><td>  2.31     </td><td>&Omega;</td></tr>
<tr><td>Rotor  resistance per phase       </td><td>  0.42     </td><td>&Omega;</td></tr>
<tr><td>Temperature coefficient           </td><td> aluminium </td><td>       </td></tr>
<tr><td>Reference temperature             </td><td> 20        </td><td>&deg;C </td></tr>
<tr><td>Operation temperature             </td><td> 90        </td><td>&deg;C </td></tr>
<tr><td>Effective number of stator turns  </td><td>270.1      </td><td>       </td></tr>
</table>

<h4>Plot the following variable(s)</h4>

<ul>
<li><code>I_sim</code> and <code>I_meas</code> against <code>Pm</code>: 
    simulated and measured RMS current against mechanical power</li>
<li><code>w_sim</code> and <code>w_meas</code> against <code>Pm</code>: 
    simulated and measured speed against mechanical power</li>
<li><code>pfs_sim</code> and <code>pfs_meas</code> against <code>Pm</code>: 
    simulated and measured power factor against mechanical power</li>
<li><code>loss_sim/code> and <code>loss_meas</code> against <code>Pm</code>: 
    simulated and measured total loss against mechanical power</li>
<li><code>eff_sim/code> and <code>eff_meas</code> against <code>Pm</code>: 
    simulated and measured efficiency against mechanical power</li>
</ul>
</html>"),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}), graphics={
        Text(
          extent={{-80,40},{0,32}},
                  textStyle={TextStyle.Bold},
          lineColor={0,0,0},
          textString="%m phase quasi static")}));
end IMC_withLosses;
