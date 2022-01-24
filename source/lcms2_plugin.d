//---------------------------------------------------------------------------------

import core.stdc.time;

import lcms2;

extern (C):

//
//  Little Color Management System
//  Copyright (c) 1998-2022 Marti Maria Saguer
//
// Permission is hereby granted, free of charge, to any person obtaining
// a copy of this software and associated documentation files (the "Software"),
// to deal in the Software without restriction, including without limitation
// the rights to use, copy, modify, merge, publish, distribute, sublicense,
// and/or sell copies of the Software, and to permit persons to whom the Software
// is furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO
// THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
// NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
// LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
// OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
// WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//
//---------------------------------------------------------------------------------
//
// This is the plug-in header file. Normal LittleCMS clients should not use it.
// It is provided for plug-in writers that may want to access the support
// functions to do low level operations. All plug-in related structures
// are defined here. Including this file forces to include the standard API too.

// Deal with Microsoft's attempt at deprecating C standard runtime functions

// We need some standard C functions.

// Vector & Matrix operations -----------------------------------------------------------------------

// Axis of the matrix/array. No specific meaning at all.
enum VX = 0;
enum VY = 1;
enum VZ = 2;

// Vectors
struct cmsVEC3
{
    cmsFloat64Number[3] n;
}

// 3x3 Matrix
struct cmsMAT3
{
    cmsVEC3[3] v;
}

void _cmsVEC3init (cmsVEC3* r, cmsFloat64Number x, cmsFloat64Number y, cmsFloat64Number z);
void _cmsVEC3minus (cmsVEC3* r, const(cmsVEC3)* a, const(cmsVEC3)* b);
void _cmsVEC3cross (cmsVEC3* r, const(cmsVEC3)* u, const(cmsVEC3)* v);
cmsFloat64Number _cmsVEC3dot (const(cmsVEC3)* u, const(cmsVEC3)* v);
cmsFloat64Number _cmsVEC3length (const(cmsVEC3)* a);
cmsFloat64Number _cmsVEC3distance (const(cmsVEC3)* a, const(cmsVEC3)* b);

void _cmsMAT3identity (cmsMAT3* a);
cmsBool _cmsMAT3isIdentity (const(cmsMAT3)* a);
void _cmsMAT3per (cmsMAT3* r, const(cmsMAT3)* a, const(cmsMAT3)* b);
cmsBool _cmsMAT3inverse (const(cmsMAT3)* a, cmsMAT3* b);
cmsBool _cmsMAT3solve (cmsVEC3* x, cmsMAT3* a, cmsVEC3* b);
void _cmsMAT3eval (cmsVEC3* r, const(cmsMAT3)* a, const(cmsVEC3)* v);

// MD5 low level  -------------------------------------------------------------------------------------

cmsHANDLE cmsMD5alloc (cmsContext ContextID);
void cmsMD5add (cmsHANDLE Handle, const(cmsUInt8Number)* buf, cmsUInt32Number len);
void cmsMD5finish (cmsProfileID* ProfileID, cmsHANDLE Handle);

// Error logging  -------------------------------------------------------------------------------------

void cmsSignalError (cmsContext ContextID, cmsUInt32Number ErrorCode, const(char)* ErrorText, ...);

// Memory management ----------------------------------------------------------------------------------

void* _cmsMalloc (cmsContext ContextID, cmsUInt32Number size);
void* _cmsMallocZero (cmsContext ContextID, cmsUInt32Number size);
void* _cmsCalloc (cmsContext ContextID, cmsUInt32Number num, cmsUInt32Number size);
void* _cmsRealloc (cmsContext ContextID, void* Ptr, cmsUInt32Number NewSize);
void _cmsFree (cmsContext ContextID, void* Ptr);
void* _cmsDupMem (cmsContext ContextID, const(void)* Org, cmsUInt32Number size);

// I/O handler ----------------------------------------------------------------------------------

struct _cms_io_handler
{
    void* stream; // Associated stream, which is implemented differently depending on media.

