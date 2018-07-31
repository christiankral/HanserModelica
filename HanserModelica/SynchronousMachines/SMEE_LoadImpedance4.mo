within HanserModelica.SynchronousMachines;
model SMEE_LoadImpedance4 "Electrical excited synchronous machine operating at variable load impedance with angle 30° ind."
  import Modelica.Constants.pi;
  extends SMEE_LoadImpedance1(phi=30*pi/180);
  annotation (Documentation(info="<html>
<p>Compare the simulation results of this simulation model with results calculated by 
<a href=\"modelica://HanserModelica.SynchronousMachines.SMEE_LoadImpedance1\">SMEE_LoadImpedance1</a>.</p>
</html>"));
end SMEE_LoadImpedance4;
