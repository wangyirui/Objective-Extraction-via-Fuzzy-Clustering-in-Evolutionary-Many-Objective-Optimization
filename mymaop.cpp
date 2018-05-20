
#include <WINDOWS.H>      
#include <stdio.h>
#include <math.h>
#include <malloc.h>
#include <mex.h>
#include <WINDOWS.H>      
#include <stdio.h>
#include <math.h>
#include <malloc.h>
#define PI 3.1415926535897932384626433832795029

void mymaop(double *, double *, double *, int,int, int, int);

void mexFunction (int nlhs, mxArray * plhs[], int nrhs, const mxArray * prhs[]) 
{
	int  dimx1,dimx2,numx,dimy;
	double  *rho,  *x, *y;
	
	dimx1 = mxGetM (prhs[0]);
	numx  = mxGetN (prhs[0]);
	x     = mxGetPr (prhs[0]);

	dimx2 = mxGetM (prhs[1]);
	dimy  = mxGetN (prhs[1]);
	rho   = mxGetPr (prhs[1]);

	plhs[0] = mxCreateDoubleMatrix(dimy, numx, mxREAL);
	y       = mxGetPr (plhs[0]);

	mymaop(&x[0], &rho[0], &y[0], dimx1,dimx2, numx, dimy);
}



void mymaop(double *x, double *rho, double *y, int dimx1, int dimx2, int numx, int dimy)
{
	double alpha;
	double beta,temp;
	int ii, jj, kk; 
	for(ii=0;ii<numx;ii++){
	    beta   = 0.0;
		for(kk=dimx2;kk<dimx1;kk++){
			temp  = *(x+ii*dimx1+kk)-2*(*(x+ii*dimx1+1))*sin(2*PI*(*(x+ii*dimx1+0))+(kk+1)*PI/dimx1);
			beta  += temp*temp;
		}
		for(jj=0;jj<dimy;jj++){
			alpha  = 0.0;
			for (kk=0;kk<dimx2;kk++){
				temp   = *(x+ii*dimx1+kk)-*(rho+jj*dimx2+kk);
				alpha += temp*temp;
			}
			alpha      = sqrt(alpha);
			y[ii*dimy+jj]=alpha+beta;
		}
	}
}