    cmsContext ContextID;
    cmsUInt32Number UsedSpace;
    cmsUInt32Number ReportedSize;
    char[cmsMAX_PATH] PhysicalFile;

    cmsUInt32Number function (
        _cms_io_handler* iohandler,
        void* Buffer,
        cmsUInt32Number size,
        cmsUInt32Number count) Read;
    cmsBool function (_cms_io_handler* iohandler, cmsUInt32Number offset) Seek;
    cmsBool function (_cms_io_handler* iohandler) Close;
    cmsUInt32Number function (_cms_io_handler* iohandler) Tell;
    cmsBool function (
        _cms_io_handler* iohandler,
        cmsUInt32Number size,
        const(void)* Buffer) Write;
}

// Endianness adjust functions
cmsUInt16Number _cmsAdjustEndianess16 (cmsUInt16Number Word);
cmsUInt32Number _cmsAdjustEndianess32 (cmsUInt32Number Value);
void _cmsAdjustEndianess64 (cmsUInt64Number* Result, cmsUInt64Number* QWord);

// Helper IO functions
cmsBool _cmsReadUInt8Number (cmsIOHANDLER* io, cmsUInt8Number* n);
cmsBool _cmsReadUInt16Number (cmsIOHANDLER* io, cmsUInt16Number* n);
cmsBool _cmsReadUInt32Number (cmsIOHANDLER* io, cmsUInt32Number* n);
cmsBool _cmsReadFloat32Number (cmsIOHANDLER* io, cmsFloat32Number* n);
cmsBool _cmsReadUInt64Number (cmsIOHANDLER* io, cmsUInt64Number* n);
cmsBool _cmsRead15Fixed16Number (cmsIOHANDLER* io, cmsFloat64Number* n);
cmsBool _cmsReadXYZNumber (cmsIOHANDLER* io, cmsCIEXYZ* XYZ);
cmsBool _cmsReadUInt16Array (cmsIOHANDLER* io, cmsUInt32Number n, cmsUInt16Number* Array);

cmsBool _cmsWriteUInt8Number (cmsIOHANDLER* io, cmsUInt8Number n);
cmsBool _cmsWriteUInt16Number (cmsIOHANDLER* io, cmsUInt16Number n);
cmsBool _cmsWriteUInt32Number (cmsIOHANDLER* io, cmsUInt32Number n);
cmsBool _cmsWriteFloat32Number (cmsIOHANDLER* io, cmsFloat32Number n);
cmsBool _cmsWriteUInt64Number (cmsIOHANDLER* io, cmsUInt64Number* n);
cmsBool _cmsWrite15Fixed16Number (cmsIOHANDLER* io, cmsFloat64Number n);
cmsBool _cmsWriteXYZNumber (cmsIOHANDLER* io, const(cmsCIEXYZ)* XYZ);
cmsBool _cmsWriteUInt16Array (cmsIOHANDLER* io, cmsUInt32Number n, const(cmsUInt16Number)* Array);

// ICC base tag
struct _cmsTagBase
{
    cmsTagTypeSignature sig;
    cmsInt8Number[4] reserved;
}

// Type base helper functions
cmsTagTypeSignature _cmsReadTypeBase (cmsIOHANDLER* io);
cmsBool _cmsWriteTypeBase (cmsIOHANDLER* io, cmsTagTypeSignature sig);

// Alignment functions
cmsBool _cmsReadAlignment (cmsIOHANDLER* io);
cmsBool _cmsWriteAlignment (cmsIOHANDLER* io);

// To deal with text streams. 2K at most
cmsBool _cmsIOPrintf (cmsIOHANDLER* io, const(char)* frm, ...);

// Fixed point helper functions
cmsFloat64Number _cms8Fixed8toDouble (cmsUInt16Number fixed8);
cmsUInt16Number _cmsDoubleTo8Fixed8 (cmsFloat64Number val);

