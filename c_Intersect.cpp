/*==========================================================
 * arrayProduct.c - example in MATLAB External Interfaces
 *
 * Multiplies an input scalar (multiplier) 
 * times a 1xN matrix (inMatrix)
 * and outputs a 1xN matrix (outMatrix)
 *
 * The calling syntax is:
 *
 *		outMatrix = arrayProduct(multiplier, inMatrix)
 *
 * This is a MEX-file for MATLAB.
 * Copyright 2007-2012 The MathWorks, Inc.
 *
 *========================================================*/
#include <algorithm>
#include <iostream>
#include "mex.h"
#define arrayProduct Intersect
using namespace std;
/* Quick Intersect for all integer value vector */
typedef struct
{
	int Length;
	double *Data;
}Vector;

Vector *c_Intersect(double *x, double *y, mwSize n1, mwSize n2)
{
	Vector *OutPut;
	OutPut = (Vector *)mxMalloc(sizeof(Vector));
	bool *Position;
    mwSize i;
	double maxValue = 0;
	int Range=0;
	for (i=0; i<n1 ;i++){
		maxValue=max(maxValue,x[i]);
	}
	for (i=0; i<n2 ;i++){
		maxValue=max(maxValue,y[i]);
	}
    /* compare each value, find the max integer in the two vector*/
	Range = (int)maxValue;
	OutPut->Length=0;
	Position = (bool *)mxMalloc(sizeof(bool)*Range);
	OutPut->Data = (double*)mxMalloc(sizeof(double)*Range);
	for (i=0; i<Range; i++){
		Position[i]=0;
	}/* P=zeros(1, max(max(A),max(B)))*/
	for (i=0; i<n1; i++){
		Position[(int)x[i]-1]=1;
	}/*P(x)=1*/

	for (i=0; i<n2; i++){
		if(Position[(int)y[i]-1]){
			Position[(int)y[i]-1]=0;
			OutPut->Length++;
			OutPut->Data[OutPut->Length-1] = y[i];
		}
	}
	mxFree(Position);
	return(OutPut);
}

/* The gateway function */
void mexFunction( int nlhs, mxArray *plhs[],
                  int nrhs, const mxArray *prhs[])
{

    double *inMatrix2;               /* 1xN input matrix */
	double *inMatrix1;				/* 1xN input matrix */
	double *outMatrix;
    size_t cols1;                   /* size of matrix */
	size_t cols2;                   /* size of matrix */
	size_t cols;
	int i =0;

    /* check for proper number of arguments */
    if(nrhs!=2) {
        mexErrMsgIdAndTxt("MyToolbox:arrayProduct:nrhs","Two inputs required.");
    }
    if(nlhs!=1) {
        mexErrMsgIdAndTxt("MyToolbox:arrayProduct:nlhs","One output required.");
    }
    /* make sure the first input argument is type double */
    if( !mxIsDouble(prhs[0]) || 
         mxIsComplex(prhs[0]) ) {
        mexErrMsgIdAndTxt("MyToolbox:arrayProduct:notScalar","Input matrix1 must be type double.");
    }
    
    /* make sure the second input argument is type double */
    if( !mxIsDouble(prhs[1]) || 
         mxIsComplex(prhs[1])) {
        mexErrMsgIdAndTxt("MyToolbox:arrayProduct:notDouble","Input matrix2 must be type double.");
    }
    
    /* check that number of rows in second input argument is 1 */
    if(mxGetM(prhs[1])!=1) {
        mexErrMsgIdAndTxt("MyToolbox:arrayProduct:notRowVector","Input must be a row vector.");
    }
    if(mxGetM(prhs[0])!=1){
		mexErrMsgIdAndTxt("MyToolbox:arrayProduct:notRowVector","Input must be a row vector.");
	}
    /* get the value of the first matrix  */
    inMatrix1 = mxGetPr(prhs[0]);

    /* create a pointer to the real data in the input matrix  */
    inMatrix2 = mxGetPr(prhs[1]);

    /* get dimensions of the input matrix */
    cols1 = mxGetN(prhs[0]);
	cols2 = mxGetN(prhs[1]);
	cols=max(cols1,cols2);
    //* create the output matrix */


    /* get a pointer to the real data in the output matrix */


    /* call the computational routine */
	Vector *OutPut;
    OutPut = c_Intersect(inMatrix1,inMatrix2,(mwSize)cols1,(mwSize)cols2);
	plhs[0] = mxCreateDoubleMatrix(1,(mwSize)OutPut->Length,mxREAL);
	outMatrix = mxGetPr(plhs[0]);
	for (i=0; i<OutPut->Length; i++){
		outMatrix[i]=OutPut->Data[i];
	}
	mxFree(OutPut->Data);
	mxFree(OutPut);
	
}
