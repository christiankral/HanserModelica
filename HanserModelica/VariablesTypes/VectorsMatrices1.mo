within HanserModelica.VariablesTypes;
model VectorsMatrices1
  extends Modelica.Icons.Example;
  parameter Real a[3]={1,2,3};   // a = {1,2,3}
  parameter Real[3] b={3,2,1};   // b = {3,2,1} alternative syntax
  parameter Real c[3]=zeros(3);  // c = {0,0,0}
  parameter Real d[:]=ones(3);   // d = {1,1,1}
  parameter Real e[3]=fill(4,3); // e = {4,4,4}
  parameter Real f[:]=a.*e;      // f = {4,8,12} <- f[i] = a[i]*e[i]
  parameter Real g[:]={a[i]*e[i] for i in 1:size(a,1)}; // g = f
  parameter Real h=a*e;          // h = 24 (inner product)
  parameter Real i[:]={(i-1)/5 for i in 1:5};
                                 // g = {0,0.2,0.4,0.6,0.8}
  parameter Real s=sum(a);       // s = 6 (sum)
  parameter Real p=product(a);   // p = 6 (product)
  parameter Real l=size(a,1);    // l = 3 (length of vector)
  parameter Real y=a[1]*3+a[3];  // y = 6 (element access)
  Real z[3];                     // Variable, not parameter

equation
  z[1:2]={sin(2*Modelica.Constants.pi*time),cos(2*Modelica.Constants.pi*time)};
  z[3]=sqrt(z[1]^2+z[2]^2);
end VectorsMatrices1;