cmsFloat64Number _cms15Fixed16toDouble (cmsS15Fixed16Number fix32);
cmsS15Fixed16Number _cmsDoubleTo15Fixed16 (cmsFloat64Number v);

// Date/time helper functions
void _cmsEncodeDateTimeNumber (cmsDateTimeNumber* Dest, const(tm)* Source);
void _cmsDecodeDateTimeNumber (const(cmsDateTimeNumber)* Source, tm* Dest);

//----------------------------------------------------------------------------------------------------------

// Shared callbacks for user data
alias _cmsFreeUserDataFn = void function (cmsContext ContextID, void* Data);
alias _cmsDupUserDataFn = void* function (cmsContext ContextID, const(void)* Data);

//----------------------------------------------------------------------------------------------------------

// Plug-in foundation
enum cmsPluginMagicNumber = 0x61637070; // 'acpp'

enum cmsPluginMemHandlerSig = 0x6D656D48; // 'memH'
enum cmsPluginInterpolationSig = 0x696E7048; // 'inpH'
enum cmsPluginParametricCurveSig = 0x70617248; // 'parH'
enum cmsPluginFormattersSig = 0x66726D48; // 'frmH
enum cmsPluginTagTypeSig = 0x74797048; // 'typH'
enum cmsPluginTagSig = 0x74616748; // 'tagH'
enum cmsPluginRenderingIntentSig = 0x696E7448; // 'intH'
enum cmsPluginMultiProcessElementSig = 0x6D706548; // 'mpeH'
enum cmsPluginOptimizationSig = 0x6F707448; // 'optH'
enum cmsPluginTransformSig = 0x7A666D48; // 'xfmH'
enum cmsPluginMutexSig = 0x6D747A48; // 'mtxH'

struct _cmsPluginBaseStruct
{
    cmsUInt32Number Magic; // 'acpp' signature
    cmsUInt32Number ExpectedVersion; // Expected version of LittleCMS
    cmsUInt32Number Type; // Type of plug-in
    _cmsPluginBaseStruct* Next; // For multiple plugin definition. NULL for end of list.
}

alias cmsPluginBase = _cmsPluginBaseStruct;

// Maximum number of types in a plugin array
enum MAX_TYPES_IN_LCMS_PLUGIN = 20;

//----------------------------------------------------------------------------------------------------------

// Memory handler. Each new plug-in type replaces current behaviour

alias _cmsMallocFnPtrType = void* function (cmsContext ContextID, cmsUInt32Number size);
alias _cmsFreeFnPtrType = void function (cmsContext ContextID, void* Ptr);
alias _cmsReallocFnPtrType = void* function (cmsContext ContextID, void* Ptr, cmsUInt32Number NewSize);

alias _cmsMalloZerocFnPtrType = void* function (cmsContext ContextID, cmsUInt32Number size);
alias _cmsCallocFnPtrType = void* function (cmsContext ContextID, cmsUInt32Number num, cmsUInt32Number size);
alias _cmsDupFnPtrType = void* function (cmsContext ContextID, const(void)* Org, cmsUInt32Number size);

struct cmsPluginMemHandler
{
    cmsPluginBase base;

    // Required
    _cmsMallocFnPtrType MallocPtr;
    _cmsFreeFnPtrType FreePtr;
    _cmsReallocFnPtrType ReallocPtr;

    // Optional
    _cmsMalloZerocFnPtrType MallocZeroPtr;
    _cmsCallocFnPtrType CallocPtr;
    _cmsDupFnPtrType DupPtr;
}

// ------------------------------------------------------------------------------------------------------------------

// Interpolation. 16 bits and floating point versions.

// Interpolation callbacks

// 16 bits forward interpolation. This function performs precision-limited linear interpolation
// and is supposed to be quite fast. Implementation may be tetrahedral or trilinear, and plug-ins may
// choose to implement any other interpolation algorithm.
alias _cmsInterpFn16 = void function (
    const(cmsUInt16Number)[] Input,
    cmsUInt16Number[] Output,
    const(_cms_interp_struc)* p);

