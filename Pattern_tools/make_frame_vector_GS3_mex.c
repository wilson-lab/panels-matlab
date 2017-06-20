#include "mex.h"
#include "matrix.h"

void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[])
{
    
    //declare variables   
    double *patternData, *patternMap; 
    char  * convertedPatternData;
    const mwSize *dataDims, *mapDims;      
    int dataRow, dataCol, dataFrame, dataDimNum; 
    int i, j, k, m, panelCol, panelRow, panelNum;
    
    const char **fnames;       /* pointers to field names */
    const mwSize *dims;
    mxArray    *tmp, *fout;
    char       *pdata=NULL;
    int        ifield, nfields;
    mxClassID  *classIDflags;
    mwIndex    jstruct;
    mwSize     NStructElems;
    mwSize     ndim;
    int *panelStartCol, *panelStartRow, *panelID;
    int index,tmp1,tmp2;
    int out[3], d[3];           
    
    //associate inputs   
    patternData = mxGetPr(prhs[0]);         
    //patternMap = mxDuplicateArray(prhs[1]);  
    
    //figure out dimensions   
    dataDims = mxGetDimensions(prhs[0]);   
    dataDimNum = mxGetNumberOfDimensions(prhs[0]);   
    
    dataRow = (int)dataDims[0];
    dataCol = (int)dataDims[1];
    
//     /* check second input which is a structure array */
//     if(nrhs!=4)
//         mexErrMsgIdAndTxt( "MATLAB:phonebook:invalidNumInputs",
//                 "two input required.");
//     else if(nlhs > 4)
//         mexErrMsgIdAndTxt( "MATLAB:phonebook:maxlhs",
//                 "Too many output arguments.");
//     else if(!mxIsStruct(prhs[1]))
//         mexErrMsgIdAndTxt( "MATLAB:phonebook:inputNotStruct",
//                 "Input must be a structure.");
    
    /* get input arguments */
    nfields = mxGetNumberOfFields(prhs[1]);
    NStructElems = mxGetNumberOfElements(prhs[1]);
    /* allocate memory  for storing classIDflags */
    classIDflags = mxCalloc(nfields, sizeof(mxClassID));
    

    panelID = mxCalloc(NStructElems, sizeof(double));
    panelStartRow = mxCalloc(NStructElems, sizeof(double));
    panelStartCol = mxCalloc(NStructElems, sizeof(double));    
    
    for(jstruct = 0; jstruct < NStructElems; ++jstruct) 
        {    
             tmp = mxGetFieldByNumber(prhs[1],jstruct,0);
             panelID[jstruct] = (int)mxGetScalar(tmp);
             tmp = mxGetFieldByNumber(prhs[1],jstruct,1);
             panelStartRow[jstruct] = (int)mxGetScalar(tmp);
             tmp = mxGetFieldByNumber(prhs[1],jstruct,2);
             panelStartCol[jstruct] = (int)mxGetScalar(tmp);
             
             //mexPrintf("panelID is %d, startRow is  %d, startCol is %d\n", panelID[jstruct], panelStartRow[jstruct], panelStartCol[jstruct]);                         
        }

    
    //associate outputs 
    plhs[0] = mxCreateNumericMatrix(1,1152,mxUINT8_CLASS,mxREAL);
    convertedPatternData = (char *)mxGetPr(plhs[0]);
    
    //calculate output array
    panelCol = dataCol/8;
    panelRow = dataRow/8;
    panelNum = panelCol*panelRow;
    
    ndim = mxGetNumberOfDimensions(prhs[1]);
    dims = mxGetDimensions(prhs[1]);
    
    if (panelNum != dims[1])
        mexPrintf("Number of panels are different in the pattern data and pattern map!\n");

    //one panel (8x8 data)
    for(i = 0; i < panelNum; ++i)
    {
        //J:column
        for (j=0; j<8; ++j)
        {

            out[0] = out[1] = out[2] = 0;
            
            //K:row
            for (k=0; k<8; ++k)
            {
                index = 0;            
                d[0] = d[1] = d[2] = 0;
                tmp1 = (int)patternData[32*(panelStartCol[i]+j-1)+panelStartRow[i]+k-1];
                tmp2 = tmp1;
                
                while(tmp2>0)
                {
                    d[index]=tmp2%2;
                    index++;
                    tmp2=tmp2/2;
                }
                
                out[0] += d[0]*(1<<k);
                out[1] += d[1]*(1<<k);
                out[2] += d[2]*(1<<k);
            }
            
            //mexPrintf("input is %d, out[0] is  %d, out[1] is %d, out[2] is %d\n", tmp1, out[0], out[1], out[2]);
            convertedPatternData[24*i+j] = out[2];
            convertedPatternData[24*i+8+j] = out[1];
            convertedPatternData[24*i+16+j] = out[0];
        }
        
    }

            
    mxFree((void *)panelID);
    mxFree((void *)panelStartRow);
    mxFree((void *)panelStartCol);
    mxFree(classIDflags);
    return;
    
    
}