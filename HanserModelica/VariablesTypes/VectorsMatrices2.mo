within HanserModelica.VariablesTypes;
model VectorsMatrices2 "Example 2 on vetors and matrices"
  extends Modelica.Icons.Example;
  parameter Real A[2,2]={{1,2},{3,4}};
  parameter Real B[3,3]={{cos((i-j)*2*Modelica.Constants.pi/3)
                          for i in 0:2} for j in 0:2};
  parameter Real C[:,:]={cos((i-j)*2*Modelica.Constants.pi/3)
                          for i in 0:2, j in 0:2};
  parameter Real D[2,2]=zeros(2,2);      // = {{0,0},{0,0}}
  parameter Real E[:,:]=ones(2,2);       // = {{1,1},{1,1}}
  parameter Real F[2,2]=fill(4,2,2);     // = {{4,4},{4,4}}
  parameter Real G[:,:]=diagonal({1,2}); // = {{1,0},{0,2}}
  parameter Real S=sum(E);               // = 4
  parameter Real Y=A[1,1]*4+A[2,2];      // = 8
  annotation (Documentation(info="<html>
<h4>Description</h4>

<p>This is the second example of this package, providing different declarations of vectors and matrices.</p>
</html>"));
end VectorsMatrices2;