// Floating point forward interpolation. Full precision interpolation using floats. This is not a
// time critical function. Implementation may be tetrahedral or trilinear, and plug-ins may
// choose to implement any other interpolation algorithm.
alias _cmsInterpFnFloat = void function (
    const(cmsFloat32Number)[] Input,
    cmsFloat32Number[] Output,
    const(_cms_interp_struc)* p);

// This type holds a pointer to an interpolator that can be either 16 bits or float
union cmsInterpFunction
{
    _cmsInterpFn16 Lerp16; // Forward interpolation in 16 bits
    _cmsInterpFnFloat LerpFloat; // Forward interpolation in floating point
}

// Flags for interpolator selection
enum CMS_LERP_FLAGS_16BITS = 0x0000; // The default
enum CMS_LERP_FLAGS_FLOAT = 0x0001; // Requires different implementation
enum CMS_LERP_FLAGS_TRILINEAR = 0x0100; // Hint only

enum MAX_INPUT_DIMENSIONS = 15;

struct _cms_interp_struc
{
    // Used on all interpolations. Supplied by lcms2 when calling the interpolation function

    cmsContext ContextID; // The calling thread

    cmsUInt32Number dwFlags; // Keep original flags
    cmsUInt32Number nInputs; // != 1 only in 3D interpolation
    cmsUInt32Number nOutputs; // != 1 only in 3D interpolation

    cmsUInt32Number[MAX_INPUT_DIMENSIONS] nSamples; // Valid on all kinds of tables
    cmsUInt32Number[MAX_INPUT_DIMENSIONS] Domain; // Domain = nSamples - 1

    cmsUInt32Number[MAX_INPUT_DIMENSIONS] opta; // Optimization for 3D CLUT. This is the number of nodes premultiplied for each
    // dimension. For example, in 7 nodes, 7, 7^2 , 7^3, 7^4, etc. On non-regular
    // Samplings may vary according of the number of nodes for each dimension.

    const(void)* Table; // Points to the actual interpolation table
    cmsInterpFunction Interpolation; // Points to the function to do the interpolation
}

alias cmsInterpParams = _cms_interp_struc;

// Interpolators factory
alias cmsInterpFnFactory = cmsInterpFunction function (cmsUInt32Number nInputChannels, cmsUInt32Number nOutputChannels, cmsUInt32Number dwFlags);

// The plug-in
struct cmsPluginInterpolation
{
    cmsPluginBase base;

    // Points to a user-supplied function which implements the factory
    cmsInterpFnFactory InterpolatorsFactory;
}

//----------------------------------------------------------------------------------------------------------

// Parametric curves. A negative type means same function but analytically inverted. Max. number of params is 10

// Evaluator callback for user-supplied parametric curves. May implement more than one type
alias cmsParametricCurveEvaluator = double function (cmsInt32Number Type, const(cmsFloat64Number)[10] Params, cmsFloat64Number R);

// Plug-in may implement an arbitrary number of parametric curves
struct cmsPluginParametricCurves
{
    cmsPluginBase base;

    cmsUInt32Number nFunctions; // Number of supported functions
    cmsUInt32Number[MAX_TYPES_IN_LCMS_PLUGIN] FunctionTypes; // The identification types
    cmsUInt32Number[MAX_TYPES_IN_LCMS_PLUGIN] ParameterCount; // Number of parameters for each function

    cmsParametricCurveEvaluator Evaluator; // The evaluator
}

//----------------------------------------------------------------------------------------------------------

// Formatters. This plug-in adds new handlers, replacing them if they already exist. Formatters dealing with
// cmsFloat32Number (bps = 4) or double (bps = 0) types are requested via FormatterFloat callback. Others come across
// Formatter16 callback

struct _cmstransform_struct;

alias cmsFormatter16 = ubyte* function (
    _cmstransform_struct* CMMcargo,
    cmsUInt16Number[] Values,
    cmsUInt8Number* Buffer,
    cmsUInt32Number Stride);

