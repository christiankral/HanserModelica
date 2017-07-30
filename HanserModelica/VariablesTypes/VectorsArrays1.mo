within HanserModelica.VariablesTypes;
model VectorsArrays1
  extends Modelica.Icons.Example;
  parameter Real a[3]={1,2,3};
  parameter Real b[3]={cos(i*2*Modelica.Constants.pi/3)
                         for i in 1:3};
  parameter Real c[3]=zeros(3);  // ={0,0,0}
  parameter Real d[:]=ones(3);   // ={1,1,1}
  parameter Real e[3]=fill(4,3); // ={4,4,4}
  parameter Real f[:]=a.*e;      // ={4,8,12}
  parameter Real ae=a*e;         // =24
  parameter Real x=sum(a);       // =6
  parameter Real y=a[1]*3+a[3];  // =6
  Real z[3];                     // Variable, not parameter

equation
  z[1]=sin(2*Modelica.Constants.pi*time);
  z[2]=cos(2*Modelica.Constants.pi*time);
  z[3]=sqrt(z[1]^2+z[2]^2);
end VectorsArrays1;
