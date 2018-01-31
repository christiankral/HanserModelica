within HanserModelica.SynchronousMachines;
model SMEE_LoadImpedance3 "Electrical excited synchronous machine operating at variable load impedance with angle 0"
  import Modelica.Constants.pi;
  extends SMEE_LoadImpedance1(phi=0);
end SMEE_LoadImpedance3;