alias cmsFormatterFloat = ubyte* function (
    _cmstransform_struct* CMMcargo,
    cmsFloat32Number[] Values,
    cmsUInt8Number* Buffer,
    cmsUInt32Number Stride);

// This type holds a pointer to a formatter that can be either 16 bits or cmsFloat32Number
union cmsFormatter
{
    cmsFormatter16 Fmt16;
    cmsFormatterFloat FmtFloat;
}

enum CMS_PACK_FLAGS_16BITS = 0x0000;
enum CMS_PACK_FLAGS_FLOAT = 0x0001;

enum cmsFormatterDirection
{
    cmsFormatterInput = 0,
    cmsFormatterOutput = 1
}

// Specific type, i.e. TYPE_RGB_8
alias cmsFormatterFactory = cmsFormatter function (
    cmsUInt32Number Type,
    cmsFormatterDirection Dir,
    cmsUInt32Number dwFlags); // precision

// Plug-in may implement an arbitrary number of formatters
struct cmsPluginFormatters
{
    cmsPluginBase base;
    cmsFormatterFactory FormattersFactory;
}

//----------------------------------------------------------------------------------------------------------

// Tag type handler. Each type is free to return anything it wants, and it is up to the caller to
// know in advance what is the type contained in the tag.
struct _cms_typehandler_struct
{
    cmsTagTypeSignature Signature; // The signature of the type

    // Allocates and reads items
    void* function (
        _cms_typehandler_struct* self,
        cmsIOHANDLER* io,
        cmsUInt32Number* nItems,
        cmsUInt32Number SizeOfTag) ReadPtr;

    // Writes n Items
    cmsBool function (
        _cms_typehandler_struct* self,
        cmsIOHANDLER* io,
        void* Ptr,
        cmsUInt32Number nItems) WritePtr;

    // Duplicate an item or array of items
    void* function (
        _cms_typehandler_struct* self,
        const(void)* Ptr,
        cmsUInt32Number n) DupPtr;

    // Free all resources
    void function (_cms_typehandler_struct* self, void* Ptr) FreePtr;

    // Additional parameters used by the calling thread
    cmsContext ContextID;
    cmsUInt32Number ICCVersion;
}

alias cmsTagTypeHandler = _cms_typehandler_struct;

// Each plug-in implements a single type
struct cmsPluginTagType
{
    cmsPluginBase base;
    cmsTagTypeHandler Handler;
}

//----------------------------------------------------------------------------------------------------------

// This is the tag plugin, which identifies tags. For writing, a pointer to function is provided.
// This function should return the desired type for this tag, given the version of profile
// and the data being serialized.
struct cmsTagDescriptor
{
    cmsUInt32Number ElemCount; // If this tag needs an array, how many elements should keep

    // For reading.
    cmsUInt32Number nSupportedTypes; // In how many types this tag can come (MAX_TYPES_IN_LCMS_PLUGIN maximum)
    cmsTagTypeSignature[MAX_TYPES_IN_LCMS_PLUGIN] SupportedTypes;

    // For writing
    cmsTagTypeSignature function (cmsFloat64Number ICCVersion, const(void)* Data) DecideType;
}

// Plug-in implements a single tag
struct cmsPluginTag
{
    cmsPluginBase base;

    cmsTagSignature Signature;
    cmsTagDescriptor Descriptor;
}

//----------------------------------------------------------------------------------------------------------

// Custom intents. This function should join all profiles specified in the array in
// a single LUT. Any custom intent in the chain redirects to custom function. If more than
// one custom intent is found, the one located first is invoked. Usually users should use only one
// custom intent, so mixing custom intents in same multiprofile transform is not supported.

alias cmsIntentFn = _cmsPipeline_struct* function (
    cmsContext ContextID,
    cmsUInt32Number nProfiles,
    cmsUInt32Number[] Intents,
    cmsHPROFILE[] hProfiles,
    cmsBool[] BPC,
    cmsFloat64Number[] AdaptationStates,
    cmsUInt32Number dwFlags);

