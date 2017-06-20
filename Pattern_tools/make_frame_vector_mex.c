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
    int index,tmp1,tmp2,outputVectorLength;    
    int RC, GS, RCByte;
    int out[4], d[4];           

    
    //associate inputs   
    patternData = mxGetPr(prhs[0]);         
    //patternMap = mxDuplicateArray(prhs[1]);  
    
    //figure out dimensions   
    dataDims = mxGetDimensions(prhs[0]);   
    dataDimNum = mxGetNumberOfDimensions(prhs[0]);   
    
    dataRow = (int)dataDims[0];
    dataCol = (int)dataDims[1];
    //mexPrintf("dataRow %d, dataCol is %d\n", dataRow, dataCol);
    
//     /* check second input which is a structure array */
//     if(nrhs!=4)
//         mexErrMsgIdAndTxt( "MATLAB:phonebook:invalidNumInputs",
//                 "four input required.");
//     else if(nlhs > 4)
//         mexErrMsgIdAndTxt( "MATLAB:phonebook:maxlhs",
//                 "Too many output arguments.");
//     
//     if(!mxIsStruct(prhs[1]))
//         mexErrMsgIdAndTxt( "MATLAB:phonebook:inputNotStruct",
//                 "Input must be a structure.");
    
    /* get input arguments */
    nfields = mxGetNumberOfFields(prhs[1]);
    NStructElems = mxGetNumberOfElements(prhs[1]);
    /* allocate memory  for storing classIDflags */
    classIDflags = mxCalloc(nfields, sizeof(mxClassID));
    
//mexPrintf("nfields is %d, NStructElems is %d\n", nfields, NStructElems);    
//     /* check empty field, proper data type, and data type consistency;
//      * and get classID for each field. */
//     for(ifield=0; ifield<nfields; ifield++) {
//         for(jstruct = 0; jstruct < NStructElems; jstruct++) {
//             tmp = mxGetFieldByNumber(prhs[1], jstruct, ifield);
//             if(tmp == NULL) {
//                 mexPrintf("%s%d\t%s%d\n", "FIELD: ", ifield+1, "STRUCT INDEX :", jstruct+1);
//                 mexErrMsgIdAndTxt( "MATLAB:patternMap:fieldEmpty",
//                         "Above field is empty!");
//             }
//             if(jstruct==0) {
//                 if( (!mxIsNumeric(tmp)) || mxIsSparse(tmp)) {
//                     mexPrintf("%s%d\t%s%d\n", "FIELD: ", ifield+1, "STRUCT INDEX :", jstruct+1);
//                     mexErrMsgIdAndTxt( "MATLAB:patternMap:invalidField",
//                             "Above field must have numeric non-sparse data.");
//                 }
//                 classIDflags[ifield]=mxGetClassID(tmp);
//             } else {
//                 if (mxGetClassID(tmp) != classIDflags[ifield]) {
//                     mexPrintf("%s%d\t%s%d\n", "FIELD: ", ifield+1, "STRUCT INDEX :", jstruct+1);
//                     mexErrMsgIdAndTxt( "MATLAB:patternMap:invalidFieldType",
//                             "Inconsistent data type in above field!");
//                 } else if((mxIsComplex(tmp) || mxGetNumberOfElements(tmp)!=1)){
//                     mexPrintf("%s%d\t%s%d\n", "FIELD: ", ifield+1, "STRUCT INDEX :", jstruct+1);
//                     mexErrMsgIdAndTxt( "MATLAB:patternMap:fieldNotRealScalar",
//                             "Numeric data in above field must be scalar and noncomplex!");
//                 }
//             }
//         }
//     }
//     
//     /* allocate memory  for storing pointers */
//     fnames = mxCalloc(nfields, sizeof(*fnames));
//     /* get field name pointers */
//     for (ifield=0; ifield< nfields; ifield++){
//         fnames[ifield] = mxGetFieldNameByNumber(prhs[1],ifield);
//         mexPrintf("ifield is %d, and fnames is %s\n", ifield, fnames[ifield]);
//     }
    
    //row compression 
    RC = (int)mxGetScalar(prhs[2]);
    
    if (RC == 1)
        RCByte = 1;
    else 
        RCByte = 8;
            
    //gray-scale level 
    GS = (int)mxGetScalar(prhs[3]);
    //mexPrintf("RC is %d, RCByte is %d, GS is %d\n", RC, RCByte, GS); 
    
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
    
    //calculate output array
    panelCol = dataCol/8;
    panelRow = dataRow/RCByte;
    panelNum = panelCol*panelRow;
    
    outputVectorLength = panelNum*GS*RCByte;
    
    //associate outputs 
    plhs[0] = mxCreateNumericMatrix(1,outputVectorLength,mxUINT8_CLASS,mxREAL);
    convertedPatternData = (char *)mxGetPr(plhs[0]);
    
    
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

            out[0] = out[1] = out[2] = out[3] = 0;
            
            //K:row
            if (RC==0){
                for (k=0; k<8; ++k)
                {
                    index = 0;
                    d[0] = d[1] = d[2] = d[3] = 0;
                    tmp1 = (int)patternData[dataRow*(panelStartCol[i]+j-1)+panelStartRow[i]+k-1];
                    tmp2 = tmp1;
                    
                    while(tmp2>0)
                    {
                        d[index]=tmp2%2;
                        index++;
                        tmp2=tmp2/2;
                    }
                    
                    for(m=0; m<GS; ++m){
                        out[m] += d[m]*(1<<k);
                    }
                }
            }
            else{  //RC ==1
                index = 0;
                d[0] = d[1] = d[2] = d[3] = 0;
                tmp1 = (int)patternData[dataRow*(panelStartCol[i]+j-1)+panelStartRow[i]+k-1];
                tmp2 = tmp1;
                
                while(tmp2>0)
                {
                    d[index]=tmp2%2;
                    index++;
                    tmp2=tmp2/2;
                }
                
                //all rows has the same d value
                for(m=0; m<GS; ++m){
                    for (k=0; k<8; ++k){
                        out[m] += d[m]*(1<<k);
                    }
                }
            }
                
            //mexPrintf("input is %d, out[0] is  %d, out[1] is %d, out[2] is %d\n", tmp1, out[0], out[1], out[2]);
            for(m=0; m<GS; ++m){
                convertedPatternData[GS*RCByte*i+8*m+j] = out[GS-m-1];
            }

        }
        
    }
            
    mxFree((void *)panelID);
    mxFree((void *)panelStartRow);
    mxFree((void *)panelStartCol);
    mxFree(classIDflags);
 
    return; 
}