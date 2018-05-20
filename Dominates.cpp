#include "mex.h"
#include <cmath>

int dominate(double *x_cost, double *y_cost, double xconstr, double yconstr, int nobj)
{
    int anyBetter = 0;
	int anyWorse  = 0;
    int all_better		 = 0;
	int all_worse		 = 0;

	if(xconstr==0 && yconstr==0)
	{
		for (int i=0; i<nobj; i++)
		{
			if (x_cost[i] <= y_cost[i] + 1.0E-7)
			{
                all_better++;
                anyBetter += x_cost[i]<y_cost[i]+ 1.0E-7  ? 1:0;
			}
			else
			{
				if (x_cost[i] + 1.0E-7 >= y_cost[i])
				{
                    all_worse++;
                    anyWorse += x_cost[i] + 1.0E-7 >y_cost[i] ? 1:0;
				}
			}
		}
		if(all_better == nobj && anyBetter > 0) 
            return 1;
        if(all_worse  == nobj && anyWorse  > 0) 
            return -1;
        
        return 0;
	}
	else
	{
		if(xconstr < 0 && yconstr < 0)
		{
			if(xconstr > yconstr)
			{
				return 1;
			}
			else
			{
				if(xconstr < yconstr)
				{
					return -1;
				}
				else
				{
					return 0;
				}
			}
		}
		else
		{
			if (xconstr < 0 && yconstr ==0)
			{
				return -1;
			}
			else
			{
				if (xconstr == 0 && yconstr < 0)
				{
					return 1;
				}
			}
		}
	}

	

}


void mexFunction(int nlhs, mxArray *plhs[], int nrhs,
                 const mxArray *prhs[])
{
	double *b;
// 	// Check for proper number of arguments.
//   	if(nrhs != 4)
//  	{
//   		mexErrMsgTxt("Four input required.");
//  	} 
//  	else if(nlhs != 1)
//   	{
//  		mexErrMsgTxt("One output arguments");
//   	}

  	double *x_cost = mxGetPr(prhs[0]);
  	double *y_cost = mxGetPr(prhs[1]);

//   	int nobj1 = mxGetM(prhs[0]);
//   	int nobj2 = mxGetM(prhs[1]);
//   	if (nobj1 != nobj2)
//   	{
//   		mexErrMsgTxt("nobj1 != nobj2");
//   	}
    int nobj = mxGetM(prhs[0]);
  	double *x_constr = mxGetPr(prhs[2]);
  	double *y_constr = mxGetPr(prhs[3]);
  	int n_constr = mxGetN(prhs[2]);
  	double xconstr = 0.0;
  	double yconstr = 0.0;

  	for(int i = 0; i < n_constr; i++)
  	{
  		xconstr += x_constr[i];
        yconstr += y_constr[i];
  	}


  	plhs[0] = mxCreateDoubleMatrix(1,1, mxREAL);
  	b=mxGetPr(plhs[0]); 
  	b[0]=dominate(x_cost, y_cost, xconstr, yconstr, nobj);

}