// Each plug-in defines a single intent number.
struct cmsPluginRenderingIntent
{
    cmsPluginBase base;
    cmsUInt32Number Intent;
    cmsIntentFn Link;
    char[256] Description;
}

// The default ICC intents (perceptual, saturation, rel.col and abs.col)
cmsPipeline* _cmsDefaultICCintents (
    cmsContext ContextID,
    cmsUInt32Number nProfiles,
    cmsUInt32Number* Intents,
    cmsHPROFILE* hProfiles,
    cmsBool* BPC,
    cmsFloat64Number* AdaptationStates,
    cmsUInt32Number dwFlags);

//----------------------------------------------------------------------------------------------------------

// Pipelines, Multi Process Elements.

alias _cmsStageEvalFn = void function (const(cmsFloat32Number)[] In, cmsFloat32Number[] Out, const(cmsStage)* mpe);
alias _cmsStageDupElemFn = void* function (cmsStage* mpe);
alias _cmsStageFreeElemFn = void function (cmsStage* mpe);

// This function allocates a generic MPE

// Points to fn that evaluates the element (always in floating point)
// Points to a fn that duplicates the stage
// Points to a fn that sets the element free
cmsStage* _cmsStageAllocPlaceholder (
    cmsContext ContextID,
    cmsStageSignature Type,
    cmsUInt32Number InputChannels,
    cmsUInt32Number OutputChannels,
    _cmsStageEvalFn EvalPtr,
    _cmsStageDupElemFn DupElemPtr,
    _cmsStageFreeElemFn FreePtr,
    void* Data); // A generic pointer to whatever memory needed by the element
struct cmsPluginMultiProcessElement
{
    cmsPluginBase base;
    cmsTagTypeHandler Handler;
}

// Data kept in "Element" member of cmsStage

// Curves
struct _cmsStageToneCurvesData
{
    cmsUInt32Number nCurves;
    cmsToneCurve** TheCurves;
}

// Matrix
struct _cmsStageMatrixData
{
    cmsFloat64Number* Double; // floating point for the matrix
    cmsFloat64Number* Offset; // The offset
}

// CLUT
struct _cmsStageCLutData
{
    // Can have only one of both representations at same time
    // Points to the table 16 bits table
    // Points to the cmsFloat32Number table
    union _Anonymous_0
    {
        cmsUInt16Number* T;
        cmsFloat32Number* TFloat;
    }

    _Anonymous_0 Tab;

    cmsInterpParams* Params;
    cmsUInt32Number nEntries;
    cmsBool HasFloatValues;
}

//----------------------------------------------------------------------------------------------------------
// Optimization. Using this plug-in, additional optimization strategies may be implemented.
// The function should return TRUE if any optimization is done on the LUT, this terminates
// the optimization  search. Or FALSE if it is unable to optimize and want to give a chance
// to the rest of optimizers.

alias _cmsOPToptimizeFn = int function (
    cmsPipeline** Lut,
    cmsUInt32Number Intent,
    cmsUInt32Number* InputFormat,
    cmsUInt32Number* OutputFormat,
    cmsUInt32Number* dwFlags);

// Pipeline Evaluator (in 16 bits)
alias _cmsPipelineEval16Fn = void function (
    const(cmsUInt16Number)[] In,
    cmsUInt16Number[] Out,
    const(void)* Data);

// Pipeline Evaluator (in floating point)
alias _cmsPipelineEvalFloatFn = void function (
    const(cmsFloat32Number)[] In,
    cmsFloat32Number[] Out,
    const(void)* Data);

// This function may be used to set the optional evaluator and a block of private data. If private data is being used, an optional
// duplicator and free functions should also be specified in order to duplicate the LUT construct. Use NULL to inhibit such functionality.

void _cmsPipelineSetOptimizationParameters (
    cmsPipeline* Lut,
    _cmsPipelineEval16Fn Eval16,
    void* PrivateData,
    _cmsFreeUserDataFn FreePrivateDataFn,
    _cmsDupUserDataFn DupPrivateDataFn);

struct cmsPluginOptimization
{
    cmsPluginBase base;

    // Optimize entry point
    _cmsOPToptimizeFn OptimizePtr;
}

//----------------------------------------------------------------------------------------------------------
// Full xform

struct cmsStride
{
    cmsUInt32Number BytesPerLineIn;
    cmsUInt32Number BytesPerLineOut;
    cmsUInt32Number BytesPerPlaneIn;
    cmsUInt32Number BytesPerPlaneOut;
}

// Legacy function, handles just ONE scanline.
alias _cmsTransformFn = void function (
    _cmstransform_struct* CMMcargo,
    const(void)* InputBuffer,
    void* OutputBuffer,
    cmsUInt32Number Size,
    cmsUInt32Number Stride); // Stride in bytes to the next plana in planar formats

alias _cmsTransform2Fn = void function (
    _cmstransform_struct* CMMcargo,
    const(void)* InputBuffer,
    void* OutputBuffer,
    cmsUInt32Number PixelsPerLine,
    cmsUInt32Number LineCount,
    const(cmsStride)* Stride);

alias _cmsTransformFactory = int function (
    _cmsTransformFn* xform,
    void** UserData,
    _cmsFreeUserDataFn* FreePrivateDataFn,
    cmsPipeline** Lut,
    cmsUInt32Number* InputFormat,
    cmsUInt32Number* OutputFormat,
    cmsUInt32Number* dwFlags);

alias _cmsTransform2Factory = int function (
    _cmsTransform2Fn* xform,
    void** UserData,
    _cmsFreeUserDataFn* FreePrivateDataFn,
    cmsPipeline** Lut,
    cmsUInt32Number* InputFormat,
    cmsUInt32Number* OutputFormat,
    cmsUInt32Number* dwFlags);

// Retrieve user data as specified by the factory
void _cmsSetTransformUserData (_cmstransform_struct* CMMcargo, void* ptr, _cmsFreeUserDataFn FreePrivateDataFn);
void* _cmsGetTransformUserData (_cmstransform_struct* CMMcargo);

// Retrieve formatters
void _cmsGetTransformFormatters16 (_cmstransform_struct* CMMcargo, cmsFormatter16* FromInput, cmsFormatter16* ToOutput);
void _cmsGetTransformFormattersFloat (_cmstransform_struct* CMMcargo, cmsFormatterFloat* FromInput, cmsFormatterFloat* ToOutput);

// Retrieve original flags
cmsUInt32Number _cmsGetTransformFlags (_cmstransform_struct* CMMcargo);

struct cmsPluginTransform
{
    cmsPluginBase base;

    // Transform entry point
    union _Anonymous_1
    {
        _cmsTransformFactory legacy_xform;
        _cmsTransform2Factory xform;
    }

    _Anonymous_1 factories;
}

//----------------------------------------------------------------------------------------------------------
// Mutex 

alias _cmsCreateMutexFnPtrType = void* function (cmsContext ContextID);
alias _cmsDestroyMutexFnPtrType = void function (cmsContext ContextID, void* mtx);
alias _cmsLockMutexFnPtrType = int function (cmsContext ContextID, void* mtx);
alias _cmsUnlockMutexFnPtrType = void function (cmsContext ContextID, void* mtx);

struct cmsPluginMutex
{
    cmsPluginBase base;

    _cmsCreateMutexFnPtrType CreateMutexPtr;
    _cmsDestroyMutexFnPtrType DestroyMutexPtr;
    _cmsLockMutexFnPtrType LockMutexPtr;
    _cmsUnlockMutexFnPtrType UnlockMutexPtr;
}

void* _cmsCreateMutex (cmsContext ContextID);
void _cmsDestroyMutex (cmsContext ContextID, void* mtx);
cmsBool _cmsLockMutex (cmsContext ContextID, void* mtx);
void _cmsUnlockMutex (cmsContext ContextID, void* mtx);

